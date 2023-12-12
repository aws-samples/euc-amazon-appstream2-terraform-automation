data "aws_region" "current" {
}

data "aws_vpc" "app_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "app_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.app_vpc.id]
  }
  filter {
    name   = "tag:Name"
    values = [var.app_subnet_name]
  }

}

data "aws_subnet" "routable_subnets" {
  for_each = toset(data.aws_subnets.app_subnets.ids)
  id       = each.value
}