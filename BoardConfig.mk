

# ============================================
# Device properties (hardware, kernel, storage)
# ============================================

DEVICE_PATH := device/xiaomi/stone

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

# Platform / SoC
PRODUCT_PLATFORM := holi
TARGET_BOARD_PLATFORM := holi
TARGET_BOARD_PLATFORM_GPU := qcom-adreno619
QCOM_BOARD_PLATFORMS += xiaomi_sm6375
XIAOMI_BOARD_PLATFORMS += holi

TARGET_BOOTLOADER_BOARD_NAME := $(PRODUCT_PLATFORM)
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true
# = *************** test only

BOARD_VENDOR := xiaomi

# A/B (seamless) OTA / dynamic partitions
AB_OTA_UPDATER := true
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

BOARD_SUPER_PARTITION_SIZE := 8531214336
BOARD_SUPER_PARTITION_GROUPS := XIAOMI_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm product
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 8527020032

# Filesystems & images
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_COPY_OUT_VENDOR := vendor

BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
#BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
#BOARD_DTBOIMG_PARTITION_SIZE := 25165824
#BOARD_FLASH_BLOCK_SIZE := 131072

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist

# Kernel / boot image
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
#TARGET_KERNEL_CLANG_COMPILE   := true

BOARD_BOOT_HEADER_VERSION := 3
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.memcg=1 lpm_levels.sleep_disabled=1 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=4e00000.dwc3 swiotlb=0 loop.max_part=7 cgroup.memory=nokmem,nosocket iptable_raw.raw_before_defrag=1 ip6table_raw.raw_before_defrag=1 firmware_class.path=/vendor/firmware
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_VENDOR_RAMDISK_RECOVERY := true
#TARGET_KERNEL_CONFIG := stone_defconfig
#TARGET_KERNEL_SOURCE := kernel/xiaomi/stone

#BOARD_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image
#TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image

BOARD_KERNEL_IMAGE_NAME := Image
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt
TARGET_NO_KERNEL_OVERRIDE := true

BOARD_DTB_OFFSET         := 0x01f00000

# Recovery image layout
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
# TARGET_RECOVERY_PIXEL_FORMAT := RGB_565
# TARGET_RECOVERY_PIXEL_FORMAT := ABGR_8888
# TARGET_RECOVERY_PIXEL_FORMAT := ARGB_8888
# TARGET_RECOVERY_PIXEL_FORMAT := RGBA_8888
# TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
# TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"

TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
TARGET_RECOVERY_WIPE := $(DEVICE_PATH)/recovery.wipe
#BOARD_VINTF_CHECK := false

VENDOR_CMDLINE := "androidboot.hardware=qcom androidboot.memcg=1 lpm_levels.sleep_disabled=1 msm_rtb.filter=0x237 service_locator.enable=1 androidboot.usbcontroller=4e00000.dwc3 swiotlb=0 loop.max_part=7 cgroup.memory=nokmem,nosocket iptable_raw.raw_before_defrag=1 ip6table_raw.raw_before_defrag=1 firmware_class.path=/vendor/firmware"

BOARD_BOOTCONFIG += androidboot.usbcontroller=11210000.dwc3
BOARD_BOOTCONFIG += androidboot.boot_devices=13200000.ufs
BOARD_BOOTCONFIG += androidboot.load_modules_parallel=true

TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TARGET_SCREEN_WIDTH := 1080
TARGET_SCREEN_HEIGHT := 2000

TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

########### RECOVERY VENDOR BOOT ##################
BOARD_VENDOR_RAMDISK_RECOVERY := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
#BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
BOARD_USES_RECOVERY_AS_BOOT := true
#################################################
#BOARD_USES_GENERIC_KERNEL_IMAGE := true


# Crypto / security
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# ============================================
# General build flags
# ============================================

# Core build-system toggles
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
ALLOW_MISSING_DEPENDENCIES := true
#BUILD_BROKEN_USES_NETWORK := true

BOARD_AVB_ENABLE := true
BOARD_RAMDISK_USE_LZ4 := true
SELINUX_IGNORE_NEVERALLOWS := true

TW_EXCLUDE_APEX := true
ENABLE_SCHEDBOOST := true
TARGET_USES_MKE2FS := true

LC_ALL := C

#BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
#ENABLE_CPUSETS := true

# Logging
TARGET_USES_LOGD := true

# ============================================
# TWRP flags
# ============================================

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2
TW_VERSION := HpsTWRP

# TWRP UI / behaviour
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
#TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone28/temp"
TW_NO_CPU_TEMP := true
TW_BATTERY_SYSFS_WAIT_SECONDS := 3
TW_BACKUP_EXCLUSIONS := /data/fonts
TW_INCLUDE_FASTBOOTD := true

# Debug
TWRP_INCLUDE_LOGCAT := true

# ============================================
# SHRP flags
# ============================================

SHRP_DEVICE_CODE := stone 
SHRP_PATH := device/xiaomi/stone
SHRP_MAINTAINER := Himel_pvz
SHRP_REC_TYPE := treble
SHRP_DEVICE_TYPE := A/B
SHRP_REC := /dev/block/bootdevice/by-name/vendor_boot
SHRP_HAS_RECOVERY_PARTITION := false
SHRP_AB := true
SHRP_EDL_MODE := 1

# Mount points
SHRP_INTERNAL := /sdcard
SHRP_EXTERNAL := /external_sd
SHRP_OTG := /usb_otg
SHRP_FLASH := 1

# Theming
SHRP_NOTCH := true
#SHRP_DARK := false

# Custom led paths for flashlight
SHRP_CUSTOM_FLASHLIGHT := true

SHRP_FLASH_MAX_BRIGHTNESS := 1

SHRP_NO_SAR_AUTOMOUNT := true
