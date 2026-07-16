output "log_group_names" {
  description = "CloudWatch log group names."
  value       = values(aws_cloudwatch_log_group.this)[*].name
}

output "log_group_arns" {
  description = "CloudWatch log group ARNs."
  value       = values(aws_cloudwatch_log_group.this)[*].arn
}

output "alarm_name" {
  description = "CloudWatch alarm name."
  value       = var.alarm_enabled ? aws_cloudwatch_metric_alarm.this[0].alarm_name : null
}

output "alarm_arn" {
  description = "CloudWatch alarm ARN."
  value       = var.alarm_enabled ? aws_cloudwatch_metric_alarm.this[0].arn : null
}