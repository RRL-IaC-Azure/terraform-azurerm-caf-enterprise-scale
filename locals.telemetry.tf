# Telemetry is collected by creating an empty ARM deployment with a specific name
# If you want to disable telemetry, you can set the disable_telemetry variable to true

# The following locals identify the module
locals {
  # PUID identifies the module
  telam_connectivity_puid = "97603aac-98f8-4a55-92fc-4c78378c9ba5"
  telem_core_puid         = "36dcde81-8c33-4da0-8dc3-265381502ccb"
  telem_identity_puid     = "67becfb7-b296-43a9-ba38-0b5c19cb065a"
  telem_management_puid   = "6fffb9f9-2691-412a-837e-3f72dcfe70cb"
}

# Here we create the ARM templates for the telemetry deployment
# One for MG and one for subscription, used as a fallback if we can't find the root_id MG
locals {
  telem_arm_subscription_template_content = <<TEMPLATE
{
  "$schema": "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "variables": {},
  "resources": [],
  "outputs": {
    "telemetry": {
      "type": "string",
      "value": "For more information, see https://aka.ms/alz/tf/telemetry"
    },
  }
}
TEMPLATE
}
