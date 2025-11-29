# ============================================
# Device Path
# ============================================
DEVICE_PATH := device/xiaomi/stone

# ============================================
# Build Flags
# ============================================
#BUILD_BROKEN_DUP_RULES := true
#BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
#BUILD_BROKEN_MISSING_REQUIRED_MODULES := true

# ============================================
# Architecture
# ============================================

# Architecture
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

BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_DTB_OFFSET := 0x01f00000


# Prebuilt Kernel
BOARD_KERNEL_IMAGE_NAME := Image
#TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel
TARGET_NO_KERNEL_OVERRIDE := true

# DTB Configuration
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)


# Boot.img Arguments
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)

BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)

BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)

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



# Vendor Boot Cmdline
BOARD_USES_GENERIC_KERNEL_IMAGE := true
# Boot Config
BOARD_BOOTCONFIG += androidboot.usbcontroller=4e00000.dwc3
BOARD_BOOTCONFIG += androidboot.load_modules_parallel=true

# ============================================
# Recovery - Vendor Boot (CRITICAL SECTION)
# ============================================
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true


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
BOARD_SUPER_PARTITION_SIZE :=  8531214336
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

TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor



BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist

# ============================================
# Recovery Configuration
# ============================================
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
TARGET_RECOVERY_WIPE := $(DEVICE_PATH)/recovery.wipe

TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file

TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_INIT_VENDOR_LIB := //device/xiaomi/stone/init:libinit_stone
TARGET_RECOVERY_DEVICE_MODULES += libinit_stone

BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4


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
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_USE_FSCRYPT_POLICY := 2
			     
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
TW_HAS_EDL_MODE := false
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_FRAMERATE := 120
TW_LOAD_VENDOR_MODULES := "adsp_loader_dlkm.ko"
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone28/temp"
TW_BATTERY_SYSFS_WAIT_SECONDS := 5
TW_BACKUP_EXCLUSIONS := /data/fonts

# StatusBar
TW_STATUS_ICONS_ALIGN := center
TW_CUSTOM_CPU_POS := "250"
TW_CUSTOM_CLOCK_POS := "50"
TW_CUSTOM_BATTERY_POS := "790"

# Maintainer
TW_DEVICE_VERSION := Twrp_By_HimelPvz
OF_MAINTAINER := Himelpvz

# Ofox flags
FOX_VIRTUAL_AB_DEVICE := 1
OF_FLASHLIGHT_ENABLE := 0
OF_IGNORE_LOGICAL_MOUNT_ERRORS := 1
OF_USE_GREEN_LED := 0

# screen settings
OF_SCREEN_H := 2400
OF_STATUS_H := 100

OF_STATUS_INDENT_LEFT := 48
OF_STATUS_INDENT_RIGHT := 48
OF_HIDE_NOTCH := 1
OF_CLOCK_POS := 1

# TWRP Debug Flags
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# SHRP flags
SHRP_PATH := device/xiaomi/stone
SHRP_MAINTAINER := Himel_Pvz
SHRP_DEVICE_CODE := stone
SHRP_EDL_MODE := 0
SHRP_EXTERNAL := /external_sd
SHRP_INTERNAL := /sdcard
SHRP_OTG := /usb_otg
SHRP_FLASH := 1

SHRP_FLASH_MAX_BRIGHTNESS := 1
SHRP_REC := /dev/block/bootdevice/by-name/vendor_boot
SHRP_AB := true
SHRP_REC_TYPE := Treble
SHRP_DEVICE_TYPE := A/B
SHRP_STATUSBAR_RIGHT_PADDING := 40
SHRP_STATUSBAR_LEFT_PADDING := 40
SHRP_EXPRESS := true
SHRP_OFFICIAL := true
SHRP_DARK := true
SHRP_ALT_REBOOT := true

