# Google Cloud Monitoring Terraform Module

Terraform module to manage [Google Cloud Monitoring]() resources (batteries included).

## Usage

```hcl
module "example" {
  source  = "Tensho/google/monitoring//modules/alert-policies"
  version = "1.0.0"

  ...
}
```

Check out comprehensive examples in [`examples`](./examples) folder.

## Features

* [ ] [Google Cloud Monitoring alert policies](https://docs.cloud.google.com/monitoring/alerts)
* [ ] [Google Cloud Monitoring notification channels](https://docs.cloud.google.com/monitoring/support/notification-options)
* [ ] [Google Cloud Monitoring dashboards](https://docs.cloud.google.com/monitoring/dashboards)

## Contributing

This project uses [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/).

### Prerequisites

#### MacOS

```shell
mise install
prek install
tflint --init
```

#### Provider Authentication

```shell
gcloud auth application-default login --project=terraform-test
```

##### Mise

Consider environment variables management for Terraform provider authentication via `.env` file, which [mise](https://mise.jdx.dev/)
picks up automatically:

```
GOOGLE_PROJECT=terraform-test
GOOGLE_REGION=europe-west2
```

##### Google Cloud

```shell

export GOOGLE_PROJECT=terraform-test
export GOOGLE_REGION=europe-west2
```

### Testing

```shell
cd modules/alert-policies
terraform init
terraform test
```
