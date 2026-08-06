resource "aws_autoscaling_group" "web_asg" {
  name = "${var.environment}-Asg"

  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  vpc_zone_identifier = var.private_subnet_ids

  target_group_arns = [
    var.target_group_arn
  ]

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "${var.environment}-WebServer"
    propagate_at_launch = true
  }
}