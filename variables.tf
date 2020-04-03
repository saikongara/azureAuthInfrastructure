// Application Related Information
variable "ownerinfo" {
  description = "The service primcipal role assignment name"
}
variable "deployment_type" {
  description = "The service primcipal role assignment name"
}
variable "notification_dist_list" {
  description = "The service primcipal role assignment name"
}
variable "environment" {
  description = "The service primcipal role assignment name"
}

// Service Principle Object Id
//variable "sp_object_id" {
//  description = "Service Principal Object ID in Non prod Azure subscription"
//}
variable "read_access_object_id" {
  description = "Netezza Read Only Object ID for Read and Data access in Non prod Azure subscription"
}
variable "netezza_all_BlobDataOwner_object_id" {
  description = "Netezza All Object ID for Blob Data Owner access in Non prod Azure subscription"
}


// Resource Groups
variable "persistent_rg" {
  description = "Resource group to house resources deployed using terraform scripts"
}

// Storage : HDFS
variable "HDFS_storage_name" {
  description = "The name of the HDFS storage account."
}
variable "landingzone_storage_name" {
  description = "The environment tag of the storage account."
}

# Role Definition
variable "BlobDataContributor_role_definition_name" {
  description = "The service principal role assignment name"
}
variable "readaccess_role_definition_name" {
  description = "The read access role assignment name"
}
variable "persistent_managed_identity_name" {
  description = "The persistent Managed Identity name"
}
variable "BlobDataOwner_role_definition_name" {
  description = "The service principal role assignment name"
}

// Monitoring
variable "action_group" {
  description = "The service principal role assignment name"
}
variable "admin_email" {
  description = "The service principal role assignment name"
}
variable "devops_email" {
  description = "The service principal role assignment name"
}
variable "oncall_msg" {
  description = "The service principal role assignment name"
}