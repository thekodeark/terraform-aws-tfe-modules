output "api_destination_arns" {
  value = module.event-bridge.eventbridge_api_destination_arns
}

output "bus_arn" {
  value = module.event-bridge.eventbridge_bus_arn
}

output "bus_name" {
  value = module.event-bridge.eventbridge_bus_name
}

output "connection_arns" {
  value = module.event-bridge.eventbridge_connection_arns
}
