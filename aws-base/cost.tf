resource "aws_ce_anomaly_monitor" "default" {
  name              = "default-services-monitor"
  monitor_type      = "DIMENSIONAL"
  monitor_dimension = "SERVICE"
}

resource "aws_ce_anomaly_subscription" "default" {
  name      = "default-services-monitor"
  frequency = "DAILY"

  monitor_arn_list = [
    aws_ce_anomaly_monitor.default.arn
  ]

  subscriber {
    type    = "EMAIL"
    address = var.budget_notification_email
  }

  threshold_expression {
    and {
      dimension {
        key           = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"
        match_options = ["GREATER_THAN_OR_EQUAL"]
        values        = ["100"]
      }
    }
    and {
      dimension {
        key           = "ANOMALY_TOTAL_IMPACT_PERCENTAGE"
        match_options = ["GREATER_THAN_OR_EQUAL"]
        values        = ["40"]
      }
    }
  }
}