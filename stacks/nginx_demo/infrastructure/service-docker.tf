


resource "aws_launch_configuration" "docker_lc" {
  name_prefix                 = "${local.docker_enviroment_resource_name}-"
  image_id                    = "${data.aws_ami.docker_ami.image_id}"
  instance_type               = "${var.default_ec2_instance_type}"
  iam_instance_profile        = "${var.iam_application_instance_profile}"
  associate_public_ip_address = false
  placement_tenancy           = "${var.instance_tenancy}"

  security_groups = ["${aws_security_group.docker-satellite-tier-sg.id}","${aws_security_group.docker-ssh-sg.id}"]
  user_data       = "${data.template_file.docker_userdata.rendered}"
  key_name        = "${var.ec2_ssh_key_pair_name}"

  #
  # provision a larger volume because static data for different days is maintained in $app-dir/etc/data
  #
  root_block_device {
    volume_size = "60"
    volume_type = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "dcg_asg" {
  name                      = "${local.dcg_enviroment_resource_name}"
  max_size                  = "${var.dcg_enable == "true" ? 1 : 0}"
  min_size                  = "${var.dcg_enable == "true" ? 1 : 0}"
  desired_capacity          = "${var.dcg_enable == "true" ? 1 : 0}"
  vpc_zone_identifier       = "${var.az_subnet_id_list}"
  health_check_grace_period = 180
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.dcg_lc.name}"

  tags = "${module.dcg_tags.asg_tag_list}"

  depends_on = [
    "module.ec2_bootstrap_script_s3_file.s3_object_dependency"
  ]
}