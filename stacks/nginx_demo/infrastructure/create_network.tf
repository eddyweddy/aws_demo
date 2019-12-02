
resource "aws_vpc" "aws_demo" {
  cidr_block = "10.1.0.0/24"
}

resource "aws_subnet" "demo-sub-1" {
  vpc_id = aws_vpc.aws_demo.id
  cidr_block = "10.1.0.0/26"
  map_public_ip_on_launch = "true"
}

resource "aws_internet_gateway" "aws_demo_igw" {
  vpc_id = aws_vpc.aws_demo.id
}

resource "aws_route_table" "aws_demo_rt" {
  vpc_id = aws_vpc.aws_demo.id
  route {
//    Grant access to the entire internet
//    TODO: Update this once we have a better idea of access levels
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_demo_igw.id
  }
}

resource "aws_route_table_association" "aws_demo_public_subnet" {
  route_table_id = aws_route_table.aws_demo_rt.id
  subnet_id = aws_subnet.demo-sub-1.id
}