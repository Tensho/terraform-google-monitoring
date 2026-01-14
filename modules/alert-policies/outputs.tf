output "policy_ids" {
  description = "Policy IDs"

  value = {
    for policy_key, policy in google_monitoring_alert_policy.default : policy_key => policy.id
  }
}
