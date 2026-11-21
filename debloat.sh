#!/usr/bin/env bash
# ==============================================================================
# Xiaomi & HyperOS Interactive Debloat & Backup Tool
# ==============================================================================

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

# Ensure ADB is available
if ! command -v adb >/dev/null 2>&1; then
    echo "[-] Error: 'adb' not found. Install it with: brew install --cask android-platform-tools"
    exit 1
fi

check_device() {
    echo "[*] Checking connected device..."
    local state
    state=$(adb get-state < /dev/null 2>/dev/null)
    if [ "$state" != "device" ]; then
        echo "[-] No authorized device found."
        echo "    1. Connect your phone via USB."
        echo "    2. Turn on USB Debugging in Developer Options."
        echo "    3. Tap 'Allow' on your phone screen."
        exit 1
    fi
    local model
    model=$(adb shell getprop ro.product.model < /dev/null 2>/dev/null | tr -d '\r')
    echo "[+] Connected to: $model"
}

remove_packages() {
    local list=("$@")
    for pkg in "${list[@]}"; do
        echo -n "  -> Removing $pkg: "
        local res
        res=$(adb shell "pm uninstall -k --user 0 '$pkg' 2>&1" < /dev/null | tr -d '\r')
        if [[ "$res" == *"Success"* ]]; then
            echo "Success"
        else
            # Try disabling if uninstall is protected
            local dis
            dis=$(adb shell "pm disable-user --user 0 '$pkg' 2>&1" < /dev/null | tr -d '\r')
            if [[ "$dis" == *"new state"* ]]; then
                echo "Disabled"
            else
                echo "Skipped / Not found"
            fi
        fi
    done
}

# 1. Xiaomi Ads & Background Telemetry
remove_ads_telemetry() {
    echo ""
    echo "=== [1/4] Removing Xiaomi Ads & Telemetry ==="
    local pkgs=(
        "com.miui.msa.global"
        "com.miui.analytics"
        "com.miui.daemon"
        "com.miui.bugreport"
        "com.miui.yellowpage"
        "com.xiaomi.joyose"
        "com.facebook.services"
        "com.facebook.system"
        "com.facebook.appmanager"
    )
    remove_packages "${pkgs[@]}"
}

# 2. Sponsor Pre-installs & Games
remove_sponsor_bloat() {
    echo ""
    echo "=== [2/4] Removing Sponsor Pre-installs & Games ==="
    local pkgs=(
        "com.zhiliaoapp.musically"
        "com.alibaba.aliexpresshd"
        "com.qeeq.android"
        "com.reachjunction.card.game.solitaire"
        "com.block.juggle"
        "com.lemon.lvoverseas"
        "com.amazon.mShop.android.shopping"
        "com.amazon.appmanager"
        "com.linkedin.android"
        "com.netflix.mediaclient"
        "com.miui.android.fashiongallery"
        "com.mi.globalminusscreen"
        "com.mi.global.shop"
        "com.mi.global.bbs"
        "cn.wps.xiaomi.abroad.lite"
    )
    remove_packages "${pkgs[@]}"
}

# 3. MIUI User Apps (Mi Video, Mi Music, Mi Browser, etc.)
remove_miui_apps() {
    echo ""
    echo "=== [3/4] Removing MIUI User Apps ==="
    local pkgs=(
        "com.mi.globalbrowser"
        "com.xiaomi.mipicks"
        "com.xiaomi.glgm"
        "com.miui.cleaner"
        "com.xiaomi.smarthome"
        "com.xiaomi.midrop"
        "com.xiaomi.scanner"
        "com.mi.android.globalFileexplorer"
        "com.xiaomi.calendar"
        "com.miui.weather2"
        "com.miui.compass"
        "com.miui.notes"
        "com.miui.calculator"
        "com.duokan.phone.remotecontroller"
        "com.xiaomi.payment"
        "com.miui.touchassistant"
        "com.miui.cloudservice"
        "com.miui.cloudbackup"
        "com.miui.micloudsync"
        "com.android.soundrecorder"
        "com.android.mms"
        "com.android.thememanager"
    )
    remove_packages "${pkgs[@]}"
}

