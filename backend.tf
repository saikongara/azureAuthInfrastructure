terraform {
  backend "azurerm" {
    resource_group_name  = "state-store-rg"
    storage_account_name = "state-storage-account"
    container_name       = "state-storage-container"
    key                  = "authentication.terraform.tfstate"
  }
}

//terraform {
//  backend "local" {}
//}