<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.13 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | 7.41.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_logging_metric.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_metric) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | Log-based metrics. | <pre>map(object({<br/>    name             = string<br/>    filter           = string<br/>    description      = optional(string)<br/>    bucket_name      = optional(string)<br/>    disabled         = optional(bool, false)<br/>    label_extractors = optional(map(string))<br/>    value_extractor  = optional(string)<br/>    project          = optional(string)<br/>    deletion_policy  = optional(string) # DELETE, PREVENT, ABANDON<br/><br/>    metric_descriptor = optional(object({<br/>      metric_kind  = string # DELTA, GAUGE, CUMULATIVE<br/>      value_type   = string # BOOL, INT64, DOUBLE, STRING, DISTRIBUTION, MONEY<br/>      unit         = optional(string, "1")<br/>      display_name = optional(string)<br/><br/>      labels = optional(list(object({<br/>        key         = string<br/>        value_type  = optional(string, "STRING") # BOOL, INT64, STRING<br/>        description = optional(string)<br/>      })))<br/>    }))<br/><br/>    bucket_options = optional(object({<br/>      linear_buckets = optional(object({<br/>        num_finite_buckets = number<br/>        width              = number<br/>        offset             = number<br/>      }))<br/><br/>      exponential_buckets = optional(object({<br/>        num_finite_buckets = number<br/>        growth_factor      = number<br/>        scale              = number<br/>      }))<br/><br/>      explicit_buckets = optional(object({<br/>        bounds = list(number)<br/>      }))<br/>    }))<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_metric_ids"></a> [metric\_ids](#output\_metric\_ids) | Metric IDs |
<!-- END_TF_DOCS -->