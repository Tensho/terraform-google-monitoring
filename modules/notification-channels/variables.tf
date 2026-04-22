variable "channels" {
  description = "Notification channels."

  type = map(object({
    type         = string
    display_name = optional(string)
    description  = optional(string)
    enabled      = optional(bool, true)
    labels       = optional(map(string))
    user_labels  = optional(map(string))
    force_delete = optional(bool, false)

    sensitive_labels = optional(object({
      auth_token  = optional(string)
      password    = optional(string)
      service_key = optional(string)
    }))
  }))

  default = {}
}
