resource "aws_security_group" "appstream_image_builder" {
  name        = "${var.name_prefix}appstream_image_builder_sg"
  description = "Image Builder Security Group"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow Https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = var.security_group_cidrs
  }

  egress {
    description      = "Allow all outbound traffic"
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
  description                    = "Image Builder for Application client"
  display_name                   = "Image Builder for Application client"
  enable_default_internet_access = false
  image_name                     = var.image_name
  instance_type                  = var.instance_type

  access_endpoint {
    endpoint_type = "STREAMING"
    vpce_id       = var.vpce_id
  }

  vpc_config {
    subnet_ids         = [var.subnet_id]
    security_group_ids = [aws_security_group.appstream_image_builder.id]
  }

  tags = merge(var.default_tags, {
    Name = "${var.name_prefix}appstream_image_builder"
  })
}