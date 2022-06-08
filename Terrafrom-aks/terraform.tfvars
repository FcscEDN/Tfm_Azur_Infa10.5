resource_group_name = "infa_aks_tf_rg"
location            = "uaenorth"
cluster_name        = "infa-aks"
kubernetes_version  = "1.22.6"
system_node_count   = 1
acr_name            = "infaacr"
node_size           = "standard_DSv2"