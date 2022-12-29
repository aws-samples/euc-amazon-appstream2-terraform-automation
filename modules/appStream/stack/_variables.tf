variable "vpce_id" {
  description = "ID of the VPC Endpoint through which traffic will flow to the AppStream stack"
  type        = string
  default     = ""
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