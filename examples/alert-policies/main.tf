module "example" {
  source = "../../modules/alert-policies"

  policies = {
    "example-threshold-condition" = {
      display_name = "Example Threshold Condition"

      conditions = [
        {
          display_name = "CPU utilization above 80%"

          condition_threshold = {
            filter = <<-QUERY
              metric.type="compute.googleapis.com/instance/cpu/utilization"
              resource.type="gce_instance"
            QUERY

            duration        = "300s"
            comparison      = "COMPARISON_GT"
            threshold_value = 0.8

            aggregations = [
              {
                alignment_period     = "60s"
                per_series_aligner   = "ALIGN_MEAN"
                cross_series_reducer = "REDUCE_MEAN"
                group_by_fields      = ["project", "resource.zone"]
              }
            ]
          }
        },
        {
          display_name = "Memory utilization above 80%"

          condition_threshold = {
            filter = <<-QUERY
              metric.type="agent.googleapis.com/memory/percent_used"
              resource.type="gce_instance"
              metric.label.state="used"
            QUERY

            duration        = "300s"
            comparison      = "COMPARISON_GT"
            threshold_value = 80

            aggregations = [
              {
                alignment_period     = "60s"
                per_series_aligner   = "ALIGN_MEAN"
                cross_series_reducer = "REDUCE_MEAN"
                group_by_fields      = ["project", "resource.zone"]
              }
            ]
          }
        }
      ]

      documentation = {
        content = <<-STR
          Example alert policy managed by Terraform.

          CPU or Memory utilization has exceeded 80% threshold.

          This alert monitors GCE instance CPU and memory usage and triggers when either
          the average utilization exceeds 80% for 5 minutes.
        STR
      }

      severity = "WARNING"

      user_labels = {
        environment = "example"
        team        = "platform"
      }
    }
    "example-prometheus-condition" = {
      display_name = "Example Prometheus Condition"

      conditions = [
        {
          display_name = "Container restarts above 5 in 10 minutes"

          condition_prometheus_query_language = {
            query = <<-QUERY
              increase(kubernetes_io:container_restart_count{monitored_resource="k8s_container"}[10m]) > 5
            QUERY

            duration            = "300s"
            evaluation_interval = "60s"

            labels = {
              severity = "warning"
            }

            rule_group = "container-health"
            alert_rule = "ContainerRestarts"
          }
        }
      ]

      documentation = {
        content = <<-STR
          Example alert policy managed by Terraform.

          Container restart count has exceeded 5 within 10 minutes.

          This alert monitors Kubernetes container restarts via PromQL and triggers
          when the restart count grows faster than expected.
        STR
      }

      severity = "WARNING"

      user_labels = {
        environment = "example"
        team        = "platform"
      }
    }
    "example-absent-condition" = {
      display_name = "Example Absent Condition"

      conditions = [
        {
          display_name = "No CPU data for 10 minutes"

          condition_absent = {
            filter = <<-QUERY
              metric.type="compute.googleapis.com/instance/cpu/utilization"
              resource.type="gce_instance"
            QUERY

            duration = "600s"

            aggregations = [
              {
                alignment_period     = "60s"
                per_series_aligner   = "ALIGN_MEAN"
                cross_series_reducer = "REDUCE_MEAN"
                group_by_fields      = ["project", "resource.zone"]
              }
            ]
          }
        }
      ]

      documentation = {
        content = <<-STR
          Example alert policy managed by Terraform.

          No CPU utilization data has been received for 10 minutes.

          This alert monitors GCE instance CPU data absence and triggers when no data
          is received for a duration of 10 minutes.
        STR
      }

      severity = "CRITICAL"

      user_labels = {
        environment = "example"
        team        = "platform"
      }
    }
  }
}
