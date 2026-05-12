resource "google_monitoring_dashboard" "default" {
  for_each = var.dashboards

  dashboard_json = each.value.dashboard_json
  project        = each.value.project
}
