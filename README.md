asg
===
Basic Autoscaling Group

Input Variables
---------------
- `name` - Application name that will be applied to instances in the ASG
- `lc_name` - A name to give the launch configuration
- `asg_ami_id` - The EC2 AMI to be used in the ASG
- `asg_instance_type` - The EC2 instance type to be used in the ASG
- `load_balancers` - A list of load balancers to attach to the ASG
- `asg_security_groups` - A list of security groups for the EC2 instances
- `asg_name` - A name to give the ASG
- `asg_number_of_instances` - The max desired number of instances in the ASG
- `asg_minimum_number_of_instances` - The minimum desired number of instances in the ASG
- `asg_health_check_grace_period` - The number of seconds for a health check to time out
- `asg_health_check_type` - The health check type; can be:
  - EC2
  - ELB
- `asg_subnets` - The VPC subnets to put the instances in
- `asg_azs` - The availability zones to put the instances in

Outputs
-------
- `launch_config_id` - The ID of the launch configuration
- `asg_id` - The ID of the autoscaling group

Usage
-----

1.) Add a module resource to your template, e.g. `main.tf`
```
module "asg" { 
  source                          = "git::https://github.com/wozoopa/aws-asg.git"

  name                            = "${var.name}-EC2"
  asg_name                        = "${var.name}-ASG"
  lc_name                         = "${var.name}-LC"
  asg_ami_id                      = "${lookup(var.web1_ami, var.region)}"
  asg_instance_type               = "t2.nano"
  asg_security_groups             = ["${module.web_sg.web_sg_id}", "${module.bastion.ssh_from_nat_sg_id}"]
  asg_number_of_instances         = 1
  asg_minimum_number_of_instances = 1
  asg_subnets                     = "${module.private_subnet.subnet_ids}"
  asg_azs                         = "${lookup(var.asg_azs, var.region)}"
  load_balancers                 = ["${module.elb_http.elb_name}"]
  asg_default_cooldown            = 300
  asg_enable_public_ip            = "false"
  key_name                        = "${var.key_name}"
  asg_enable_monitoring           = "false"
}
```

2) Add variables in your variables.tf or in main.tf
```
variable "asg_azs" {
   type = "map"

   default = {
     us-east-1 = "us-east-1b,us-east-1c,us-east-1d,us-east-1e"
     us-west-1 = ""
     us-west-2 = ""
   }

}
```
