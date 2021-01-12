provider "azurerm" {
  features {}
}

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "0.0.8"

  # Mandatory Variables
  root_parent_id = var.tenant_id

  # Optional Variables
  root_id                   = local.root_id      // Define a custom ID to use for the root Management Group. Also used as a prefix for all core Management Group IDs.
  root_name                 = local.root_name    // Define a custom "friendly name" for the root Management Group
  deploy_core_landing_zones = true               // Control whether to deploy the default core landing zones // default = true
  deploy_demo_landing_zones = false              // Control whether to deploy the demo landing zones (default = false)
  library_path              = "${path.root}/lib" // Set a path for the custom archetype library path
  default_location          = local.default_location

  archetype_config_overrides = {
    root = {
      archetype_id = "${local.root_id}_root"
      parameters = {
        ES-Allowed-Locations = {
          listOfAllowedLocations = local.allowed_locations
        }

        ES-Allowed-RSG-Locations = {
          listOfAllowedLocations = local.allowed_locations
        }
      }
      access_control = {}
    }
  }

  subscription_id_overrides = {
    root           = []
    decommissioned = []
    sandboxes      = []
    landing-zones  = []
    platform       = []
    connectivity   = local.connectivity_subscriptions
    management     = local.management_subscriptions
    identity       = []
  }
}