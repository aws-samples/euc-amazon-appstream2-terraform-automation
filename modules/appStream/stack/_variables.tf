variable "name_prefix" {
  description = "Prefix for resource names and tags"
  default     = ""
}

variable "default_tags" {
  description = "Map of default tags"
  type = map(string)
  default = {}
}