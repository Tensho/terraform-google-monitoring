# Google Cloud Monitoring Dashboards Terraform Module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 7.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_monitoring_dashboard.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_dashboard) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dashboards"></a> [dashboards](#input\_dashboards) | Dashboards. | <pre>map(object({<br/>    dashboard_json = string<br/>    project        = optional(string)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dashboard_ids"></a> [dashboard\_ids](#output\_dashboard\_ids) | Dashboard IDs |
<!-- END_TF_DOCS -->
