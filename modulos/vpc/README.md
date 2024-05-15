## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Usage

```hcl
module "vpc" {
  source = "git@github.com:elvenworks-ps/professional-services.git//terraform-modules//vpc"

  name                 = "my-vpc"
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags        = local.tags
  environment = local.environment

  private_subnets         = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnets          = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  map_public_ip_on_launch = true

  igwname = "my-igw"
  natname = "my-nat"
  rtname  = "my-rt"
  
  private_subnets_tags = {
    "kubernetes.io/cluster/develop"   = "shared",
    "kubernetes.io/role/internal-elb" = 1
  }
  
  public_subnets_tags  = {
    "kubernetes.io/cluster/develop" = "shared",
    "kubernetes.io/role/elb"        = 1
  }

  route_table_routes_private = {
    ## add block to create route in subnet-public
    "peer" = {
      "cidr_block"                = "10.10.0.0/16"
      "vpc_peering_connection_id" = "pcx-xxxxxxxxxxxxx"
    }
  }
  route_table_routes_public = {
    ## add block to create route in subnet-private
    "peer" = {
      "cidr_block"                = "10.10.0.0/16"
      "vpc_peering_connection_id" = "pxc-xxxxxxxxxxxxxxx"
    }

  }
}
```

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_flow_log.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.azs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The IPv4 CIDR block for the VPC. | `string` | n/a | yes |
| <a name="input_create_aws_flow_log"></a> [create\_aws\_flow\_log](#input\_create\_aws\_flow\_log) | Create vpc flow log | `bool` | `false` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enable dns hostnames | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable dns support | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Env tags | `string` | `null` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | IAM role flow logs | `string` | `null` | no |
| <a name="input_igwname"></a> [igwname](#input\_igwname) | Name to be used the resources as identifier | `string` | n/a | yes |
| <a name="input_instance_tenancy"></a> [instance\_tenancy](#input\_instance\_tenancy) | A tenancy option for instances launched into the VPC. Default is default | `string` | `"default"` | no |
| <a name="input_log_destination_arn"></a> [log\_destination\_arn](#input\_log\_destination\_arn) | ARN log\_destination\_arn | `string` | `null` | no |
| <a name="input_map_public_ip_on_launch"></a> [map\_public\_ip\_on\_launch](#input\_map\_public\_ip\_on\_launch) | Should be false if you do not want to auto-assign public IP on launch | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on all the resources as identifier | `string` | n/a | yes |
| <a name="input_natname"></a> [natname](#input\_natname) | Name to be used the resources as identifier | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnets inside the VPC | `list(string)` | `[]` | no |
| <a name="input_private_subnets_tags"></a> [private\_subnets\_tags](#input\_private\_subnets\_tags) | A mapping of tags to assign to the resource | `map(any)` | `{}` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets inside the VPC | `list(string)` | `[]` | no |
| <a name="input_public_subnets_tags"></a> [public\_subnets\_tags](#input\_public\_subnets\_tags) | A mapping of tags to assign to the resource | `map(any)` | `{}` | no |
| <a name="input_route_table_routes_private"></a> [route\_table\_routes\_private](#input\_route\_table\_routes\_private) | n/a | `map(any)` | `{}` | no |
| <a name="input_route_table_routes_public"></a> [route\_table\_routes\_public](#input\_route\_table\_routes\_public) | n/a | `map(any)` | `{}` | no |
| <a name="input_rtname"></a> [rtname](#input\_rtname) | Name to be used the resources as identifier | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_igw"></a> [igw](#output\_igw) | Output vpc cidr |
| <a name="output_nat"></a> [nat](#output\_nat) | Output vpc cidr |
| <a name="output_private_cidrs"></a> [private\_cidrs](#output\_private\_cidrs) | Output subnet private |
| <a name="output_private_ids"></a> [private\_ids](#output\_private\_ids) | Output subnet private |
| <a name="output_public_cidrs"></a> [public\_cidrs](#output\_public\_cidrs) | Output subnet public |
| <a name="output_public_ids"></a> [public\_ids](#output\_public\_ids) | Output subnet public |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | Output vpc cidr |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | Output vpc id |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | Output vpc name |
