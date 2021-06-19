terraform {
  source = "${include.inputs.modules_repository}/app?ref=v0.0.2"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name     = "iac-live-${include.inputs.environment}"
  location = "${include.inputs.location}"
  tag_description = "This is the new description for the Resource Group Tag"
  tag_environment = "${include.inputs.environment}"
}
