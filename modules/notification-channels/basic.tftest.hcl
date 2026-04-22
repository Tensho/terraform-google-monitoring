run "basic" {
  variables {
    channels = {
      "test-email" = {
        type         = "email"
        display_name = "Test Email"
        description  = "Email notification channel managed by Terraform."

        labels = {
          email_address = "test@example.com"
        }

        user_labels = {
          environment = "test"
          team        = "platform"
        }
      }
      "test-pagerduty" = {
        type         = "pagerduty"
        display_name = "Test PagerDuty"
        description  = "PagerDuty notification channel managed by Terraform."

        sensitive_labels = {
          service_key = "test-service-key"
        }

        user_labels = {
          environment = "test"
          team        = "platform"
        }
      }
    }
  }

  assert {
    condition     = length(google_monitoring_notification_channel.default["test-email"]) > 0
    error_message = "Notification channel 'test-email' has not been created"
  }

  assert {
    condition     = length(google_monitoring_notification_channel.default["test-pagerduty"]) > 0
    error_message = "Notification channel 'test-pagerduty' has not been created"
  }
}
