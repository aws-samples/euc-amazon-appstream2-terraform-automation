resource "aws_security_group" "appstream_fleet" {
  name        = "${var.name_prefix}appstream_fleet_sg"
  description = "AppStream 2.0 Fleet Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Custom ingress rule"
    from_port        = var.security_group_ingress_port
    to_port          = var.security_group_ingress_port
    protocol         = var.security_group_ingress_protocol
    cidr_blocks      = var.security_group_ingress_cidrs
  }

  egress {
    description      = "All access egress rule"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}appstream_fleet_sg"
  })

}

resource "aws_appstream_fleet" "app_fleet" {
  name = "${var.name_prefix}appstream_fleet"

  compute_capacity {
    desired_instances = var.desired_fleet_instances_count
  }

  description                        = "AppStream 2.0 fleet for application client"
  display_name                       = "AppStream 2.0 fleet for application client"
  enable_default_internet_access     = false
  fleet_type                         = var.fleet_type
  image_name                         = var.image_name
  instance_type                      = var.instance_type
  max_user_duration_in_seconds       = var.max_user_duration_in_seconds
  disconnect_timeout_in_seconds      = var.disconnect_timeout_in_seconds
  idle_disconnect_timeout_in_seconds = var.idle_disconnect_timeout_in_seconds

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.appstream_fleet.id]
  }

  # domain_join_info {
  #  directory_name = 
  # }

  # iam_role_arn = 

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}appstream_fleet"
  })

}