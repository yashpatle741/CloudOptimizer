resource "aws_cloudwatch_log_group" "this" {
  for_each = toset(var.log_group_names)

  name              = each.value
  retention_in_days = var.log_retention_in_days
  kms_key_id        = var.kms_key_id

  tags = merge(
    var.tags,
    {
      Name        = each.value
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Yash"
    }
  )
}

resource "aws_cloudwatch_metric_alarm" "this" {
  count = var.alarm_enabled ? 1 : 0

  alarm_name                = coalesce(var.alarm_name, "${var.project_name}-${var.environment}-high-errors")
  comparison_operator       = var.comparison_operator
  evaluation_periods        = var.evaluation_periods
  metric_name               = var.metric_name
  namespace                 = var.namespace
  period                    = var.period
  statistic                 = var.statistic
  threshold                 = var.threshold
  alarm_description         = var.alarm_description
  treat_missing_data        = var.treat_missing_data
  alarm_actions             = var.alarm_actions
  ok_actions                = var.ok_actions
  insufficient_data_actions = var.insufficient_data_actions

  tags = merge(
    var.tags,
    {
      Name        = coalesce(var.alarm_name, "${var.project_name}-${var.environment}-high-errors")
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "Yash"
    }
  )
}
