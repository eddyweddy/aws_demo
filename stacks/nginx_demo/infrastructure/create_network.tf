// Creates a simple VPC with 1 subnet, a gateway for internet access and a route to that gateway,
// which has to be associated to our subnet
// Also creating a basic security group that allows us to SSH and http into and from our EC2s.
// The security group has world access as I do not know which network to restrict to.
resource "aws_vpc" "aws_demo" {
  cidr_block = "10.1.0.0/24"
  tags = {
    purpose = var.tag_purpose
  }
}

resource "aws_subnet" "demo-sub-1" {
  vpc_id = aws_vpc.aws_demo.id
  cidr_block = "10.1.0.0/26"
  map_public_ip_on_launch = "true"
  tags = {
    purpose = var.tag_purpose
  }
}

resource "aws_internet_gateway" "aws_demo_igw" {
  vpc_id = aws_vpc.aws_demo.id
  tags = {
    purpose = var.tag_purpose
  }
}

resource "aws_route_table" "aws_demo_rt" {
  vpc_id = aws_vpc.aws_demo.id
  route {
//    Grant access to the entire internet
//    TODO: Update this once we have a better idea of access levels
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_demo_igw.id
  }
  tags = {
    purpose = var.tag_purpose
  }
}

resource "aws_route_table_association" "aws_demo_public_subnet" {
  route_table_id = aws_route_table.aws_demo_rt.id
  subnet_id = aws_subnet.demo-sub-1.id
}

resource "aws_security_group" "aws_demo_sg" {
  vpc_id = aws_vpc.aws_demo.id
//  allow http from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = var.world_access
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = var.world_access
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = var.world_access
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = var.world_access
  }
  tags = {
    purpose = var.tag_purpose
  }
}