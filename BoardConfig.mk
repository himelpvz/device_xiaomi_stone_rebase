#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/stone

# =========================
# Build system flags
# =========================

BUILD_BROKEN_DUP_RULES := true
# Allow duplicate build rules (e.g. in PRODUCT_COPY_FILES) instead of failing with
# "overriding commands for target".

BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
# Allow using prebuilt ELF binaries in PRODUCT_COPY_FILES (normally forbidden;
# AOSP prefers declaring them as proper modules).

BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
# Do not fail the build if modules listed in LOCAL_REQUIRED_MODULES (etc.) are missing;
# only warn and continue.

ALLOW_MISSING_DEPENDENCIES := true
# Similar to BUILD_BROKEN_MISSING_REQUIRED_MODULES: allow missing dependencies
# and continue the build (useful when some vendor modules are not present).

BUILD_BROKEN_USES_NETWORK := true
# Allow network usage in some build steps that would otherwise be blocked.

# =========================
# Architecture & platform
# =========================


# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# Device is fully 64-bit and supports 64-bit apps.


PRODUCT_PLATFORM := holi
TARGET_BOARD_PLATFORM := xiaomi_sm6375
TARGET_BOARD_PLATFORM_GPU := qcom-adreno619
QCOM_BOARD_PLATFORMS += xiaomi_sm6375
# Platform / SoC codename (Pixel 8 = holi); TARGET_BOARD_PLATFORM comes from
# GOOGLE_BOARD_PLATFORMS, which includes holi.

TARGET_BOOTLOADER_BOARD_NAME := $(PRODUCT_PLATFORM)
# Board name used in android-info.txt / OTA compatibility checks.

TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
# board-info.txt used to check device compatibility for OTAs/fastboot.

TARGET_NO_BOOTLOADER := true
# Do not build a separate bootloader image as part of this target.

TARGET_USES_UEFI := true
# Device boots via UEFI instead of legacy ARM boot flow.

# =========================
# A/B (seamless) OTA
# =========================

AB_OTA_UPDATER := true
# Enable A/B (seamless) OTA support.
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    vendor \
    system_ext \
    system \
    odm \
    product \
    vendor_boot \
    
BOARD_USE_DYNAMIC_PARTITIONS  := true
BOARD_RECOVERY_SNAPSHOT := false
# Dynamic partitions enabled; recovery snapshot feature disabled (used by some forks
# like OrangeFox, here turned off).

BOARD_SUPER_PARTITION_SIZE := 8531214336
BOARD_SUPER_PARTITION_GROUPS := XIAOMI_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm product
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 8527020032
# super partition layout: size, group name and list of logical partitions inside.

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
# Kernel architecture and header architecture (usually the same).

# TARGET_KERNEL_CLANG_COMPILE   := true
# Build kernel with Clang toolchain (required by modern Android kernels).

BOARD_BOOTIMG_HEADER_VERSION := 3
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.memcg=1 lpm_levels.sleep_disabled=1 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=4e00000.dwc3 swiotlb=0 loop.max_part=7 cgroup.memory=nokmem,nosocket iptable_raw.raw_before_defrag=1 ip6table_raw.raw_before_defrag=1 firmware_class.path=/vendor/firmware
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_KERNEL_CONFIG := stone_defconfig
TARGET_KERNEL_SOURCE := kernel/xiaomi/stone

# mkbootimg parameters: page size, header version, base and offsets for kernel,
# ramdisk and tags; plus vendor cmdline. Must match the device bootloader.

# BOARD_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image
# TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image

BOARD_KERNEL_IMAGE_NAME := Image
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt/dtbs
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbs/dtbo.img
# TARGET_NO_KERNEL_OVERRIDE := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
# BOARD_DTB_OFFSET         := 0x01f00000
# Optional prebuilt kernel/DTB/DTBO settings and DTB offset if needed.

# =========================
# Filesystems & images
# =========================

TARGET_USERIMAGES_USE_EXT4 := true
# Generate ext4 filesystem images for partitions (system/vendor etc.).

TARGET_USERIMAGES_USE_F2FS := true
# Enable building F2FS images; which partitions use F2FS is defined below.

TARGET_COPY_OUT_VENDOR := vendor
# Build a separate vendor.img instead of embedding vendor into system.

BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
# Filesystem type per partition; boot and vendor_boot partition sizes.

BOARD_FLASH_BLOCK_SIZE := 131072
# Flash block size (bytes), used when creating images.

# =========================
# Recovery
# =========================

TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
# Pixel format for recovery framebuffer.
# TARGET_RECOVERY_PIXEL_FORMAT := RGB_565         # did not boot
# TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888       # works, but UI tinted blue
# TARGET_RECOVERY_PIXEL_FORMAT := ARGB_8888       # unusable, black screen
# TARGET_RECOVERY_PIXEL_FORMAT := RGBA_8888       # unusable, black screen
# TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888       # unusable, strong green tint
# TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"     # unusable, strong orange tint

TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
# Path to recovery fstab describing partitions and mount points.

TARGET_RECOVERY_WIPE := $(DEVICE_PATH)/recovery.wipe
# List of partitions to wipe for factory reset (TWRP/OrangeFox specific).


BOARD_VINTF_CHECK := false
# Disable VINTF manifest compatibility check for this recovery build.



# =========================
# Misc parameters
# =========================

