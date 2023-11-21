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

variable "security_group_ingress_cidrs" {
  description = "The CIDRs from which ingress traffic will be allowed in the security group"
  type        = list(string)
}

variable "security_group_ingress_port" {
  description = "The port on which ingress traffic will be allowed in the security group"
  type        = string
  default     = "22"
}
variable "security_group_ingress_protocol" {
  description = "The protocol for which ingress traffic will be allowed in the security group"
  type        = string
  default     = "tcp"
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