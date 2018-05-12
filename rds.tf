resource "aws_db_subnet_group" "myapp-db" {
    name = "main"
    description = "Our main group of subnets"
    subnet_ids = ["${aws_subnet.public_1a.id}", "${aws_subnet.public_1b.id}"]
    tags {
        Name = "MyApp DB subnet group"
    }
}



resource "aws_db_instance" "wpdb" {
    identifier = "wpdb"
    allocated_storage = "10"
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t2.micro"
    name = "wpdb"
    username = "wpdb"
    password = "wpdbwpdb"
    vpc_security_group_ids = ["${aws_security_group.myapp_mysql_rds.id}"]     
    db_subnet_group_name = "${aws_db_subnet_group.myapp-db.id}"
}


