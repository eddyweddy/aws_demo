//IAM roles with Systems manager and cloudwatch metrics permissions that will be attached to a instance profile
// The setup is create a role, attach pre-canned AWS policies to them that grant the permissions we need,
// Then attach the role to a instance profile that will in turn be used by any EC2 we create
resource "aws_iam_role" "aws_demo_ecs_role" {
  name = "ecsInstanceRole"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    purpose = var.tag_purpose
  }
}

// attach Systems manager operations policy to our IAM role
resource "aws_iam_role_policy_attachment" "aws_demo_ssm_attach" {
  role       = aws_iam_role.aws_demo_ecs_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
// attach cloudwatch agent policy to our IAM role
resource "aws_iam_role_policy_attachment" "aws_demo_cloudwatch_attach" {
  role       = aws_iam_role.aws_demo_ecs_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

// Create instance profile that will use the role created
resource "aws_iam_instance_profile" "aws_demo_profile" {
  name = "demoECSserverProfile"
  role = aws_iam_role.aws_demo_ecs_role.name
}