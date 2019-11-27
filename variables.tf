variable "name" { }
variable "lc_name" { }
variable "lc_name_prefix" { default = "" }
variable "asg_ami_id" { }
variable "asg_instance_type" { }
variable "asg_instance_profile" { default = "" }
variable "asg_enable_public_ip" {
  description = "If not set then public ip is set on subnet level."
}

variable "asg_enable_monitoring" { default = "" }
variable "asg_ebs_optimized" { default = "" }

variable "load_balancers" {
  type = "list"
}

variable "key_name" {
  description = "The SSH key to use when accessing instances in the ASG"
}

variable "asg_security_groups" {
  description = "The security group the instances to use"
  type        = "list"
}

## Auto-Scaling Group
variable "asg_name" { }
variable "asg_name_prefix" { default = "" }

variable "asg_user_data" {
  default = ""
}

variable "asg_number_of_instances" {
  description = "The number of instances we want in the ASG"
  default = "1"
}

variable "asg_minimum_number_of_instances" {
  description = "The minimum number of instances the ASG should maintain"
  default     = "1"
}

variable "asg_health_check_grace_period" {
  description = "Number of seconds for a health check to time out"
  default     = "300"
}

variable "asg_health_check_type" {
  default = "EC2"
}

variable "asg_subnets" {
  description = "The VPC subnet IDs. Use comma separated list."
}

variable "asg_azs" {
  description = "Availability Zones, comma separated list."
}

variable "asg_default_cooldown" {
  default = "300"
}

variable "asg_target_group_arns" { default = [] }
variable "asg_termination_policies" { default = [] }
variable "asg_suspended_processes" { default = [] }
variable "asg_placement_group" { default = "" }
variable "asg_enabled_metrics" { default = [] }
variable "asg_capacity_timeout" { default = "10m" }
