# Google Cloud Monitoring Terraform Module

Terraform module to manage [Google Cloud Monitoring]() resources (batteries included).

## Usage

```hcl
module "example" {
  source  = "Tensho/google/monitoring//modules/alert-policies"
  version = "1.0.0"

  policies = {
    "alice" = {
      display_name = "Alice"

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
  }
}
```

Check out comprehensive examples in [`examples`](./examples) folder.

## Features

* [ ] [Google Cloud Monitoring alert policies](https://docs.cloud.google.com/monitoring/alerts)
  * [x] Threshold
  * [x] Absent
  * [ ] Matched Log
  * [ ] MQL
  * [ ] PromQL
  * [ ] SQL
* [ ] [Google Cloud Monitoring notification channels](https://docs.cloud.google.com/monitoring/support/notification-options)
* [ ] [Google Cloud Monitoring dashboards](https://docs.cloud.google.com/monitoring/dashboards)

## Requirements

A project with the following APIs enabled must be used to host the resources of this module:

* Cloud Monitoring API `monitoring.googleapis.com`                 

The [Project Factory module](https://registry.terraform.io/modules/terraform-google-modules/project-factory/google) can
be used to provision a project with the necessary APIs enabled. Alternatively, the APIs can be enabled via CLI:

```shell
gcloud services monitoring.googleapis.com
```
