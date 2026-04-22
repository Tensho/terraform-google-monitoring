module "example" {
  source = "../../modules/notification-channels"

  channels = {
    "example-email" = {
      type         = "email"
      display_name = "Example Email"
      description  = "Email notification channel managed by Terraform."

      labels = {
        email_address = "user@example.com"
      }

      user_labels = {
        environment = "example"
        team        = "platform"
      }
    }
    "example-pagerduty" = {
      type         = "pagerduty"
      display_name = "Example PagerDuty"
      description  = "PagerDuty notification channel managed by Terraform."

      sensitive_labels = {
        service_key = "example-service-key"
      }

      user_labels = {
        environment = "example"
        team        = "platform"
      }
    }
  }
}
