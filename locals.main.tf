locals {
  root_id          = "as"
  root_name        = "Awesome School"
  default_location = "westus2"

  allowed_locations = [
    "global",
    "centralus",
    "eastus",
    "eastus2",
    "northcentralus",
    "southcentralus",
    "westcentralus",
    "westus",
    "westus2"
  ]
}