run "basic" {
  variables {
    metrics = {
      "test-distribution-linear" = {
        name   = "test/distribution-linear"
        filter = "resource.type=gae_app AND severity>=ERROR"

        description     = "Distribution metric with linear buckets managed by Terraform."
        value_extractor = "EXTRACT(jsonPayload.request)"

        label_extractors = {
          "mass" = "EXTRACT(jsonPayload.request)"
          "sku"  = "REGEXP_EXTRACT(jsonPayload.id, \"id:(\\\\d+)\")"
        }

        metric_descriptor = {
          metric_kind  = "DELTA"
          value_type   = "DISTRIBUTION"
          unit         = "1"
          display_name = "Test Distribution Linear"

          labels = [
            {
              key         = "mass"
              value_type  = "STRING"
              description = "Amount of matter"
            },
            {
              key         = "sku"
              value_type  = "INT64"
              description = "Identifying number for item"
            }
          ]
        }

        bucket_options = {
          linear_buckets = {
            num_finite_buckets = 3
            width              = 1
            offset             = 1
          }
        }
      }
      "test-distribution-exponential" = {
        name   = "test/distribution-exponential"
        filter = "resource.type=gae_app AND severity>=ERROR"

        value_extractor = "EXTRACT(jsonPayload.latency)"

        metric_descriptor = {
          metric_kind = "DELTA"
          value_type  = "DISTRIBUTION"
          unit        = "ms"
        }

        bucket_options = {
          exponential_buckets = {
            num_finite_buckets = 10
            growth_factor      = 2
            scale              = 1
          }
        }
      }
      "test-distribution-explicit" = {
        name   = "test/distribution-explicit"
        filter = "resource.type=gae_app AND severity>=ERROR"

        value_extractor = "EXTRACT(jsonPayload.size)"

        metric_descriptor = {
          metric_kind = "DELTA"
          value_type  = "DISTRIBUTION"
        }

        bucket_options = {
          explicit_buckets = {
            bounds = [0, 1, 2, 5, 10, 20, 50, 100]
          }
        }
      }
      "test-counter" = {
        name   = "test/counter"
        filter = "resource.type=gae_app AND severity>=ERROR"

        metric_descriptor = {
          metric_kind = "DELTA"
          value_type  = "INT64"

          labels = [
            {
              key         = "mass"
              value_type  = "STRING"
              description = "Amount of matter"
            }
          ]
        }

        label_extractors = {
          "mass" = "EXTRACT(jsonPayload.request)"
        }
      }
      "test-disabled" = {
        name        = "test/disabled"
        filter      = "resource.type=gae_app AND severity>=ERROR"
        description = "Disabled metric managed by Terraform."
        disabled    = true

        deletion_policy = "DELETE"

        metric_descriptor = {
          metric_kind = "DELTA"
          value_type  = "INT64"
        }
      }
    }
  }

  assert {
    condition     = google_logging_metric.default["test-distribution-linear"].id != ""
    error_message = "Log metric 'test-distribution-linear' has not been created"
  }

  assert {
    condition     = google_logging_metric.default["test-distribution-exponential"].id != ""
    error_message = "Log metric 'test-distribution-exponential' has not been created"
  }

  assert {
    condition     = google_logging_metric.default["test-distribution-explicit"].id != ""
    error_message = "Log metric 'test-distribution-explicit' has not been created"
  }

  assert {
    condition     = google_logging_metric.default["test-counter"].id != ""
    error_message = "Log metric 'test-counter' has not been created"
  }

  assert {
    condition     = google_logging_metric.default["test-disabled"].disabled == true
    error_message = "Log metric 'test-disabled' is not disabled"
  }
}
