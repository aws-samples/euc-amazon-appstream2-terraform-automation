locals {
  tag_environment_type = "Dev"
  tag_app_id           = "app-tag-1"
  name_prefix = "${var.app_name}_"

  // default tags
  default_tags = tomap({
    "ApplicationIdentifier" = local.tag_app_id
    "EnvironmentType"       = local.tag_environment_type
  })

}