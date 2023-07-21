variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "AWSomeApp"
}

variable "vpc_name" {
  description = "Wildcard identifier of the Customer VPC referenced in the data source to get the VPC ID"
  type        = string
  default     = "AppStreamCustVPC"
}

variable "front_end_subnet_name" {
  description = "Wildcard identifier of the Front end subnet referenced in the data source to get the subnet ID. All the streaming traffic will flow through the front end subnet and hence the VPC endpoint will be provisioned in this subnet"
  type        = string
  default     = "*FrontEnd*"
}

variable "app_subnet_name" {
  description = "Wildcard identifier of the application subnet referenced in the data source to get the subnet ID. ENIs for Image builder instances will be created in this subnet in order to provide connectivity to other application resources"
  type        = string
  default     = "*App*"
}

variable "image_builder_base_image_name" {
  description = "Name of the base image in the AppStream Image registry that will be used to build the image builder instance"
  type        = string
  #default     = "AppStream-WinServer2012R2-03-29-2023"
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
  description = "Desired number of instances in the AppStream fleet at startup"
  type        = number
  default     = 1
}

variable "fleet_max_user_duration_in_seconds" {
  description = "Maximum amount of time that a streaming session can remain active, in seconds. Maximum session duration is 96 hours"
  type        = number
  default     = 7200
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
  #default     = "Amazon-AppStream2-Sample-Image-03-11-2023"
}

variable "fleet_instance_type" {
  description = "Type and size of the AppStream fleet instance"
  type        = string
  default     = "stream.standard.medium"
}

variable "security_group_cidrs" {
  description = "The CIDRs from which ingress traffic will be allowed in the security group"
  type        = list(string)
  default     = ["0.0.0.0/0"]
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