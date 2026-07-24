output "metric_ids" {
  description = "Metric IDs"

  value = {
    for metric_key, metric in google_logging_metric.default : metric_key => metric.id
  }
}
