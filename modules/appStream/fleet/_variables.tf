variable "vpc_id" {
  description = "Value of the VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "IDs of the subnets in which the image builder needs to be created"
  type        = list(string)
}

variable "fleet_type" {
  description = "Type of the fleet instance that determines the start-up time and cost"
  type        = string
  default     = "ON_DEMAND"
}

variable "desired_fleet_instances_count" {
  description = "Desired number of instances in the AppStream fleet"
  type        = number
  default     = 1
}

variable "max_user_duration_in_seconds" {
  description = "Maximum amount of time that a streaming session can remain active, in seconds. Maximum possible duration is 96 hours"
  type        = number
  default     = 1800  
}

variable "disconnect_timeout_in_seconds" {
  description = "Amount of time that a streaming session remains active after users disconnect, in seconds. If users do not logout and try to reconnect within this time interval, they are connected to their previous session"
  type        = number
  default     = 1800  
}

variable "idle_disconnect_timeout_in_seconds" {
  description = "Amount of time that users can be idle before they are disconnected from their streaming session, in seconds"
  type        = number
  default     = 60
}

variable "image_name" {
  description = "Name of the image from which to build the fleet"
  type        = string
  default     = "Amazon-AppStream2-Sample-Image-02-04-2019"
}

variable "instance_type" {
  description = "Type and size of the fleet instance"
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