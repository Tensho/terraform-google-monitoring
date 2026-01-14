output "policies" {
  description = "All alert policies."
  value       = google_monitoring_alert_policy.default
}

output "policy_ids" {
  description = "Map of policy keys to their IDs."
  value = {
    for key, policy in google_monitoring_alert_policy.default : key => policy.id
  }
}

output "policy_names" {
  description = "Map of policy keys to their resource names."
  value = {
    for key, policy in google_monitoring_alert_policy.default : key => policy.name
  }
}

