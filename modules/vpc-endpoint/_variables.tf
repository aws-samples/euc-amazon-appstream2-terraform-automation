variable "vpc_id" {
  description = "Value of the VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Value of the Subnet ID"
  type        = list(string)
}

variable "security_group_cidrs" {
  description = "The CIDRs to which traffic can be routed"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix for resource name and tags"
  default = ""
}

variable "aws_region" {
  description = "The region of the AWS resources"
  default = ""
}

variable "default_tags" {
  description = "Map of default tags"
  type = map(string)
  default = {}
}

