resource "aws_vpc" "myapp" {
	 name = "aws_VPC"
     cidr_block = "10.100.0.0/16"
     tags {
        Name = "myVPC"
    }
}


