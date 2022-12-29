resource "aws_security_group" "appstream_endpoint_sg" {
  name        = "${var.name_prefix}appstream_endpoint_sg"
  description = "Allow AppStream streaming traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = var.security_group_cidrs
  }

  ingress {
    description      = "Allow Streaming traffic"
    from_port        = 1400
    to_port          = 1499
    protocol         = "tcp"
    cidr_blocks      = var.security_group_cidrs
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.default_tags, {
    Name        = "${var.name_prefix}appstream_endpoint_sg"
  })
}

resource "aws_vpc_endpoint" "appstream_interface" {
  vpc_id             = var.vpc_id
  service_name       = "com.amazonaws.${var.aws_region}.appstream.streaming"
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.appstream_endpoint_sg.id]
  subnet_ids         = var.subnet_ids

  tags = merge(var.default_tags, {
    Name        = "${var.name_prefix}appstream_interface_endpoint"
  })
}