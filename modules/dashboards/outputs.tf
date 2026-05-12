output "dashboard_ids" {
  description = "Dashboard IDs"

  value = {
    for dashboard_key, dashboard in google_monitoring_dashboard.default : dashboard_key => dashboard.id
  }
}