VENDOR_CMDLINE := "androidboot.hardware=qcom \
                   androidboot.memcg=1 \
		           androidboot.selinux=permissive \
                   androidboot.usbcontroller=4e00000.dwc3 \
                   cgroup.memory=nokmem,nosocket \
                   loop.max_part=7 \
                   msm_rtb.filter=0x237 \
                   service_locator.enable=1 \
                   swiotlb=0 \
                   pcie_ports=compat \
                   iptable_raw.raw_before_defrag=1 \
                   ip6table_raw.raw_before_defrag=1 \
                   androidboot.init_fatal_reboot_target=recovery"
                   
BOARD_BOOTCONFIG += androidboot.usbcontroller=11210000.dwc3
BOARD_BOOTCONFIG += androidboot.boot_devices=13200000.ufs
BOARD_BOOTCONFIG += androidboot.load_modules_parallel=true
# Extra kernel cmdline / bootconfig arguments (debug, memory, USB controller,
# boot device, etc.).

# BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
# Do not include the kernel inside recovery.img (for devices where recovery
# is not a separate image).

BOARD_HAS_LARGE_FILESYSTEM := true
# Enable handling of large filesystems in recovery tools.

SELINUX_IGNORE_NEVERALLOWS := true
# Ignore SELinux neverallow rules at build time (recovery build only).

BOARD_RAMDISK_USE_LZ4 := true
# Compress recovery ramdisk with LZ4.

TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
# Custom LUN path for USB mass storage mode.

TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2000
# Screen resolution used by recovery UI.

BOARD_VENDOR := xiaomi
# Vendor name.

XIAOMI_BOARD_PLATFORMS += holi
# Add "holi" to the list of supported Google platforms.

TARGET_NO_RECOVERY := true
# No separate recovery partition; recovery is in vendor_boot/init_boot.

LC_ALL := C
# Force C (POSIX) locale for build scripts.

BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist
# Extra folders to create/keep in / (root) during build/flash.

BOARD_SUPPRESS_SECURE_ERASE := true
# Disable secure erase for partitions that would otherwise attempt it.


# Custom TWRP/OrangeFox version string.


TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
# Include system.prop for recovery (extra / overridden system properties).

BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
# Place recovery resources and ramdisk inside vendor_boot instead of boot.

# BOARD_USES_GENERIC_KERNEL_IMAGE := true
# Use Generic Kernel Image (GKI) instead of a device-specific kernel.

BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
# Move GSI AVB keys into vendor_boot when using AVB with GSI.


BOARD_AVB_ENABLE := true
# Enable AVB (Android Verified Boot v2) support.
# Ensures recovery is built to properly handle AVB: verification, key loading,
# and interaction with bootloader AVB flows.

TW_EXCLUDE_APEX := true
# Disable APEX module support.
# APEX is not needed in recovery; excluding it reduces size and simplifies the environment.

ENABLE_SCHEDBOOST := true
# Enable scheduler boost to give higher priority to recovery processes.
# Helps improve TWRP responsiveness during heavy operations (flashing, wiping, etc.).

TARGET_USES_MKE2FS := true
# Use mke2fs instead of make_ext4fs when creating ext4 filesystems.
# mke2fs is newer, more flexible, and recommended for modern devices.


# BOARD_INCLUDE_DTB_IN_BOOTIMG := true
# Include the DTB (device tree blob) directly inside boot.img.
# Required on devices whose bootloader expects kernel + DTB together.

BOARD_DTBOIMG_PARTITION_SIZE := 25165824
# Size of the DTBO partition in bytes (4 MiB).
# Must match the device's actual DTBO partition size.

# ENABLE_CPUSETS := true
# Enable cpusets: CPU core allocation control for processes.
# Can improve performance on big.LITTLE or multi-cluster SoCs.


# Crypto
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2
TW_VERSION := HpsTWRP
			     
# TWRP specific build flags
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 200
TW_NO_SCREEN_BLANK := true
TW_EXCLUDE_APEX := true
TW_HAS_EDL_MODE := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_FRAMERATE := 120
TW_ROUND_SCREEN := true
TW_CUSTOM_CLOCK_POS := 60
TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko"
# TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone28/temp"
TW_NO_CPU_TEMP := true
TW_BATTERY_SYSFS_WAIT_SECONDS := 3
TW_BACKUP_EXCLUSIONS := /data/fonts
TW_INCLUDE_FASTBOOTD := true

# TWRP Debug Flags
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

SHRP_DEVICE_CODE := stone 
SHRP_PATH := device/xiaomi/stone
SHRP_MAINTAINER := Himel_pvz
SHRP_REC_TYPE := SAR
SHRP_DEVICE_TYPE := A/B
SHRP_REC := /dev/block/bootdevice/by-name/vendor_boot
SHRP_HAS_RECOVERY_PARTITION := false
SHRP_AB := true
SHRP_EDL_MODE := 1

#Mount points

SHRP_INTERNAL := /sdcard
SHRP_EXTERNAL := /external_sd
SHRP_OTG := /usb_otg
SHRP_FLASH := 1

#SHRP Theming

SHRP_NOTCH := true
# SHRP_DARK := false

#Custom led paths for flashlight (Yes, idk which one actually works so i put all of them)

SHRP_CUSTOM_FLASHLIGHT := true
SHRP_FONP_1 := /sys/class/devices/virtual/camera/flashlight/rear_flash


SHRP_FLASH_MAX_BRIGHTNESS := 1

SHRP_NO_SAR_AUTOMOUNT := true

