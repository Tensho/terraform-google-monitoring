module "example" {
  source = "../../modules/dashboards"

  dashboards = {
    "example-from-file" = {
      dashboard_json = file("${path.module}/dashboard.json")
    }
    "example-inline" = {
      dashboard_json = jsonencode({
        displayName = "Example Overview"
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
            },
            {
              title = "Memory Utilization"
              xyChart = {
                dataSets = [
                  {
                    timeSeriesQuery = {
                      timeSeriesFilter = {
                        filter = "metric.type=\"agent.googleapis.com/memory/percent_used\" resource.type=\"gce_instance\" metric.label.state=\"used\""
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
  }
}
