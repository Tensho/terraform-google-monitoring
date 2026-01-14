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
