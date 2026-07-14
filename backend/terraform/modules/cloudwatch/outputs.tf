output "log_group_names" {
  description = "The names of the created CloudWatch log groups."
  value       = [for group in aws_cloudwatch_log_group.this : group.name]
}

output "log_group_arns" {
  description = "The ARNs of the created CloudWatch log groups."
  value       = [for group in aws_cloudwatch_log_group.this : group.arn]
}

output "alarm_name" {
  description = "The name of the created CloudWatch alarm if enabled."
  value       = var.alarm_enabled ? aws_cloudwatch_metric_alarm.this[0].alarm_name : null
}
