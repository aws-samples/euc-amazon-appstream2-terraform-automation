# Terraform for AWS AppStream 2.0

This is a Terraform module to deploy AppStream 2.0 resources.
## Quick Start
To provision AppStream 2.0 resources from your local to your AWS account, do the following.
1. Clone this repo to your local
2. Ensure that you have Terraform installed on your local
3. Ensure that you have configured your local environment with the AWS credentials that will be needed by Terraform
4. Initialize the Terraform environment using `terraform init` command
5. Override the defaults in the `_locals.tf` file
6. Execute the module using the `terraform apply` command


## AppStream Resources
Amazon AppStream 2.0 is a fully managed, secure application streaming service that allows streaming of desktop applications from AWS to a web browser. AppStream 2.0 manages the AWS resources required to host and run applications, scales automatically, and provides access to users on demand. Below are some of the important components that make up the AppStream ecosystem.

### Image builder
An image builder is a virtual machine that is used to create an image. After an image builder instance is created, the application to be streamed should be installed, configured and tested on the image builder, and then use it to create an image. 

### Fleet
A fleet consists of fleet instances (also known as streaming instances) that run the application. Note that each end user requires one fleet instance.

### Stack
A stack consists of an associated fleet, user access policies, and storage configurations. A stack should be setup to start streaming applications to users.

### AWS Managed VPC
All of the AppStream related components would be deployed within an AWS Managed VPC which is transparent to the customer. The AppStream image builder and fleet instances integrate with other resources in the customer VPC via ENIs that are provisioned along with the corresponding AppStream components.

### VPC Endpoint
Streaming traffic to and from AppStream can be kept private instead of using the public internet. This can be achieved by provisioning a VPC Endpoint in the Customer VPC through which the AppStream streaming traffic would flow. 

## Network Connectivity
- **Streaming connectivity** - Since all streaming traffic would flow through the VPC endpoint, the endpoint should be created in the front end subnet where the user traffic will commence. For this reason, the security groups of all the AppStream resources would restrict traffic to only the CIDR range of the front end subnet.

- **Application resource connectivity** - Connectivity between the AppStream resources and the resources in the application VPC is established through ENIs. As part of the provisioning, AppStream creates an ENI for each of the AppStream instances (Image builder & Fleet) in the application subnet. 

## Orchestration
An AppStream setup would typically involve the following steps:

1. Provision the AppStream Image builder with a base image and VPC Endpoint
2. Install the application components on the image builder
3. Create a snapshot of the image builder
4. Use the snapshot image to create the AppStream fleet
5. Provision the AppStream stack and associate with the fleet


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.22 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.22.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_appstream_fleet"></a> [appstream\_fleet](#module\_appstream\_fleet) | ./modules/appstream/fleet | n/a |
| <a name="module_appstream_image_builder"></a> [appstream\_image\_builder](#module\_appstream\_image\_builder) | ./modules/appStream/image-builder | n/a |
| <a name="module_appstream_stack"></a> [appstream\_stack](#module\_appstream\_stack) | ./modules/appstream/stack | n/a |
| <a name="module_appstream_vpc_endpoint"></a> [appstream\_vpc\_endpoint](#module\_appstream\_vpc\_endpoint) | ./modules/vpc-endpoint | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_appstream_fleet_stack_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appstream_fleet_stack_association) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnets.app_subnets](https://registry.terraform.io/providers/hashicorp/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.app_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Name of the application | `string` | `""` | no |
| <a name="input_app_subnet_name"></a> [app\_subnet\_name](#input\_app\_subnet\_name) | Wildcard identifier of the application subnet referenecd in the data source to get the subnet ID. ENIs for Image builder and fleet instances will be created in this subnet in order to provide connectivity to other application resources | `string` | `"*App*"` | no |
| <a name="input_desired_fleet_instances_count"></a> [desired\_fleet\_instances\_count](#input\_desired\_fleet\_instances\_count) | Desired number of instances in the AppStream fleet at startup | `number` | `1` | no |
| <a name="input_fleet_idle_disconnect_timeout_in_seconds"></a> [fleet\_idle\_disconnect\_timeout\_in\_seconds](#input\_fleet\_idle\_disconnect\_timeout\_in\_seconds) | Amount of time that users can be idle before they are disconnected from their streaming session | `number` | `600` | no |
| <a name="input_fleet_image_name"></a> [fleet\_image\_name](#input\_fleet\_image\_name) | Name of the application image used to provision the fleet instances | `string` | n/a | yes |
| <a name="input_fleet_instance_type"></a> [fleet\_instance\_type](#input\_fleet\_instance\_type) | Type and size of the AppStream fleet instance | `string` | `"stream.standard.medium"` | no |
| <a name="input_fleet_max_user_duration_in_seconds"></a> [fleet\_max\_user\_duration\_in\_seconds](#input\_fleet\_max\_user\_duration\_in\_seconds) | Maximum amount of time that a streaming session can remain active, in seconds. Maximum session duration is 96 hours | `number` | `7200` | no |
| <a name="input_fleet_type"></a> [fleet\_type](#input\_fleet\_type) | Type of the fleet instance that determines the start-up time and cost of the instance. Applicable types are 'ALWAYS\_ON' and 'ON\_DEMAND' | `string` | `"ON_DEMAND"` | no |
| <a name="input_image_builder_base_image_name"></a> [image\_builder\_base\_image\_name](#input\_image\_builder\_base\_image\_name) | Name of the base image in the AppStream Image registry that will be used to build the image builder instance | `string` | `"AppStream-WinServer2019-03-03-2022"` | no |
| <a name="input_front_end_subnet_name"></a> [front\_end\_subnet\_name](#input\_front\_app\_subnet\_name) | Wildcard identifier of the Front end subnet referenced in the data source to get the subnet ID. All the streaming traffic will flow through the front end subnet and hence the VPC endpoint will be provisioned in this subnet | `string` | `"*FrontEnd*"` | no |
| <a name="input_image_builder_instance_type"></a> [image\_builder\_instance\_type](#input\_image\_builder\_instance\_type) | Type and size of the image builder instance | `string` | `"stream.standard.medium"` | no |
| <a name="input_security_group_cidrs"></a> [security\_group\_cidrs](#input\_security\_group\_cidrs) | The CIDRs from which ingress traffic will be allowed in the security group | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Wildcard identifier of the Customer VPC referenced in the data source to get the VPC ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_appstream_fleet_name"></a> [appstream\_fleet\_name](#output\_appstream\_fleet\_name) | The name of the AppStream fleet |
| <a name="output_appstream_stack_name"></a> [appstream\_stack\_name](#output\_appstream\_stack\_name) | The name of the AppStream stack |
<!-- END_TF_DOCS -->

# Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

# License

This library is licensed under the MIT-0 License. See the LICENSE file.