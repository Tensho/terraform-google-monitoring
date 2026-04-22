output "channel_ids" {
  description = "Channel IDs"

  value = {
    for channel_key, channel in google_monitoring_notification_channel.default : channel_key => channel.id
  }
}
