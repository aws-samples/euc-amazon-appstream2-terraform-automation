variable "vpc_id" {
  description = "Value of the VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet in which the image builder needs to be created"
  type        = string
}

variable "image_name" {
  description = "Name of the image"
  type        = string
  default     = "AppStream-WinServer2019-03-03-2022"
}

variable "instance_type" {
  description = "Type and size of the image builder instance"
  type        = string
  default     = "stream.standard.medium"
}

variable "security_group_cidrs" {
  description = "The CIDRs to which traffic can be routed"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix for resource names and tags"
  default     = ""
}

variable "default_tags" {
  description = "Map of default tags"
  type = map(string)
  default = {}
}