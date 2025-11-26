# ============================================
# Device Path
# ============================================
DEVICE_PATH := device/xiaomi/stone

# ============================================
# Architecture
# ============================================
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a75

# ============================================
# Platform / Bootloader
# ============================================
PRODUCT_PLATFORM := holi
TARGET_BOARD_PLATFORM := holi
TARGET_BOARD_PLATFORM_GPU := qcom-adreno619
QCOM_BOARD_PLATFORMS += holi

TARGET_BOOTLOADER_BOARD_NAME := $(PRODUCT_PLATFORM)
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

BOARD_VENDOR := xiaomi

# ============================================
# Kernel
# ============================================
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

BOARD_BOOT_HEADER_VERSION := 3
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_DTB_OFFSET := 0x01f00000
#RAMDISK_SIZE := 22400240
#BOARD_MKBOOTIMG_ARGS += --vendor_ramdisk_size $(RAMDISK_SIZE)

# Prebuilt Kernel
BOARD_KERNEL_IMAGE_NAME := Image
#TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_NO_KERNEL_OVERRIDE := true

# DTB Configuration
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb.img
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
# DTBO
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbs/dtbo.img

# Boot.img Arguments
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)

# Boot Cmdline
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += androidboot.memcg=1
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += service_locator.enable=1
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=4e00000.dwc3
BOARD_KERNEL_CMDLINE += swiotlb=0
BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_CMDLINE += cgroup.memory=nokmem,nosocket
BOARD_KERNEL_CMDLINE += iptable_raw.raw_before_defrag=1
BOARD_KERNEL_CMDLINE += ip6table_raw.raw_before_defrag=1
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/firmware

# Vendor Boot Cmdline
BOARD_VENDOR_CMDLINE := androidboot.init_fatal_reboot_target=recovery
BOARD_VENDOR_CMDLINE += androidboot.selinux=permissive

# Boot Config
BOARD_BOOTCONFIG += androidboot.usbcontroller=4e00000.dwc3
BOARD_BOOTCONFIG += androidboot.load_modules_parallel=true

# ============================================
# Recovery - Vendor Boot (CRITICAL SECTION)
# ============================================
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
#BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true

# Vendor ramdisk fragments
#BOARD_VENDOR_RAMDISK_FRAGMENTS := dlkm
#BOARD_VENDOR_RAMDISK_FRAGMENT.dlkm.KERNEL_MODULE_DIRS := top

# ============================================
# A/B & Dynamic Partitions
# ============================================
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot

BOARD_USES_DYNAMIC_PARTITIONS := true
BOARD_SUPER_PARTITION_SIZE := 8531214336
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm odm
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 8527020032

# ============================================
# Partitions & File Systems
# ============================================
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_COPY_OUT_VENDOR := vendor

BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist

# ============================================
# Recovery Configuration
# ============================================
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery.fstab
TARGET_RECOVERY_WIPE := $(DEVICE_PATH)/recovery.wipe

TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file

TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# ============================================
# Crypto / Security
# ============================================
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true

PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2127-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# ============================================
# Build Flags
# ============================================
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
ALLOW_MISSING_DEPENDENCIES := true

BOARD_AVB_ENABLE := true
BOARD_RAMDISK_USE_LZ4 := true

TW_EXCLUDE_APEX := true
TARGET_USES_MKE2FS := true
TARGET_USES_LOGD := true

LC_ALL := C

# ============================================
# TWRP Configuration
# ============================================

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2

# UI & Theme
TW_THEME := portrait_hdpi
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 200
TW_FRAMERATE := 120
TW_CUSTOM_CLOCK_POS := 60

# Features
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_NO_SCREEN_BLANK := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_NO_CPU_TEMP := true
TW_BATTERY_SYSFS_WAIT_SECONDS := 3
TW_BACKUP_EXCLUSIONS := /data/fonts
TW_INCLUDE_FASTBOOTD := true

# Modules
TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko"
TW_LOAD_VENDOR_BOOT_MODULES := true

# Debug
TWRP_INCLUDE_LOGCAT := true

# Version
TW_DEVICE_VERSION := HpsTWRP
