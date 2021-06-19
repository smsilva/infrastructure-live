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

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "azurerm" {
  tenant_id       = "a267367d-d04d-4a6b-84ef-0cc227ed6e9f"
  subscription_id = "ddc30188-075a-470d-a6ca-05a1987c51a3"
  features {}
}
EOF
}
