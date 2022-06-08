provider "azurerm" {
  subscription_id = ${{secrets.AZURE_SUBSCRIPTION_ID}}
  client_id       = ${{secrets.AZURE_CLIENT_ID}}
  client_secret   = ${{secrets.AZURE_CLIENT_SECRET}}
  tenant_id       = ${{secrets.AZURE_TENANT_ID}}
  version         = "=2.0.0" #Can be overide as you wish
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.39.0"
    }
  }
}
