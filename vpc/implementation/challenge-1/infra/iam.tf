resource "aws_iam_instance_profile" "instances_profile" {
  name = "instances_profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_policy" "policy" {
  name        = "allow_ssm"
  path        = "/"
  description = "Policy to allow System Manager"

  policy = file("./policy.json")
}

resource "aws_iam_role" "role" {
  name = "instance_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}