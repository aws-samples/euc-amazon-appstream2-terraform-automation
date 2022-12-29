data "aws_region" "current" {
}

data "aws_vpc" "app_vpc" {
  filter {
    name   = "tag:Name"
    values = [local.vpc_name]
  }
}

data "aws_subnets" "app_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.app_vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = [local.app_subnet_name]
  }

}

data "aws_subnets" "front_end_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.app_vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = [local.front_end_subnet_name]
  }

}

data "aws_subnet" "routable_front_end" {
  for_each = toset(data.aws_subnets.front_end_subnets.ids)
  id       = each.value
}