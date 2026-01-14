# Contributing

This document provides guidelines for contributing to the modules.

## Conventional Commits

This project uses [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/).

## Development

### Dependencies

```shell
mise install
prek install
tflint --init
```

### Provider Authentication

```shell
gcloud auth application-default login --project=terraform-test
```

Put Terraform provider credentials to `.env` file, which [mise](https://mise.jdx.dev/) picks up automatically:

```
GOOGLE_PROJECT=terraform-test
GOOGLE_REGION=europe-west2
```

## Testing

```shell
cd modules/alert-policies
terraform init
terraform test
```
