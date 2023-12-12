resource "aws_security_group" "appstream_image_builder" {
  name        = "${var.name_prefix}appstream_image_builder_sg"
  description = "Security group of the image builder"
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
    Name = "${var.name_prefix}appstream_image_builder_sg"
  })
}

resource "aws_appstream_image_builder" "app_image_builder" {
  name                           = "${var.name_prefix}appstream_image_builder"
  description                    = "Application client image builder"
  display_name                   = "Application client image builder"
  enable_default_internet_access = false
  image_name                     = var.image_name
  instance_type                  = var.instance_type

  vpc_config {
    subnet_ids         = [var.subnet_id]
    security_group_ids = [aws_security_group.appstream_image_builder.id]
  }

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}appstream_image_builder"
  })
}