resource "aws_autoscaling_group" "app_asg" {
  name                      = "docker-app-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }
  vpc_zone_identifier       = var.private_subnet_ids
  target_group_arns         = [var.target_group_arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "docker-app-instance"
    propagate_at_launch = true
  }
}
