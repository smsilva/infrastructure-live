locals {
  subscription_id = get_env("ARM_SUBSCRIPTION_ID")
  client_id       = get_env("ARM_CLIENT_ID")
  client_secret   = get_env("ARM_CLIENT_SECRET")
  tenant_id       = get_env("ARM_TENANT_ID")
}
