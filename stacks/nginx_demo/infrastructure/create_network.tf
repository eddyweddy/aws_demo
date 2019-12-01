
resource "aws_vpc" "aws_demo" {
  cidr_block = "10.1.0.0/24"
}

resource "aws_subnet" "demo-sub-1" {
  vpc_id = "${aws_vpc.aws_demo.id}"
  cidr_block = "10.1.0.0/26"
  map_public_ip_on_launch = “true”
}