output "rdshost" {
  value = "${aws_db_instance.wpdb.address}"
}