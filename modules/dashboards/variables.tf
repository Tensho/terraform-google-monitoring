variable "dashboards" {
  description = "Dashboards."

  type = map(object({
    dashboard_json = string
    project        = optional(string)
  }))

  default = {}
}
