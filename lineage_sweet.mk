#
# Copyright (C) 2021-2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
TARGET_SUPPORTS_OMX_SERVICE := false
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from sweet device
$(call inherit-product, device/xiaomi/sweet/device.mk)

# Inherit some common LineageOS stuff.
TARGET_DISABLE_EPPE := true
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

TARGET_SCREEN_WIDTH := 1080
TARGET_SUPPORTS_QUICK_TAP := false

PRODUCT_NAME := lineage_sweet
PRODUCT_DEVICE := sweet
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Redmi Note 10 Pro
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="sweet_global-user 13 TKQ1.221013.002 V14.0.9.0.TKFMIXM release-keys" \
    BuildFingerprint=Redmi/sweet_global/sweet:13/TKQ1.221013.002/V14.0.9.0.TKFMIXM:user/release-keys

# Lunaris build flags
WITH_GMS := true # -> Gapps Builds, if you want use vanilla, use " WITH_GMS := false "
WITH_PIXEL_LAUNCHER := false # -> Drop Pixel launcher, Using Lunaris launcher
TARGET_USE_GPHOTOS := false # -> Disable Google Photo Instead AOSP Gallery
TARGET_ENABLE_BLUR := true # -> Enable Blur QS etc...
TARGET_DISABLE_MATLOG := true # -> Disable Material Logcat
TARGET_BOOT_ANIMATION_RES := 1080 # -> Sweet using 1080
SURFACE_FLINGER_BOOST := true # -> Surface flinger boosting (Smoother scrolling, fewer frame drops but Keeps CPU slightly “awake”)
USE_REALITY_ENGINE := true # -> Display X reality engine
USE_ADVANCED_DISPLAY_COLOR := true # -> Advance color
WITH_GMS_COMMS_SUITE := false # -> Use AOSP Telephony
