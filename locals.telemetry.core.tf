# Telemetry is collected by creating an empty ARM deployment with a specific name
# If you want to disable telemetry, you can set the disable_telemetry variable to true

# This file contains telemetry for the core module

# The following locals are used to create the bitfield data, dependent on the module configuration
locals {
  # Bitfield bit 1 (LSB): Is deploy core LZs enabled?
  telem_core_deploy_core_landing_zones = var.deploy_core_landing_zones ? 1 : 0

  # Bitfield bit 2: Is deploy corp LZ set?
  telem_core_deploy_corp_landing_zones = var.deploy_corp_landing_zones ? 2 : 0

  # Bitfield bit 3: Is deploy online LZ set?
  telem_core_deploy_online_landing_zones = var.deploy_online_landing_zones ? 4 : 0

  # Bitfield bit 4: Is deploy SAP LZ set?
  telem_core_deploy_sap_landing_zones = var.deploy_online_landing_zones ? 8 : 0

  # Bitfield bit 5: Are there any custom LZs configured?
  telem_core_custom_lzs_configured = length(var.custom_landing_zones) > 0 ? 16 : 0
}

# The following locals calculate the telemetry bitfield by summiung thhe above locals and then representing as hexadecimal
locals {
  telem_core_bitfield_denery = (
    local.telem_core_deploy_core_landing_zones +
    local.telem_core_deploy_corp_landing_zones +
    local.telem_core_deploy_online_landing_zones +
    local.telem_core_deploy_sap_landing_zones +
    local.telem_core_custom_lzs_configured
  )
  telem_core_bitfield_hex = format("%x", local.telem_core_bitfield_denery)
}

# This construicts the ARM deployment name that is used for the telemetry.
# We shouldn't ever hit the 64 character limit but use substr just in case
locals {
  telem_core_arm_deployment_name = substr(
    format(
      "puid-%s-%s-%s-%s",
      local.telem_core_puid,
      local.module_version,
      local.telem_core_bitfield_hex,
      random_id.telem[0].hex
    ),
    0,
    64
  )
}

# Condition to determine whether we create the core telemetry deployment
locals {
  telem_core_deployment_enabled = !var.disable_telemetry
}
