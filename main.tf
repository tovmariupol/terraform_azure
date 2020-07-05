provider "azurerm" {
  version = "~> 2.17"
  features {}
}

resource "azurerm_resource_group" "k8s_lab" {
  name     = "${var.prefix}-k8s-resources"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "k8s_lab" {
  name                = "${var.prefix}-law"
  resource_group_name = azurerm_resource_group.k8s_lab.name
  location            = azurerm_resource_group.k8s_lab.location
  sku                 = "PerGB2018"
}

resource "azurerm_log_analytics_solution" "k8s_lab" {
  solution_name         = "Containers"
  workspace_resource_id = azurerm_log_analytics_workspace.k8s_lab.id
  workspace_name        = azurerm_log_analytics_workspace.k8s_lab.name
  location              = azurerm_resource_group.k8s_lab.location
  resource_group_name   = azurerm_resource_group.k8s_lab.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Containers"
  }
}

resource "azurerm_kubernetes_cluster" "k8s_lab" {
  name                = "${var.prefix}-k8s"
  location            = azurerm_resource_group.k8s_lab.location
  resource_group_name = azurerm_resource_group.k8s_lab.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = true
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.k8s_lab.id
    }
  }
}

