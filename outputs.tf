output "launch_config_id" {
  value = "${aws_launch_configuration.launch_config.id}"
}

output "asg_id" {
  value = "${aws_autoscaling_group.main_asg.id}"
}
