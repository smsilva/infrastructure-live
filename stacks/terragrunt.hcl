remote_state {
  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  
  config = {
    resource_group_name   = "iac"
    storage_account_name  = "silvios"
    container_name        = "terraform"
    key                   = "${path_relative_to_include()}/state.json"
  }
}

locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  # region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  # environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  tenant_id = local.account_vars.locals.tenant_id
  # account_id   = local.account_vars.locals.aws_account_id
  # aws_region   = local.region_vars.locals.aws_region
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "azurerm" {
  tenant_id       = "${local.tenant_id}"
  subscription_id = "ddc30188-075a-470d-a6ca-05a1987c51a3"
  features {}
}
EOF
}

inputs = merge(
  local.account_vars.locals
)
