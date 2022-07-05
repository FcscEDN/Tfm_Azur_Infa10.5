variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
}
variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}
variable "acr_name" {
  type        = string
  description = "ACR name"
}
variable "node_size"{
   type        = string
   description = "Node Size" 
}
variable "SUBSCRIPTION_ID"{
   type        = string
   description = "SUBSCRIPTION_IDe" 
}
variable "SP_CLIENT_ID"{
   type        = string
   description = "SP_CLIENT_ID" 
}
variable "SP_CLIENT_SECRET"{
   type        = string
   description = "SP_CLIENT_SECRET" 
}
variable "SP_TENANT_ID"{
   type        = string
   description = "SP_TENANT_ID" 
}
