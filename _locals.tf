locals {
  app_name              = "demo"
  vpc_name              = "AppStreamCustVPC"
  front_end_subnet_name = "*FrontEnd*"
  app_subnet_name       = "*App*"
  tag_environment_type  = "Dev"
  tag_app_id            = "demo123"

  name_prefix = "${local.app_name}_"

  //AppStream Image Builder values
  image_builder_base_image_name = var.image_builder_base_image_name
  image_builder_instance_type   = var.image_builder_instance_type

  //AppStream Fleet values
  desired_fleet_instances_count            = var.desired_fleet_instances_count
  fleet_type                               = var.fleet_type
  fleet_max_user_duration_in_seconds       = var.fleet_max_user_duration_in_seconds
  fleet_disconnect_timeout_in_seconds      = var.fleet_disconnect_timeout_in_seconds
  fleet_idle_disconnect_timeout_in_seconds = var.fleet_idle_disconnect_timeout_in_seconds
  fleet_image_name                         = var.fleet_image_name
  fleet_instance_type                      = var.fleet_instance_type

  // default tags
  default_tags = tomap({
    "ApplicationIdentifier" = local.tag_app_id
    "EnvironmentType"       = local.tag_environment_type
  })

}