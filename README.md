# terraform-btcpool-aws-node

[![open-issues](https://img.shields.io/github/issues-raw/insight-infrastructure/terraform-btcpool-aws-node?style=for-the-badge)](https://github.com/insight-infrastructure/terraform-btcpool-aws-node/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-infrastructure/terraform-btcpool-aws-node?style=for-the-badge)](https://github.com/insight-infrastructure/terraform-btcpool-aws-node/pulls)

> Note - WIP 
> Finishing up for milestone 1 delivery for the [Nervos, btcpool Stratum V2 spec upgrade](https://talk.nervos.org/t/insight-automated-stratum-v2-mining-pool-for-nervos/4870).  
> Only Nervos currently supported. More chains in the future. 

## Features

This module sets up a stratum v1 btcpool mining pool on AWS for the Nervos Blockchain. It uses an 
[Ansible role](https://github.com/insight-stratum/ansible-role-btcpool) 
to configure a node with docker and run a [btcpool docker-compose](https://github.com/insight-stratum/btcpool-docker-compose) 
setup. Decoupling of the components into managed services (ie MSK for Kafka) is possible with modification of the
 docker-compose. 

For Alibaba Cloud, check github organization. 

#### Dependencies 

- [ansible-role-btcpool](https://github.com/insight-stratum/ansible-role-btcpool)
- [btcpool-docker-compose](https://github.com/insight-stratum/btcpool-docker-compose)
- [btcpool](https://github.com/btccom/btcpool)

## Terraform Versions

For Terraform v0.13.0+

## Usage

Install terraform v0.13+, get AWS credentials, clone this directory and cd into it. 

```shell script
# Create ssh keys and take note of path 
ssh-keygen -b 4096 

# Initialize terraform
cd examples/defaults 
terraform init

# Start terraform
# You will then be prompted to supply the path to your ssh key. 
terraform apply 
```

Actual terraform. 

```hcl
variable "private_key_path" {}
variable "public_key_path" {}

module "defaults" {
  source = "github.com/insight-infrastructure/terraform-btcpool-aws-node"
  private_key_path = var.private_key_path
  public_key_path  = var.public_key_path
}
```

## Examples

- [defaults](https://github.com/insight-infrastructure/terraform-btcpool-aws-node/tree/master/examples/defaults)

## Known  Issues

- [ ] Expose ansible file attrs to user 
- [ ] Support ssl (Only if going to UI - spec is AEAD encryption)

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
| instance\_type | Instance type | `string` | `"t3.small"` | no |
| key\_name | The key pair to import - leave blank to generate new keypair from pub/priv ssh key path | `string` | `""` | no |
| monitoring | Boolean for cloudwatch | `bool` | `false` | no |
| name | The name for the label | `string` | `"btcpool"` | no |
| playbook\_vars | Additional playbook vars | `map(string)` | `{}` | no |
| private\_key\_path | The path to the private ssh key | `string` | n/a | yes |
| private\_port\_cidrs | List of CIDR blocks for private ports | `list(string)` | <pre>[<br>  "172.31.0.0/16"<br>]</pre> | no |
| private\_ports | List of publicly open ports | `list(number)` | `[]` | no |
| public\_key\_path | The path to the public ssh key | `string` | n/a | yes |
| public\_ports | List of publicly open ports | `list(number)` | <pre>[<br>  22,<br>  1800,<br>  8080,<br>  8081,<br>  8114,<br>  8115,<br>  2181<br>]</pre> | no |
| root\_iops | n/a | `string` | n/a | yes |
| root\_volume\_size | Root volume size | `number` | `8` | no |
| root\_volume\_type | n/a | `string` | `"gp2"` | no |
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

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.
