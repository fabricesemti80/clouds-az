
/* -------------------------------------------------------------------------- */
/*                                  Variables                                 */
/* -------------------------------------------------------------------------- */
variable "location" {
  type = string
  default = "West Europe"
  description = "Azure deployment location (region)"

}

/* -------------------------------------------------------------------------- */
/*                                    Data                                    */
/* -------------------------------------------------------------------------- */
data "azurerm_client_config" "current" {}
data "azapi_client_config" "current" {}


/* -------------------------------------------------------------------------- */
/*                                  Resources                                 */
/* -------------------------------------------------------------------------- */
resource "azurerm_resource_group" "rg1" {
  name     = "rg1"
  location = var.location
}

# locals {
#   subscription_id            = data.azapi_client_config.current.subscription_id
#   resource_group_name        = azurerm_resource_group.rg1.name
#   resource_type              = "Microsoft.OperationalInsights/workspaces"
#   resource_names             = ["my-log-analytics-workspace"]
#   log_analytics_workspace_id = provider::azapi::resource_group_resource_id(
#     local.subscription_id,
#     local.resource_group_name,
#     local.resource_type,
#     local.resource_names
#   )
# }

/* -------------------------------------------------------------------------- */
/*                                Landing Zone                                */
/* -------------------------------------------------------------------------- */

#? Permissions:
# - "Owner" on the subscription
# - "Owner" on the tenant management group
#TODO:
# 1. az rest --method post --url "/providers/Microsoft.Authorization/elevateAccess?api-version=2017-05-01" # elevate your access; then log out and log back in
# 2. Assign overner  on the root managemenet group
# # az role assignment create --assignee "6e3feaa6-d3d6-437b-b6e3-1afc733750d7" --role "Owner" --scope "/"
# 3. Assign overner  on the subscription
# # az role assignment create --assignee "6e3feaa6-d3d6-437b-b6e3-1afc733750d7" --role "Owner" --scope "/subscriptions/f45a9cdc-bf42-4cec-8394-19cf4b3dbbca"


#? Fixes
# If you need to remove the managemenet group:
# - run: az account management-group delete --name alzroot

module "alz" {

  /* --------------------------- Mandatory settings --------------------------- */
  source  = "Azure/avm-ptn-alz/azurerm"
  version = "~> 0.10"
  location = var.location
  architecture_name  = "alz"
  parent_resource_id = data.azapi_client_config.current.tenant_id


  # policy_default_values = {
  #   log_analytics_workspace_id = jsonencode({ Value = local.log_analytics_workspace_id })
  # }
}
