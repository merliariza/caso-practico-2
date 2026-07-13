variable "resource_group_name" {
  description = "Nombre del grupo de recursos del Caso Práctico 2"
  type        = string
  default     = "rg-casopractico2"
}

variable "location" {
  description = "Región de Azure donde se desplegarán los recursos"
  type        = string
  default     = "mexicocentral"
}

variable "acr_name" {
  description = "Nombre único del Azure Container Registry"
  type        = string
  default     = "acrmerliarizacp2"
}

# Networking

variable "vnet_name" {
  description = "Nombre de la red virtual"
  type        = string
  default     = "vnet-casopractico2"
}

variable "subnet_name" {
  description = "Nombre de la subred"
  type        = string
  default     = "subnet-main"
}

variable "address_space" {
  description = "Espacio de direcciones de la VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefix" {
  description = "Rango IP de la subred"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "public_ip_name" {
  description = "Nombre de la IP pública"
  type        = string
  default     = "pip-vm"
}

variable "nsg_name" {
  description = "Nombre del Network Security Group"
  type        = string
  default     = "nsg-vm"
}

variable "nic_name" {
  description = "Nombre de la interfaz de red"
  type        = string
  default     = "nic-vm"
}
