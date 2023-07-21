module "appstream_vpc_endpoint" {
  source               = "./modules/vpc-endpoint"
  vpc_id               = data.aws_vpc.app_vpc.id
  aws_region           = data.aws_region.current.id
  subnet_ids           = toset(data.aws_subnets.front_end_subnets.ids)
  security_group_cidrs = [for s in data.aws_subnet.routable_front_end : s.cidr_block]
  name_prefix          = local.name_prefix
  default_tags         = local.default_tags
}

module "appstream_image_builder" {
  source               = "./modules/appStream/image-builder"
  vpc_id               = data.aws_vpc.app_vpc.id
  subnet_id            = data.aws_subnets.app_subnets.ids[0]
  image_name           = var.image_builder_base_image_name
  instance_type        = var.image_builder_instance_type
  vpce_id              = module.appstream_vpc_endpoint.id
  security_group_cidrs = [for s in data.aws_subnet.routable_front_end : s.cidr_block]
  name_prefix          = local.name_prefix
  default_tags         = local.default_tags

  depends_on = [
    module.appstream_vpc_endpoint
  ]
}

module "appstream_fleet" {
  source                             = "./modules/appstream/fleet"
  vpc_id                             = data.aws_vpc.app_vpc.id
  subnet_ids                         = toset(data.aws_subnets.app_subnets.ids)
  fleet_type                         = var.fleet_type
  desired_fleet_instances_count      = var.desired_fleet_instances_count
  max_user_duration_in_seconds       = var.fleet_max_user_duration_in_seconds
  disconnect_timeout_in_seconds      = var.fleet_disconnect_timeout_in_seconds
  idle_disconnect_timeout_in_seconds = var.fleet_idle_disconnect_timeout_in_seconds
  image_name                         = var.fleet_image_name
  instance_type                      = var.fleet_instance_type
  security_group_cidrs               = [for s in data.aws_subnet.routable_front_end : s.cidr_block]
  name_prefix                        = local.name_prefix
  default_tags                       = local.default_tags
}

module "appstream_stack" {
  source       = "./modules/appstream/stack"
  vpce_id      = module.appstream_vpc_endpoint.id
  name_prefix  = local.name_prefix
  default_tags = local.default_tags

  depends_on = [
    module.appstream_vpc_endpoint
  ]
}

resource "aws_appstream_fleet_stack_association" "this" {
  fleet_name = module.appstream_fleet.name
  stack_name = module.appstream_stack.name

  depends_on = [
    module.appstream_stack,
    module.appstream_fleet
  ]

}
 