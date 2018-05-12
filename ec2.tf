resource "aws_instance" "web01" {
    ##ami = "ami-846144f8"
    ami = "${data.aws_ami.ubuntu_ami.id}"
    instance_type = "t1.micro"
    subnet_id = "${aws_subnet.public_1a.id}"
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.web_server.id}","${aws_security_group.allow_ssh.id}"]
    key_name = "key"
    tags {
        Name = "web01"
    }
    user_data = "${data.template_file.bootstrap.rendered}"
}

resource "aws_instance" "web02" {
    ##ami = "ami-846144f8"
    ami = "${data.aws_ami.ubuntu_ami.id}"
    instance_type = "t1.micro"
    subnet_id = "${aws_subnet.public_1b.id}"
    associate_public_ip_address = true
    vpc_security_group_ids = ["${aws_security_group.web_server.id}","${aws_security_group.allow_ssh.id}"]
    key_name = "key"
    tags {
        Name = "web02"
    }
    user_data = "${data.template_file.bootstrap.rendered}"
}



##Lookup AMI

data "aws_ami" "ubuntu_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu-trusty-14.04-amd64-server*"]
  }
}


data "template_file" "bootstrap" {
    template = "${file("bootstrap.tpl")}"
      vars {
        dbhost = "${aws_db_instance.wpdb.address}"
      }
}