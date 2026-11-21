# Xiaomi & HyperOS Debloater & Backup Tool

A safe, interactive shell tool to debloat Xiaomi / Redmi / POCO devices running MIUI or HyperOS via ADB without bricking or breaking Google Play Store.

## Features

- **Xiaomi Ads & Telemetry Removal**: Removes `msa`, `analytics`, `daemon`, `joyose`, and background Facebook trackers.
- **Sponsor & Partner Bloatware Removal**: Removes pre-installed apps like TikTok, AliExpress, Amazon, Netflix, and Glance Wallpaper Carousel.
- **MIUI Apps Removal**: Removes or disables user-facing system apps (Mi Browser, GetApps, Mi Video, Cleaner, Mi Cloud, etc.).
- **Safe Google Apps Removal**: Removes YouTube, Gmail, Maps, Google App, Chrome, and Google Meet while preserving core essentials (Phone, SMS, Gboard keyboard, and Play Store).
- **Security App Neutralization**: Silences notifications and revokes location access for `com.miui.securitycenter` without uninstalling it (preventing bootloops).
- **1-Click Photo & Video Backup**: Pulls `DCIM`, `Pictures`, and WhatsApp images to your computer with original timestamps preserved.
- **Package Restore**: Quickly reinstall any uninstalled package with a single command.

---

## Prerequisites

1. **Mac / Linux / Windows (WSL)** with `bash`.
2. **Android Platform Tools (ADB)**:
   ```bash
   brew install --cask android-platform-tools
   ```
3. **Enable Developer Options on Device**:
   - Open **Settings** > **About phone**.
   - Tap **OS version** (or MIUI version) 7 times.
   - Go to **Settings** > **Additional settings** > **Developer options**.
   - Turn on **USB debugging**.
   - Plug phone into Mac/PC via USB and tap **Always allow from this computer**.

---

## Quick Start

1. Clone or download this repository:
   ```bash
   git clone git@github.com:jstani7/xiaomi-hyperos-debloater.git
   cd xiaomi-hyperos-debloater
   ```

2. Make the script executable:
   ```bash
   chmod +x debloat.sh
   ```

3. Run the interactive menu:
   ```bash
   ./debloat.sh
   ```

---

## Menu Options

```text
==========================================
      Xiaomi / HyperOS Tool Menu          
==========================================
 1) Complete Full Clean (Recommended: 1+2+3+4+5)
 2) Remove Ads & Telemetry only
 3) Remove Sponsor Apps & Games only
 4) Remove MIUI Apps (Browser, GetApps, etc.)
 5) Remove Optional Google Apps & Chrome
 6) Silence Security App & Telemetry
 7) Restore a package
 8) Backup Photos & Videos to Mac
 0) Exit
==========================================
```

---

## Network-Wide Ad Blocking (Private DNS)

To block in-app banner ads and web ads device-wide:
1. Open **Settings** > **Connection & sharing** > **Private DNS**.
2. Select **Private DNS provider hostname**.
3. Enter: `dns.adguard-dns.com` and tap **Save**.

---

## License

MIT License. Free to use and modify.
