# Google Cloud Monitoring Alert Policies Terraform Module 

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 7.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_monitoring_alert_policy.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_policies"></a> [policies](#input\_policies) | Alert policies with conditions. | <pre>map(object({<br/>    display_name = string<br/>    combiner     = optional(string, "OR") # OR, AND, AND_WITH_MATCHING_RESOURCE<br/>    enabled      = optional(bool, true)<br/>    severity     = optional(string) # CRITICAL, ERROR, WARNING<br/>    user_labels  = optional(map(string))<br/><br/>    conditions = list(object({<br/>      display_name = string<br/><br/>      condition_threshold = optional(object({<br/>        filter                  = optional(string)<br/>        duration                = string<br/>        comparison              = optional(string) # COMPARISON_GT, COMPARISON_GE, COMPARISON_LT, COMPARISON_LE, COMPARISON_EQ, COMPARISON_NE<br/>        threshold_value         = optional(number)<br/>        denominator_filter      = optional(string)<br/>        evaluation_missing_data = optional(string) # EVALUATION_MISSING_DATA_INACTIVE, EVALUATION_MISSING_DATA_ACTIVE, EVALUATION_MISSING_DATA_NO_OP<br/><br/>        aggregations = optional(list(object({<br/>          alignment_period     = optional(string)<br/>          per_series_aligner   = optional(string) # ALIGN_NONE, ALIGN_DELTA, ALIGN_RATE, ALIGN_INTERPOLATE, ALIGN_NEXT_OLDER, ALIGN_MIN, ALIGN_MAX, ALIGN_MEAN, ALIGN_COUNT, ALIGN_SUM, ALIGN_STDDEV, ALIGN_COUNT_TRUE, ALIGN_COUNT_FALSE, ALIGN_FRACTION_TRUE, ALIGN_PERCENTILE_99, ALIGN_PERCENTILE_95, ALIGN_PERCENTILE_50, ALIGN_PERCENTILE_05, ALIGN_PERCENT_CHANGE<br/>          cross_series_reducer = optional(string) # REDUCE_NONE, REDUCE_MEAN, REDUCE_MIN, REDUCE_MAX, REDUCE_SUM, REDUCE_STDDEV, REDUCE_COUNT, REDUCE_COUNT_TRUE, REDUCE_COUNT_FALSE, REDUCE_FRACTION_TRUE, REDUCE_PERCENTILE_99, REDUCE_PERCENTILE_95, REDUCE_PERCENTILE_50, REDUCE_PERCENTILE_05<br/>          group_by_fields      = optional(list(string))<br/>        })))<br/><br/>        denominator_aggregations = optional(list(object({<br/>          alignment_period     = optional(string)<br/>          per_series_aligner   = optional(string)<br/>          cross_series_reducer = optional(string)<br/>          group_by_fields      = optional(list(string))<br/>        })))<br/><br/>        trigger = optional(object({<br/>          count   = optional(number)<br/>          percent = optional(number)<br/>        }))<br/><br/>        forecast_options = optional(object({<br/>          forecast_horizon = string<br/>        }))<br/>      }))<br/><br/>      condition_absent = optional(object({<br/>        filter   = optional(string)<br/>        duration = string<br/><br/>        aggregations = optional(list(object({<br/>          alignment_period     = optional(string)<br/>          per_series_aligner   = optional(string)<br/>          cross_series_reducer = optional(string)<br/>          group_by_fields      = optional(list(string))<br/>        })))<br/><br/>        trigger = optional(object({<br/>          count   = optional(number)<br/>          percent = optional(number)<br/>        }))<br/>      }))<br/>    }))<br/><br/>    documentation = optional(object({<br/>      content   = optional(string)<br/>      mime_type = optional(string, "text/markdown")<br/>      subject   = optional(string)<br/>      links = optional(list(object({<br/>        display_name = optional(string)<br/>        url          = optional(string)<br/>      })))<br/>    }))<br/><br/>    notification_channels = optional(list(string))<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_ids"></a> [policy\_ids](#output\_policy\_ids) | Policy IDs |
<!-- END_TF_DOCS -->