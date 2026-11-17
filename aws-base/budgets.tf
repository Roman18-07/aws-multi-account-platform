resource "aws_budgets_budget" "main_monthly_cost_budget" {
  name = "main-monthly-cost-budget"

  budget_type  = "COST"
  limit_amount = var.budget_main_monthly_cost_alarm
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    subscriber_email_addresses = [
      var.budget_notification_email
    ]
    threshold      = 100
    threshold_type = "PERCENTAGE"
  }

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    subscriber_email_addresses = [
      var.budget_notification_email
    ]
    threshold      = 85
    threshold_type = "PERCENTAGE"
  }

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "FORECASTED"
    subscriber_email_addresses = [
      var.budget_notification_email
    ]
    threshold      = 100
    threshold_type = "PERCENTAGE"
  }
}