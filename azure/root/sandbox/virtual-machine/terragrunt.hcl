terraform {
  source = "${include.inputs.modules_repository}/azure/virtual-machine?ref=master"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  prefix   = "${include.inputs.environment}"
  location = "${include.inputs.location}"
}
