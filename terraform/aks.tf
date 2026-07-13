resource "azurerm_kubernetes_cluster" "main" {
  name                = "aks-casopractico2"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "aks-casopractico2"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_b2s_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "CasoPractico2"
  }
}
