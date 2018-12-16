# Terraform VPC Module
A Terraform module that helps setting up VPC in GCP.

Supports creating following:
- A Google Virtual Private Network
- Provision Custom Subnets or let Google create Auto Subnets

Future Considerations to add:
- Shared VPC
- Routing Support
- Secondary Ranges

## Usage
Example folder covers how to create VPC with either auto-created subnets or custom ones. The simplest config to get a VPC generated is shown below:

```hcl
module "auto-vpc" {
    source  = "github.com/muvaki/terraform-google-vpc"

    name                    = "test-vpc"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | A unique name for the the VPC resource. | string | - | yes|
| project | Project ID where the VPC will be created. Can be left empty and it will pick it up from provider project | string. | "" | no |
| auto_create_subnetworks | If you want Google to auto provision the subnets (true/false). | string | "true" | no |
| routing_mode |  Sets the network-wide routing mode for Cloud Routers to use. Accepted values are GLOBAL or REGIONAL. | string | "GLOBAL" | yes |
| subnetworks |  A list of subnetworks created| list | [] | no |
| module_dependency | Pass an output from another variable/module to create dependency | string | "" | no |




### subnetworks Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region | Region for subnet | string | - | yes|
| cidr | Cidr range for subnet | - | yes |
| enable_flow_logs | Enable flow logs for subnets (true/false). | string | "false" | no |
| private_ip_google_access | Enable Private IP access to googleapis (true/false).| string | "true" | no |

## Outputs

| Name | Description | 
|------|-------------|
| name | Name of the created VPC |
| gateway_ipv4 | The IPv4 address of the gateway |
| self_link | The URI of the VPC created. |
| routing_mode |  Sets the network-wide routing mode for Cloud Routers to use. Accepted values are GLOBAL or REGIONAL. |
| subnetworks_self_links | the list of subnetworks which belong to the network |

## Docs:

module reference docs: 
- terraform.io (v0.11.10)
- https://cloud.google.com/compute/docs/vpc

### LICENSE

MIT License