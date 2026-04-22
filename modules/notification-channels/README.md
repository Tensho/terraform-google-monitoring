# Google Cloud Monitoring Notification Channels Terraform Module 

## TODO

- [ ] Add write-only sensitive_labels attributes (`_wo`) when `required_version` is bumped to `>= 1.11`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 6.12 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_monitoring_notification_channel.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_notification_channel) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_channels"></a> [channels](#input\_channels) | Notification channels. | <pre>map(object({<br/>    type         = string<br/>    display_name = optional(string)<br/>    description  = optional(string)<br/>    enabled      = optional(bool, true)<br/>    labels       = optional(map(string))<br/>    user_labels  = optional(map(string))<br/>    force_delete = optional(bool, false)<br/><br/>    sensitive_labels = optional(object({<br/>      auth_token  = optional(string)<br/>      password    = optional(string)<br/>      service_key = optional(string)<br/>    }))<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_channel_ids"></a> [channel\_ids](#output\_channel\_ids) | Channel IDs |
<!-- END_TF_DOCS -->
