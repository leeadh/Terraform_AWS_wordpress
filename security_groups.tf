resource "aws_security_group" "allow_ssh" {
  name = "allow_all"
  description = "Allow inbound SSH traffic"
  vpc_id = "${aws_vpc.myapp.id}"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Allow SSH"
  }
}

resource "aws_security_group" "web_server" {
  name = "web server"
  description = "Allow HTTP and HTTPS traffic in, browser access out."
  vpc_id = "${aws_vpc.myapp.id}"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}


# Our elb security group to access
# the ELB over HTTP
resource "aws_security_group" "elb" {
  name        = "elb_sg"
  description = "Used in the terraform"

  vpc_id = "${aws_vpc.myapp.id}"

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ensure the VPC has an Internet gateway or this step will fail
  depends_on = ["aws_internet_gateway.gw"]
}



resource "aws_security_group" "myapp_mysql_rds" {
  name = "sec group mysql"
  description = "Allow access to MySQL RDS"
  vpc_id = "${aws_vpc.myapp.id}"

  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups  = ["${aws_security_group.web_server.id}"]
  }

  egress {
      from_port = 1024
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}