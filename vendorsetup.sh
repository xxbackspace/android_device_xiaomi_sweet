#!/bin/bash

set -o pipefail

LOG_FILE="clone_$(date +%Y%m%d_%H%M%S).log"
STEP=0

GREEN="\033[1;32m"
RED="\033[1;31m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
RESET="\033[0m"

log_step() {
    STEP=$((STEP + 1))
    echo -ne "${CYAN}[$STEP]${RESET} $1 ... "
}

log_ok() {
    echo -e "${GREEN}done${RESET}"
}

log_fail() {
    echo -e "${RED}failed${RESET} (see $LOG_FILE)"
}

log_skip() {
    echo -e "${YELLOW}already exists, skipped${RESET}"
}

clone() {
    local label="$1"
    local url="$2"
    local dest="$3"
    local branch="$4"

    log_step "$label"

    if [ -d "$dest" ]; then
        log_skip
        return
    fi

    if [ -n "$branch" ]; then
        git clone -b "$branch" "$url" "$dest" >> "$LOG_FILE" 2>&1
    else
        git clone "$url" "$dest" >> "$LOG_FILE" 2>&1
    fi

    if [ $? -eq 0 ]; then
        log_ok
    else
        log_fail
    fi
}

echo -e "${CYAN}=== Starting clone process ===${RESET}"
echo "Full log: $LOG_FILE"
echo

clone "Clone common tree"        "https://github.com/xxbackspace/android_device_xiaomi_sm6150-common.git" "device/xiaomi/sm6150-common"
clone "Clone vendor common"      "https://gitlab.com/NoPrincessHere/proprietary_vendor_xiaomi_sm6150-common.git" "vendor/xiaomi/sm6150-common" "seventeen"
clone "Clone vendor sweet"       "https://gitlab.com/NoPrincessHere/proprietary_vendor_xiaomi_sweet.git" "vendor/xiaomi/sweet" "seventeen"
clone "Clone MiuiCamera sweet"   "https://gitlab.com/NoPrincessHere/proprietary_vendor_miuicamera-sweet.git" "vendor/miuicamera-sweet" "seventeen"
clone "Clone Reforge kernel"     "https://github.com/manipvlator/los_kernel_xiaomi_sm6150.git" "kernel/xiaomi/sm6150"
clone "Clone hardware xiaomi"    "https://github.com/LineageOS/android_hardware_xiaomi.git" "hardware/xiaomi"
clone "Clone sony dolby"         "https://github.com/sweet-stuffs/proprietary_vendor_sony_dolby.git" "vendor/sony/dolby" "16"
clone "Clone LunarisDolby"       "https://github.com/sweet-stuffs/android_packages_apps_LunarisDolby.git" "packages/apps/LunarisDolby"

echo
echo -e "${CYAN}=== Done ($STEP repos processed) ===${RESET}"