# 4. Optional Google Apps
remove_google_apps() {
    echo ""
    echo "=== [4/4] Removing Optional Google Apps ==="
    local pkgs=(
        "com.google.android.youtube"
        "com.google.android.apps.youtube.music"
        "com.google.android.gm"
        "com.google.android.apps.maps"
        "com.google.android.apps.photos"
        "com.google.android.googlequicksearchbox"
        "com.google.android.apps.tachyon"
        "com.google.android.apps.docs"
        "com.google.android.apps.chromecast.app"
        "com.google.android.apps.wellbeing"
        "com.google.android.projection.gearhead"
        "com.google.android.apps.subscriptions.red"
        "com.google.android.feedback"
        "com.google.android.apps.walletnfcrel"
        "com.google.android.apps.safetyhub"
        "com.google.android.safetycore"
        "com.android.chrome"
        "com.xiaomi.finddevice"
    )
    remove_packages "${pkgs[@]}"
}

# 5. Silence Security app
silence_security() {
    echo ""
    echo "[*] Silencing Security app notifications and location tracking..."
    adb shell appops set com.miui.securitycenter POST_NOTIFICATION ignore 2>/dev/null
    adb shell appops set com.miui.securitycenter FINE_LOCATION ignore 2>/dev/null
    adb shell appops set com.miui.securitycenter COARSE_LOCATION ignore 2>/dev/null
    echo "[+] Security app silenced (framework preserved for Play Store)."
}

# 6. Reinstall an app
restore_app() {
    echo ""
    read -rp "Enter package name to restore (e.g. com.android.chrome): " pkg
    if [ -n "$pkg" ]; then
        echo "[*] Restoring $pkg..."
        adb shell cmd package install-existing "$pkg"
    fi
}

# 7. Backup Photos
backup_photos() {
    echo ""
    local dest="$HOME/Downloads/XiaomiBackup_$(date +%Y%m%d_%H%M%S)"
    echo "[*] Creating backup folder: $dest"
    mkdir -p "$dest"
    echo "[*] Pulling DCIM..."
    adb pull -a /sdcard/DCIM "$dest/"
    echo "[*] Pulling Pictures..."
    adb pull -a /sdcard/Pictures "$dest/"
    echo "[*] Pulling WhatsApp Images (if present)..."
    adb pull -a "/sdcard/Android/media/com.whatsapp/WhatsApp/Media/WhatsApp Images" "$dest/" 2>/dev/null || true
    echo "[+] Backup finished! Saved to: $dest"
}

# Main Menu
check_device

echo ""
echo "=========================================="
echo "      Xiaomi / HyperOS Tool Menu          "
echo "=========================================="
echo " 1) Complete Full Clean (Recommended: 1+2+3+4+5)"
echo " 2) Remove Ads & Telemetry only"
echo " 3) Remove Sponsor Apps & Games only"
echo " 4) Remove MIUI Apps (Browser, GetApps, etc.)"
echo " 5) Remove Optional Google Apps & Chrome"
echo " 6) Silence Security App & Telemetry"
echo " 7) Restore a package"
echo " 8) Backup Photos & Videos to Mac"
echo " 0) Exit"
echo "=========================================="
read -rp "Choose an option [1-8]: " choice

case "$choice" in
    1)
        remove_ads_telemetry
        remove_sponsor_bloat
        remove_miui_apps
        remove_google_apps
        silence_security
        echo ""
        echo "[+] Complete full clean finished!"
        ;;
    2) remove_ads_telemetry ;;
    3) remove_sponsor_bloat ;;
    4) remove_miui_apps ;;
    5) remove_google_apps ;;
    6) silence_security ;;
    7) restore_app ;;
    8) backup_photos ;;
    0) exit 0 ;;
    *) echo "[-] Invalid option." ;;
esac
