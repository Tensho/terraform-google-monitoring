resource "google_monitoring_alert_policy" "default" {
  for_each = var.policies

  display_name = each.value.display_name
  combiner     = each.value.combiner
  enabled      = each.value.enabled
  severity     = each.value.severity
  user_labels  = each.value.user_labels

  notification_channels = each.value.notification_channels

  dynamic "documentation" {
    for_each = each.value.documentation != null ? [each.value.documentation] : []

    content {
      content   = documentation.value.content
      mime_type = documentation.value.mime_type
      subject   = documentation.value.subject

      dynamic "links" {
        for_each = documentation.value.links != null ? documentation.value.links : []

        content {
          display_name = links.value.display_name
          url          = links.value.url
        }
      }
    }
  }

  dynamic "conditions" {
    for_each = each.value.conditions

    content {
      display_name = conditions.value.display_name

      dynamic "condition_threshold" {
        for_each = conditions.value.condition_threshold != null ? [conditions.value.condition_threshold] : []

        content {
          filter                  = condition_threshold.value.filter
          duration                = condition_threshold.value.duration
          comparison              = condition_threshold.value.comparison
          threshold_value         = condition_threshold.value.threshold_value
          denominator_filter      = condition_threshold.value.denominator_filter
          evaluation_missing_data = condition_threshold.value.evaluation_missing_data

          dynamic "aggregations" {
            for_each = condition_threshold.value.aggregations != null ? condition_threshold.value.aggregations : []

            content {
              alignment_period     = aggregations.value.alignment_period
              per_series_aligner   = aggregations.value.per_series_aligner
              cross_series_reducer = aggregations.value.cross_series_reducer
              group_by_fields      = aggregations.value.group_by_fields
            }
          }

          dynamic "denominator_aggregations" {
            for_each = condition_threshold.value.denominator_aggregations != null ? condition_threshold.value.denominator_aggregations : []

            content {
              alignment_period     = denominator_aggregations.value.alignment_period
              per_series_aligner   = denominator_aggregations.value.per_series_aligner
              cross_series_reducer = denominator_aggregations.value.cross_series_reducer
              group_by_fields      = denominator_aggregations.value.group_by_fields
            }
          }

          dynamic "trigger" {
            for_each = condition_threshold.value.trigger != null ? [condition_threshold.value.trigger] : []

            content {
              count   = trigger.value.count
              percent = trigger.value.percent
            }
          }

          dynamic "forecast_options" {
            for_each = condition_threshold.value.forecast_options != null ? [condition_threshold.value.forecast_options] : []

            content {
              forecast_horizon = forecast_options.value.forecast_horizon
            }
          }
        }
      }

      dynamic "condition_absent" {
        for_each = conditions.value.condition_absent != null ? [conditions.value.condition_absent] : []

        content {
          filter   = condition_absent.value.filter
          duration = condition_absent.value.duration

          dynamic "aggregations" {
            for_each = condition_absent.value.aggregations != null ? condition_absent.value.aggregations : []

            content {
              alignment_period     = aggregations.value.alignment_period
              per_series_aligner   = aggregations.value.per_series_aligner
              cross_series_reducer = aggregations.value.cross_series_reducer
              group_by_fields      = aggregations.value.group_by_fields
            }
          }

          dynamic "trigger" {
            for_each = condition_absent.value.trigger != null ? [condition_absent.value.trigger] : []

            content {
              count   = trigger.value.count
              percent = trigger.value.percent
            }
          }
        }
      }
    }
  }
}
