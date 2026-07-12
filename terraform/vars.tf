variable "resource_group_name" {
  description = "Nombre del grupo de recursos del Caso Práctico 2"
  type        = string
  default     = "rg-casopractico2"
}

variable "location" {
  description = "Región de Azure donde se desplegarán los recursos"
  type        = string
  default     = "eastus"
}

variable "acr_name" {
  description = "Nombre único del Azure Container Registry"
  type        = string
  default     = "acrmerliarizacp2"
}