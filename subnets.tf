
# public subnet 1A
resource "aws_subnet" "public_1a" {
    vpc_id = "${aws_vpc.myapp.id}"
    cidr_block = "10.100.0.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-southeast-1a"

    tags {
        Name = "Public 1A"
    }
}

# public subnet 1B
resource "aws_subnet" "public_1b" {
    vpc_id = "${aws_vpc.myapp.id}"
    cidr_block = "10.100.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-southeast-1b"

    tags {
        Name = "Public 1B"
    }
}


# IGW
resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.myapp.id}"

    tags {
        Name = "myapp gw"
    }
}

# IGW route table
resource "aws_route_table" "pub_igw_route_table" {
    vpc_id = "${aws_vpc.myapp.id}"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.gw.id}"
    }
}

# route table associations
# public route tables
resource "aws_route_table_association" "public-a" {
    subnet_id = "${aws_subnet.public_1a.id}"
    route_table_id = "${aws_route_table.pub_igw_route_table.id}"
}

resource "aws_route_table_association" "public-b" {
    subnet_id = "${aws_subnet.public_1b.id}"
    route_table_id = "${aws_route_table.pub_igw_route_table.id}"
}

