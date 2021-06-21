remote_state {
  backend = "azurerm"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    resource_group_name  = "iac"
    storage_account_name = "silvios"
    container_name       = "terraform"
    key                  = "${path_relative_to_include()}/state.json"
  }
}

locals {
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  tenant_id       = local.account_vars.locals.tenant_id
  subscription_id = local.account_vars.locals.subscription_id
  client_id       = local.account_vars.locals.client_id
  client_secret   = local.account_vars.locals.client_secret

  modules_repository = "git::git@github.com:smsilva/infrastructure-modules.git/"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "azurerm" {
  tenant_id       = "${local.tenant_id}"
  subscription_id = "${local.subscription_id}"
  client_id       = "${local.client_id}"
  client_secret   = "${local.client_secret}"
  features {}
}
EOF
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
  local
)
