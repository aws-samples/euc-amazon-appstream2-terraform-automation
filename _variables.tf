variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "AWSomeApp"
}

variable "vpc_name" {
  description = "Name of the Customer VPC. Referenced in the data source to get the VPC ID"
  type        = string
}

variable "app_subnet_name" {
  description = "Name of the application subnet. Referenced in the data source to get the subnet ID. ENIs for image builder instances will be created in this subnet in order to provide connectivity to other application resources"
  type        = string
}

variable "image_builder_base_image_name" {
  description = "Name of the base image in the AppStream 2.0 Image registry that will be used to build the image builder instance"
  type        = string
  #default     = "AppStream-WinServer2019-11-13-2023"
}

variable "image_builder_instance_type" {
  description = "Type and size of the image builder instance"
  type        = string
  default     = "stream.standard.medium"
}

variable "fleet_type" {
  description = "Type of the fleet instance that determines the start-up time and cost of the instance. Applicable types are 'ALWAYS_ON' and 'ON_DEMAND'"
  type        = string
  default     = "ON_DEMAND"
}

variable "desired_fleet_instances_count" {
  description = "Desired number of instances in the AppStream 2.0 fleet at startup"
  type        = number
  default     = 1
}

variable "fleet_max_user_duration_in_seconds" {
  description = "Maximum amount of time that a streaming session can remain active, in seconds. Maximum session duration is 120 hours"
  type        = number
  default     = 28800
}

variable "fleet_disconnect_timeout_in_seconds" {
  description = "Amount of time that a streaming session remains active after users disconnect, in seconds. If users do not logout and try to reconnect within this time interval, they are connected to their previous session"
  type        = number
  default     = 1800
}

variable "fleet_idle_disconnect_timeout_in_seconds" {
  description = "Amount of time that users can be idle before they are disconnected from their streaming session, in seconds"
  type        = number
  default     = 600
}

variable "fleet_image_name" {
  description = "Name of the application image used to provision the fleet instances"
  type        = string
  default     = "Amazon-AppStream2-Sample-Image-03-11-2023"
}

variable "fleet_instance_type" {
  description = "Type and size of the AppStream 2.0 fleet instance"
  type        = string
  default     = "stream.standard.medium"
}

variable "tag_environment_type" {
  description = "The environment where the resource is deployed. Example: Dev, QA, Prod"
  type        = string
  default     = "Dev"
}

variable "tag_app_id" {
  description = "Unique identifier for the application to which the resource belongs to"
  type        = string
  default     = ""
}