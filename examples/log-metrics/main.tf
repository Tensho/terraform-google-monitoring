module "example" {
  source = "../../modules/log-metrics"

  metrics = {
    "example-error-count" = {
      name        = "example/error-count"
      filter      = "resource.type=gae_app AND severity>=ERROR"
      description = "Counter metric managed by Terraform."

      metric_descriptor = {
        metric_kind  = "DELTA"
        value_type   = "INT64"
        display_name = "Example Error Count"

        labels = [
          {
            key         = "module"
            value_type  = "STRING"
            description = "Application module that emitted the error"
          }
        ]
      }

      label_extractors = {
        "module" = "EXTRACT(jsonPayload.module)"
      }
    }
    "example-request-latency" = {
      name        = "example/request-latency"
      filter      = "resource.type=gae_app AND jsonPayload.latency>0"
      description = "Distribution metric managed by Terraform."

      value_extractor = "EXTRACT(jsonPayload.latency)"

      metric_descriptor = {
        metric_kind  = "DELTA"
        value_type   = "DISTRIBUTION"
        unit         = "ms"
        display_name = "Example Request Latency"
      }

      bucket_options = {
        exponential_buckets = {
          num_finite_buckets = 10
          growth_factor      = 2
          scale              = 1
        }
      }
    }
  }
}
