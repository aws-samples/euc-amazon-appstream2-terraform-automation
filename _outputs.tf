# output "appstream_image_builder_id" {
#   description = "The ID of the appstream image builder instance"
#   value       = module.appstream_image_builder.id
# }

output "appstream_fleet_name" {
  description = "The name of the AppStream 2.0 fleet"
  value       = module.appstream_fleet.name
}

output "appstream_stack_name" {
  description = "The name of the AppStream 2.0 stack"
  value       = module.appstream_stack.name
}
