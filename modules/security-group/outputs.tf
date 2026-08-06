output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}

output "web_security_group_id" {
  value = aws_security_group.web_sg.id
}