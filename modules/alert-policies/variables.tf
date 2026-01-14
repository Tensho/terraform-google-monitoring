variable "policies" {
  description = "Alert policies with conditions."

  type = map(object({
    display_name = string
    combiner     = optional(string, "OR") # OR, AND, AND_WITH_MATCHING_RESOURCE
    enabled      = optional(bool, true)
    severity     = optional(string) # CRITICAL, ERROR, WARNING
    user_labels  = optional(map(string))

    conditions = list(object({
      display_name = string

      condition_threshold = optional(object({
        filter                  = optional(string)
        duration                = string
        comparison              = optional(string) # COMPARISON_GT, COMPARISON_GE, COMPARISON_LT, COMPARISON_LE, COMPARISON_EQ, COMPARISON_NE
        threshold_value         = optional(number)
        denominator_filter      = optional(string)
        evaluation_missing_data = optional(string) # EVALUATION_MISSING_DATA_INACTIVE, EVALUATION_MISSING_DATA_ACTIVE, EVALUATION_MISSING_DATA_NO_OP

        aggregations = optional(list(object({
          alignment_period     = optional(string)
          per_series_aligner   = optional(string) # ALIGN_NONE, ALIGN_DELTA, ALIGN_RATE, ALIGN_INTERPOLATE, ALIGN_NEXT_OLDER, ALIGN_MIN, ALIGN_MAX, ALIGN_MEAN, ALIGN_COUNT, ALIGN_SUM, ALIGN_STDDEV, ALIGN_COUNT_TRUE, ALIGN_COUNT_FALSE, ALIGN_FRACTION_TRUE, ALIGN_PERCENTILE_99, ALIGN_PERCENTILE_95, ALIGN_PERCENTILE_50, ALIGN_PERCENTILE_05, ALIGN_PERCENT_CHANGE
          cross_series_reducer = optional(string) # REDUCE_NONE, REDUCE_MEAN, REDUCE_MIN, REDUCE_MAX, REDUCE_SUM, REDUCE_STDDEV, REDUCE_COUNT, REDUCE_COUNT_TRUE, REDUCE_COUNT_FALSE, REDUCE_FRACTION_TRUE, REDUCE_PERCENTILE_99, REDUCE_PERCENTILE_95, REDUCE_PERCENTILE_50, REDUCE_PERCENTILE_05
          group_by_fields      = optional(list(string))
        })))

        denominator_aggregations = optional(list(object({
          alignment_period     = optional(string)
          per_series_aligner   = optional(string)
          cross_series_reducer = optional(string)
          group_by_fields      = optional(list(string))
        })))

        trigger = optional(object({
          count   = optional(number)
          percent = optional(number)
        }))

        forecast_options = optional(object({
          forecast_horizon = string
        }))
      }))

      condition_absent = optional(object({
        filter   = optional(string)
        duration = string

        aggregations = optional(list(object({
          alignment_period     = optional(string)
          per_series_aligner   = optional(string)
          cross_series_reducer = optional(string)
          group_by_fields      = optional(list(string))
        })))

        trigger = optional(object({
          count   = optional(number)
          percent = optional(number)
        }))
      }))
    }))

    documentation = optional(object({
      content   = optional(string)
      mime_type = optional(string, "text/markdown")
      subject   = optional(string)
      links = optional(list(object({
        display_name = optional(string)
        url          = optional(string)
      })))
    }))

    notification_channels = optional(list(string))
  }))

  default = {}
}
