resource "aws_launch_configuration" "launch_config" {
  name                        = "${var.lc_name}"

  image_id                    = "${var.asg_ami_id}"
  instance_type               = "${var.asg_instance_type}"
  iam_instance_profile        = "${var.asg_instance_profile}"
  security_groups             = ["${var.asg_security_groups}"]
  associate_public_ip_address = "${var.asg_enable_public_ip}"
  user_data                   = "${var.asg_user_data}"
  key_name                    = "${var.key_name}"
  enable_monitoring           = "${var.asg_enable_monitoring}"
  ebs_optimized               = "${var.asg_ebs_optimized}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main_asg" {
  name       = "${var.asg_name}-${aws_launch_configuration.launch_config.name}"
  
  #name_prefix = "${var.asg_name_prefix}"

  # Split out the AZs string into an array
  # The chosen availability zones *must* match
  # the AZs the VPC subnets are tied to.
  availability_zones = ["${element(split(",", var.asg_azs), count.index)}"]

  # Split out the subnets string into an array
  vpc_zone_identifier = ["${element(split(",", var.asg_subnets), count.index)}"]

  # Uses the ID from the launch config created above
  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size                  = "${var.asg_number_of_instances}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  default_cooldown          = "${var.asg_default_cooldown}"
  load_balancers            = ["${var.load_balancers}"]
  desired_capacity          = "${var.asg_number_of_instances}"
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "${var.asg_health_check_type}"
  target_group_arns         = ["${var.asg_target_group_arns}"]
  termination_policies      = "${var.asg_termination_policies}"
  suspended_processes       = ["${var.asg_suspended_processes}"]
  placement_group           = "${var.asg_placement_group}"
  enabled_metrics           = ["${var.asg_enabled_metrics}"]
  wait_for_capacity_timeout = "${var.asg_capacity_timeout}"

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}
