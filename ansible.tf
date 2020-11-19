#########
# Ansible
#########
variable "playbook_vars" {
  description = "Additional playbook vars"
  type        = map(string)
  default     = {}
}

variable "bastion_user" {
  description = "Optional bastion user - blank for no bastion"
  type        = string
  default     = ""
}

variable "bastion_ip" {
  description = "Optional IP for bastion - blank for no bastion"
  type        = string
  default     = ""
}

variable "enable_btcpool_ssl" {
  description = "Bool to enable SSL"
  type        = bool
  default     = false
}

variable "btcpool_env_file_path" {
  description = "Path to .env file for deployment"
  type        = string
  default     = ""
}

module "ansible" {
  source           = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git?ref=v0.14.0"
  create           = var.create
  ip               = join("", aws_eip_association.this.*.public_ip)
  user             = "ubuntu"
  private_key_path = pathexpand(var.private_key_path)

  bastion_ip   = var.bastion_ip
  bastion_user = var.bastion_user

  playbook_file_path = "${path.module}/ansible/main.yml"
  playbook_vars = merge({
    enable_btcpool_ssl = var.domain_name != "" ? false : var.enable_btcpool_ssl
    env_file_path      = var.btcpool_env_file_path
  }, var.playbook_vars)

  requirements_file_path = "${path.module}/ansible/requirements.yml"
}

