provider "azurerm" {
  subscription_id = "${var.AZURE_SUBSCRIPTIONS_ID}"
  client_id       = "${var.AZURE_AD_CLIENT_ID}"
  client_secret   = "${var.AZURE_CLIENT_SECRET}"
  tenant_id       = "${var.AZURE_AD_TENANT_ID}"
  
  #version         = "=2.0.0" #Can be overide as you wish
  features {}
}

#terraform {
 # required_providers {
 #   azurerm = {
 #     source  = "hashicorp/azurerm"
 #     version = "2.39.0"
 #   }
 # }
#}
terraform {
  #required_version = "0.13.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.39.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "1.6.0"
    }
  }
}
