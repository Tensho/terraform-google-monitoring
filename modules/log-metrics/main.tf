resource "google_logging_metric" "default" {
  for_each = var.metrics

  name             = each.value.name
  filter           = each.value.filter
  description      = each.value.description
  bucket_name      = each.value.bucket_name
  disabled         = each.value.disabled
  label_extractors = each.value.label_extractors
  value_extractor  = each.value.value_extractor
  project          = each.value.project
  deletion_policy  = each.value.deletion_policy

  dynamic "metric_descriptor" {
    for_each = each.value.metric_descriptor != null ? [each.value.metric_descriptor] : []

    content {
      metric_kind  = metric_descriptor.value.metric_kind
      value_type   = metric_descriptor.value.value_type
      unit         = metric_descriptor.value.unit
      display_name = metric_descriptor.value.display_name

      dynamic "labels" {
        for_each = metric_descriptor.value.labels != null ? metric_descriptor.value.labels : []

        content {
          key         = labels.value.key
          value_type  = labels.value.value_type
          description = labels.value.description
        }
      }
    }
  }

  dynamic "bucket_options" {
    for_each = each.value.bucket_options != null ? [each.value.bucket_options] : []

    content {
      dynamic "linear_buckets" {
        for_each = bucket_options.value.linear_buckets != null ? [bucket_options.value.linear_buckets] : []

        content {
          num_finite_buckets = linear_buckets.value.num_finite_buckets
          width              = linear_buckets.value.width
          offset             = linear_buckets.value.offset
        }
      }

      dynamic "exponential_buckets" {
        for_each = bucket_options.value.exponential_buckets != null ? [bucket_options.value.exponential_buckets] : []

        content {
          num_finite_buckets = exponential_buckets.value.num_finite_buckets
          growth_factor      = exponential_buckets.value.growth_factor
          scale              = exponential_buckets.value.scale
        }
      }

      dynamic "explicit_buckets" {
        for_each = bucket_options.value.explicit_buckets != null ? [bucket_options.value.explicit_buckets] : []

        content {
          bounds = explicit_buckets.value.bounds
        }
      }
    }
  }
}
