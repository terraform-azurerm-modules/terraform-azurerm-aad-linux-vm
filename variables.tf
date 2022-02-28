variable "name" {
  description = "Hostname for the VM."
  type        = string
}

variable "subnet_id" {
  description = "Resource ID for a subnet."
  type        = string
}

variable "resource_group_name" {
  description = "Name for the resource group. Required."
  type        = string
}

variable "size" {
  description = "Azure virtual machine size. Needs to support Gen2."
  default     = "Standard_B2s"
}

variable "location" {
  description = "Azure region."
  default     = "West Europe"
}

variable "tags" {
  description = "Map of tags for the resources created by this module."
  type        = map(string)
  default     = {}
}

//=============================================================

variable "admin_username" {
  description = "VM admin username."
  default     = "azureadmin"
}

variable "admin_ssh_public_key_file" {
  description = "Public key file to use."
  default     = "~/.ssh/id_rsa.pub"
}

variable "cloud_init" {
  description = "Cloud-init format YAML."
  type        = string
  default     = null
}
