resource "aws_vpc" "myapp" {
     cidr_block = "10.100.0.0/16"
     tags {
        Name = "myVPC"
    }
}


