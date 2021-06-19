terraform {
  source = "${include.inputs.modules_repository}/app?ref=v0.0.1"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name     = "iac-live-${include.inputs.environment}-${include.inputs.location}"
  location = "${include.inputs.location}"
}
