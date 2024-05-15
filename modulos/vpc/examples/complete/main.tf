locals {
  environment = "staging"
  tags = {
    Environment = "staging"
  }
}

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

  public_subnets_tags = {
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
