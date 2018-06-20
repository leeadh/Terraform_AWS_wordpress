resource "aws_iam_user" "docker-logs" {
  name = "docker-logs"
  path = "/system/"
}

resource "aws_iam_access_key" "docker-logs" {
  user = "${aws_iam_user.docker-logs.name}"
}

resource "aws_iam_user_policy" "docker-logs" {
  name = "test"
  user = "${aws_iam_user.docker-logs.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "docker-logs" {
  name = "docker-logs"

  tags {
    Environment = "production"
    Application = "serviceA"
  }
}

resource "aws_cloudwatch_log_stream" "docker-logs" {
  name           = "docker-logs"
  log_group_name = "${aws_cloudwatch_log_group.docker-logs.name}"
}