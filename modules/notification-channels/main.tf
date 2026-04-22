resource "google_monitoring_notification_channel" "default" {
  for_each = var.channels

  type         = each.value.type
  display_name = each.value.display_name
  description  = each.value.description
  enabled      = each.value.enabled
  labels       = each.value.labels
  user_labels  = each.value.user_labels
  force_delete = each.value.force_delete

  dynamic "sensitive_labels" {
    for_each = each.value.sensitive_labels != null ? [each.value.sensitive_labels] : []

    content {
      auth_token  = sensitive_labels.value.auth_token
      password    = sensitive_labels.value.password
      service_key = sensitive_labels.value.service_key
    }
  }
}
