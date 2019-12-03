// Creates a network load balancer, listener and target group to health check our instances
// TODO : Should attach to a ASG long term
resource "aws_lb" "aws-demo-docker" {
  name = "aws-demo-docker-lb"
  subnets = [aws_subnet.demo-sub-1.id, aws_subnet.demo-sub-2.id]
  load_balancer_type = "network"
  internal = false
  tags = {
    purpose = var.tag_purpose
  }
}

resource "aws_lb_target_group" "aws-demo-docker" {
  port          = 80
  protocol      = "TCP"
  vpc_id        = aws_vpc.aws_demo.id
  target_type   = "instance"
  tags = {
    purpose = var.tag_purpose
  }
}

resource "aws_lb_target_group_attachment" "aws-demo-docker-1" {
  target_group_arn  = aws_lb_target_group.aws-demo-docker.arn
  target_id         = aws_instance.aws_demo.id
  port              = 80
}

resource "aws_lb_listener" "aws_demo_lis" {
  load_balancer_arn = aws_lb.aws-demo-docker.arn
  port = 80
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.aws-demo-docker.arn
  }
}