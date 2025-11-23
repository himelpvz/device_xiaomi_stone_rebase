# Set necessary environment variables for TWRP build
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C

# Optional: Disable Java 8 compilation if your source needs it (less common now)
# export EXPERIMENTAL_USE_JAVA8=true

# Add your device's build targets to the lunch menu.
# The 'omni_' prefix is often used for generic TWRP builds.
# The targets are usually 'eng' (engineering) and 'userdebug'.

# Syntax: add_lunch_combo <product_name>-<build_variant>
add_lunch_combo twrp_stone-eng
add_lunch_combo twrp_stone-user
add_lunch_combo twrp_stone-userdebug

# Or, if using the older OmniROM naming convention:
# add_lunch_combo omni_<device-codename>-eng
# add_lunch_combo omni_<device-codename>-userdebug
