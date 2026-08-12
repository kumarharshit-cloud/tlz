variable "rg_parent" {}
module "resource_group" {
  source = "../Enviorment/Resource"
  rg     = var.rg_parent
}

variable "vnet_parent" {}
module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../Enviorment/Virtual_Network"
  vnet       = var.vnet_parent
}

variable "snet_parent" {}
module "subnet" {
  depends_on = [module.resource_group, module.virtual_network]
  source     = "../Enviorment/Subnet"
  snet       = var.snet_parent
}

variable "pip_parent" {}
module "Public_IP" {
  depends_on = [module.resource_group]
  source     = "../Enviorment/Public_IP"
  pip        = var.pip_parent

}

variable "vm_parent" {}
module "virtual_machine" {
  depends_on = [module.resource_group, module.virtual_network, module.subnet]
  source     = "../Enviorment/NIC"
  vm         = var.vm_parent
}

variable "bat_parent" {}
module "bastion" {
  depends_on = [module.resource_group, module.virtual_network, module.subnet]
  source     = "../Enviorment/Bastion"
  bat        = var.bat_parent
}
