data "aws_ami" "amazon" {
  most_recent = true
  name_regex = "amzn2-ami-hvm-[0-9.]+.0-x86_64-gp2"
  owners = ["137112412989"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "aws_demo" {
  ami                         = data.aws_ami.amazon.id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.aws_demo_sg.id]
  subnet_id                   = aws_subnet.demo-sub-1.id
  associate_public_ip_address = true

  tags = {
    purpose = var.tag_purpose
  }

//  remote exec step that forces terraform to pause until instance is accessible via ssh
  provisioner "remote-exec" {
    inline = ["sudo yum -y install vim"]
    connection {
      host = self.public_ip
      type = "ssh"
      user = "ec2-user"
      private_key = file("/home/osboxes/.aws/dev-nonprod.pem")
    }
  }

//  Execute ansible scripts to install docker
  provisioner "local-exec" {
    command = "cd ../../../Common/scripts; bash ./install_docker.sh 'self.public_ip'"
  }

}