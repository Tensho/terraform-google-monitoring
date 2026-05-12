run "basic" {
  variables {
    dashboards = {
      "test-overview" = {
        dashboard_json = jsonencode({
          displayName = "Test Overview"
          gridLayout = {
            columns = 2
            widgets = [
              {
                title = "CPU Utilization"
                xyChart = {
                  dataSets = [
                    {
                      timeSeriesQuery = {
                        timeSeriesFilter = {
                          filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" resource.type=\"gce_instance\""
                          aggregation = {
                            alignmentPeriod  = "60s"
                            perSeriesAligner = "ALIGN_MEAN"
                          }
                        }
                      }
                      plotType = "LINE"
                    }
                  ]
                }
              }
            ]
          }
        })
      }
      "test-notes" = {
        dashboard_json = jsonencode({
          displayName = "Test Notes"
          gridLayout = {
            widgets = [
              {
                title = "Runbook"
                text = {
                  content = "Test dashboard managed by Terraform."
                  format  = "MARKDOWN"
                }
              }
            ]
          }
        })
      }
    }
  }

  assert {
    condition     = length(google_monitoring_dashboard.default["test-overview"]) > 0
    error_message = "Dashboard 'test-overview' has not been created"
  }

  assert {
    condition     = length(google_monitoring_dashboard.default["test-notes"]) > 0
    error_message = "Dashboard 'test-notes' has not been created"
  }
}
