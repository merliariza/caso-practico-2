# Grupo de recursos que contendrá la infraestructura del Caso Práctico 2
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Registro privado donde se almacenarán las imágenes de las dos aplicaciones
resource "azurerm_container_registry" "main" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true
}