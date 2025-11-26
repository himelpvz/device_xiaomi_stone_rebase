#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += build.variant.self=$(BUILD_VATIANT_SELF)

DEVICE_PATH := device/xiaomi/stone

PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# decryption

PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe
    
# Recovery init scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.usb.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.usb.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.qcom.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.qcom.rc



# Needed for VNDK + VINTF compatibility in recovery.

PRODUCT_USE_DYNAMIC_PARTITIONS := true
# Essential: stone (sunstone/moonstone) uses dynamic partitions and A/B system.

# -------- First stage init dependencies -------- #
PRODUCT_PACKAGES += linker.vendor_ramdisk
PRODUCT_PACKAGES += linker_hwasan64.vendor_ramdisk
PRODUCT_PACKAGES += resize2fs.vendor_ramdisk
PRODUCT_PACKAGES += resize.f2fs.vendor_ramdisk
PRODUCT_PACKAGES += dump.f2fs.vendor_ramdisk
PRODUCT_PACKAGES += defrag.f2fs.vendor_ramdisk
PRODUCT_PACKAGES += fsck.vendor_ramdisk
PRODUCT_PACKAGES += tune2fs.vendor_ramdisk
PRODUCT_PACKAGES += fstab.holi.vendor_ramdisk
PRODUCT_PACKAGES += fstab.holi-fips.vendor_ramdisk
PRODUCT_PACKAGES += e2fsck.vendor_ramdisk
# Essential: stone uses Holi platform (Snapdragon 695/4Gen1). Keep holi fstab + fs tools.

PRODUCT_PACKAGES += \
    bootctrl.stone.recovery \
    android.hardware.boot@1.1-impl-qti.recovery
    

PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier
# Essential: Needed for OTA sideload + A/B flashing in TWRP.

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Essential: Needed for switching A/B slots on Qualcomm devices.

TWRP_REQUIRED_MODULES += \
	miui_prebuilt
	

PRODUCT_PACKAGES += fastbootd
# Essential: stone supports fastbootd for flashing dynamic partitions from recovery.

PRODUCT_PACKAGES += libsysutils

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

TARGET_RECOVERY_DEVICE_MODULES += \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0 \
    libdisplayconfig.qti
# Essential: stone uses QTI display HAL; required for proper framebuffer init in recovery.

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

BOARD_USES_METADATA_PARTITION := true
# Essential: metadata partition is required for FBE and dynamic partition metadata.

PRODUCT_PACKAGES += libtrusty
# Needed for Qualcomm Trusty TEE (crypto, keystore, FBE).

PRODUCT_PACKAGES += vndservicemanager
PRODUCT_PACKAGES += vndservice
PRODUCT_PACKAGES += libhidltransport.vendor
# Essential: stone vendor still uses HIDL/QTI services.

DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/system/etc/vinit/manifest.xml
PRODUCT_ENFORCE_VINTF_MANIFEST := true
# Essential: VINTF check must match stone vendor manifest.

PRODUCT_PACKAGES += bootctl

PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/commonsys-intf/display
    
# Needed for A/B slot management from recovery.

PRODUCT_PACKAGES += logcat
PRODUCT_PACKAGES += logd
PRODUCT_PACKAGES += auditctl
PRODUCT_PACKAGES += libcap
# Useful/required for debugging and SELinux tools in recovery.

ENABLE_VIRTUAL_AB := true
# Essential: stone uses virtual A/B OTA.

# --- TWRP Features ---
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
# Provides haptic support via AIDL for Qualcomm devices.
