data "azurerm_subscription" "primary" {}

data "azurerm_resource_group" "resources-rg-persistent" {
  name = "${var.persistent_rg}"
}

data "azurerm_storage_account" "resource-storage-persistent" {
  name                = "${var.HDFS_storage_name}"
  resource_group_name = "${data.azurerm_resource_group.resources-rg-persistent.name}"
}

data "azurerm_storage_account" "resource-blob-storage-landingzone" {
  name                = "${var.landingzone_storage_name}"
  resource_group_name = "${data.azurerm_resource_group.resources-rg-persistent.name}"
}

//data "azurerm_user_assigned_identity" "example" {
//  name                = "name_of_user_assigned_identity"
//  resource_group_name = "name_of_resource_group"
//}

//data "azuread_service_principal" "terraform_scripting" {
//  application_id = "${var.sp_id}"
//}

data "azurerm_role_definition" "resource-role-readaccess" {
  name = "${var.readaccess_role_definition_name}"
}

//data "azurerm_role_definition" "resource-blob-data-contributor" {
//  name = "${var.BlobDataContributor_role_definition_name}"
//}

data "azurerm_role_definition" "resource-blob-data-owner" {
  name = "${var.BlobDataOwner_role_definition_name}"
}

//======================================================== RESEARCH ===================================================================//
// RESEARCH : CREATING NEW ROLE DEFINITION

//resource "azurerm_role_definition" "resource-role-definition" {
//  name               = "custom-role-definition-tf"
//  scope              = "${data.azurerm_subscription.primary.id}"
//  description        = "This is a custom role created via Terraform"
//
//  permissions {
//    actions     = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
//    not_actions = []
//  }
//
//  assignable_scopes = [
//    "${data.azurerm_subscription.primary.id}",
//  ]
//}

// RESEARCH : ROLE ASSIGNMENT
//resource "azurerm_role_assignment" "resource-role-assignment" {
//  scope              = "${data.azurerm_subscription.primary.id}"
//  //  scope              = "${azurerm_storage_account.testsa.id}"
//  role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.resource-blob-data-contributor.id}"
//  //  principal_id       = "${data.azuread_service_principal.terraform_scripting.id}"
//  principal_id       = "${var.sp_object_id}"
//}
//======================================================================================================================================//

// MANAGED IDENTITY CREATION
resource "azurerm_user_assigned_identity" "resource-managed-identity-persistent" {
  resource_group_name = "${data.azurerm_resource_group.resources-rg-persistent.name}"
  location            = "${data.azurerm_resource_group.resources-rg-persistent.location}"
  name                = "${var.persistent_managed_identity_name}"
}

// ROLE ASSIGNMENT

//resource "azurerm_role_assignment" "resource-role-assignment-read-access" {
////  scope              = "${data.azurerm_subscription.primary.id}"
//  scope              = "${data.azurerm_storage_account.resource-storage-persistent.id}"
//  role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.resource-role-readaccess.id}"
//  principal_id       = "${var.read_access_object_id}"
////  principal_id       = "${var.sp_object_id}"
//}

resource "azurerm_role_assignment" "resource-role-assignment-blob-data-owner" {
  //  scope              = "${data.azurerm_subscription.primary.id}"
//  scope              = "${data.azurerm_storage_account.resource-storage-persistent.id}"
  scope              = "${data.azurerm_storage_account.resource-storage-persistent.id}"
  role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.resource-blob-data-owner.id}"
  principal_id       = "${var.netezza_all_BlobDataOwner_object_id}"
  //  principal_id       = "${var.sp_object_id}"
}

//resource "azurerm_role_assignment" "resource-role-assignment-contributor-access" {
//  scope              = "${data.azurerm_subscription.primary.id}"
//  role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.resource-blob-data-contributor.id}"
//  //  principal_id       = "${var.read_access_object_id}"
//  principal_id       = "${var.sp_object_id}"
//}


// Role Assignment for Managed Identity
// HDFS Storage : Managed Identity role assignment
resource "azurerm_role_assignment" "resource-hdfs-managed-Identity-role-assignment" {
  //  scope              = "${data.azurerm_subscription.primary.id}"
  scope              = "${data.azurerm_storage_account.resource-storage-persistent.id}"
//  role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.resource-blob-data-contributor.id}"
  role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.resource-blob-data-owner.id}"
  principal_id       = "${azurerm_user_assigned_identity.resource-managed-identity-persistent.principal_id}"
  //  principal_id       = "${var.sp_object_id}"
}

// Landing Zone Storage : Managed Identity role assignment
resource "azurerm_role_assignment" "resource-landingzone-managed-Identity-role-assignment" {
  scope              = "${data.azurerm_storage_account.resource-blob-storage-landingzone.id}"
  role_definition_id = "${data.azurerm_subscription.primary.id}${data.azurerm_role_definition.resource-blob-data-owner.id}"
  principal_id       = "${azurerm_user_assigned_identity.resource-managed-identity-persistent.principal_id}"
}