# terraform-btcpool-aws-node

[![open-issues](https://img.shields.io/github/issues-raw/insight-nervos/terraform-btcpool-aws-node?style=for-the-badge)](https://github.com/insight-nervos/terraform-btcpool-aws-node/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-nervos/terraform-btcpool-aws-node?style=for-the-badge)](https://github.com/insight-nervos/terraform-btcpool-aws-node/pulls)

## Features

This module sets up a stratum v1 btcpool mining pool on AWS for the Nervos Blockchain. It uses an [Ansible role](https://github.com/insight-stratum/ansible-role-btcpool) 
to configure a node with docker and run a [btcpool docker-compose](https://github.com/insight-stratum/btcpool-docker-compose) 
setup. 

For Alibaba Cloud, check github organization. 

#### Dependencies 

- [ansible-role-btcpool](https://github.com/insight-stratum/ansible-role-btcpool)
- [btcpool-docker-compose](https://github.com/insight-stratum/btcpool-docker-compose)
- [btcpool](https://github.com/btccom/btcpool)

## Terraform Versions

For Terraform v0.13.0+

## Usage

[Install terraform v0.13+](https://learn.hashicorp.com/tutorials/terraform/install-cli), [get AWS credentials](https://www.notion.so/insightx/AWS-c90173ac063d43a9921634bf0bc55bf4), clone this directory and cd into it. 

```shell script
# Create ssh keys and take note of path 
ssh-keygen -b 4096 
nano terraform.tfvars 
# Modify the terraform.tfvars and remove comments ('//')
terraform init 
terraform apply 
```

### Example module 

```hcl
variable "private_key_path" {}
variable "public_key_path" {}

module "defaults" {
  source = "github.com/insight-nervos/terraform-btcpool-aws-node"
  private_key_path = var.private_key_path
  public_key_path  = var.public_key_path
}
```

## Examples

- [defaults](https://github.com/insight-nervos/terraform-btcpool-aws-node/tree/master/examples/defaults)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| additional\_policy\_arns | List of additional policy arns | `list(string)` | `[]` | no |
| additional\_security\_group\_ids | List of security groups | `list(string)` | `[]` | no |
| ami | AMI to use as base image - blank for ubuntu | `string` | `""` | no |
| bastion\_ip | Optional IP for bastion - blank for no bastion | `string` | `""` | no |
| bastion\_user | Optional bastion user - blank for no bastion | `string` | `""` | no |
| btcpool\_env\_file\_path | Path to .env file for deployment | `string` | `""` | no |
| create | Boolean to create resources or not | `bool` | `true` | no |
| create\_dns | Bool to create ssl cert and nginx proxy | `bool` | `true` | no |
| create\_iam | Bool to create iam role | `bool` | `false` | no |
| create\_sg | Bool for create security group | `bool` | `true` | no |
| domain\_name | The domain - example.com. Blank for no ssl / nginx | `string` | `""` | no |
| enable\_btcpool\_ssl | Bool to enable SSL | `bool` | `false` | no |
| hostname | The hostname - ie hostname.example.com - blank for example.com | `string` | `""` | no |
| instance\_type | Instance type | `string` | `"t3.medium"` | no |
| key\_name | The key pair to import - leave blank to generate new keypair from pub/priv ssh key path | `string` | `""` | no |
| monitoring | Boolean for cloudwatch | `bool` | `false` | no |
| name | The name for the label | `string` | `"btcpool"` | no |
| playbook\_vars | Additional playbook vars | `map(string)` | `{}` | no |
| private\_key\_path | The path to the private ssh key | `string` | n/a | yes |
| private\_port\_cidrs | List of CIDR blocks for private ports.  This can be for private networks or stable IPs. | `list(string)` | <pre>[<br>  "172.31.0.0/16"<br>]</pre> | no |
| private\_ports | List of private ports | `list(number)` | `[]` | no |
| public\_key\_path | The path to the public ssh key | `string` | n/a | yes |
| public\_ports | List of publicly open ports | `list(number)` | <pre>[<br>  22,<br>  1800,<br>  8114,<br>  8115,<br>  9021,<br>  9090,<br>  3000<br>]</pre> | no |
| root\_iops | n/a | `string` | n/a | yes |
| root\_volume\_size | Root volume size | `number` | `40` | no |
| root\_volume\_type | n/a | `string` | `"gp2"` | no |
| stack\_type | The type of stack to deploy - | `string` | `"prometheus"` | no |
| subnet\_id | The id of the subnet | `string` | `""` | no |
| suffix | Suffix to attach to name | `string` | `""` | no |
| tags | Map of tags | `map(string)` | `{}` | no |
| vpc\_id | Custom vpc id - leave blank for deault | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | n/a |
| instance\_type | n/a |
| key\_name | n/a |
| public\_ip | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [insight-infrastructure](https://github.com/insight-infrastructure)

## License

Apache 2 Licensed. See LICENSE for full details.
