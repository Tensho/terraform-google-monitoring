variable "metrics" {
  description = "Log-based metrics."

  type = map(object({
    name             = string
    filter           = string
    description      = optional(string)
    bucket_name      = optional(string)
    disabled         = optional(bool, false)
    label_extractors = optional(map(string))
    value_extractor  = optional(string)
    project          = optional(string)
    deletion_policy  = optional(string) # DELETE, PREVENT, ABANDON

    metric_descriptor = optional(object({
      metric_kind  = string # DELTA, GAUGE, CUMULATIVE
      value_type   = string # BOOL, INT64, DOUBLE, STRING, DISTRIBUTION, MONEY
      unit         = optional(string, "1")
      display_name = optional(string)

      labels = optional(list(object({
        key         = string
        value_type  = optional(string, "STRING") # BOOL, INT64, STRING
        description = optional(string)
      })))
    }))

    bucket_options = optional(object({
      linear_buckets = optional(object({
        num_finite_buckets = number
        width              = number
        offset             = number
      }))

      exponential_buckets = optional(object({
        num_finite_buckets = number
        growth_factor      = number
        scale              = number
      }))

      explicit_buckets = optional(object({
        bounds = list(number)
      }))
    }))
  }))

  default = {}
}
