output "launch_template_id" {
  description = "The ID of the Launch Template"
  value       = aws_launch_template.app_lt.id
}

output "launch_template_name" {
  description = "The name of the Launch Template"
  value       = aws_launch_template.app_lt.name
}
