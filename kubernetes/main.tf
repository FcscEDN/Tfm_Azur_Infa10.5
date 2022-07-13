# Configure the Microsoft Azure Provider

terraform {

  backend "azurerm" {

    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"

    # access_key = Do not put the secret in the repo! Use the ARM_ACCESS_KEY environment variable instead!
  }
}

provider "azurerm" {

  version = "~>1.30.1"
  # Use environment variables for secrets and GUIDs

}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "test" {
  name     = "${var.PREFIX}-aks-rg"
  location = "${var.LOCATION}"
}

resource "azurerm_policy_assignment" "test" {
  name                 = "location-policy-assignment"
  scope                = "${azurerm_resource_group.test.id}"
  policy_definition_id = "${azurerm_policy_definition.test.id}"
  description          = "Policy Assignment created via an Acceptance Test"
  display_name         = "Location Policy Assignment"
  # depends_on           = [azurerm_resource_group.test]

  parameters = <<PARAMETERS
  {
    "allowedLocations": {
      "value": [ "${var.LOCATION}" ]
    }
  }
PARAMETERS
}



resource "azurerm_virtual_network" "test" {
  name                = "${var.PREFIX}-network"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  address_space       = ["${var.vnetIPCIDR}"]
}

resource "azurerm_subnet" "test" {
  name                 = "internal"
  resource_group_name  = "${azurerm_resource_group.test.name}"
  address_prefix       = "${var.subnetIPCIDR}"
  virtual_network_name = "${azurerm_virtual_network.test.name}"

}


resource "azurerm_kubernetes_cluster" "test" {
  name                = "${var.PREFIX}-aks"
  location            = "${azurerm_resource_group.test.location}"
  dns_prefix          = "${var.PREFIX}-aks"
  resource_group_name = "${azurerm_resource_group.test.name}"
  kubernetes_version = "${var.k8sVer}"

  linux_profile {
    admin_username = "${var.osAdminUser}"

    ssh_key {
      key_data = "${var.ADMIN_SSH}"
    }
  }

  agent_pool_profile {
    name            = "agentpool"
    count           = "${var.nodeCount}"
    vm_size         = "${var.nodeSize}"
    os_type         = "Linux"
    os_disk_size_gb = 30


    vnet_subnet_id = "${azurerm_subnet.test.id}"
  }

  service_principal {
    client_id     = '${{secrets.AZURE_AD_CLIENT_ID}}'    
    client_secret = '${{secrets.AZURE_AD_CLIENT_SECRET}}'
  }

  role_based_access_control {
    enabled = true
  }

  network_profile {
    network_plugin = "${var.netPlugin}"
    service_cidr = "${var.svc-cidr}"
    dns_service_ip = "${var.dns-ip}"
    docker_bridge_cidr = "${var.dockerbridge-cidr}"

  }
}