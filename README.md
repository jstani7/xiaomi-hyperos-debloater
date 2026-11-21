# Xiaomi & HyperOS Debloater & Backup Tool

A safe, interactive script to debloat Xiaomi, Redmi, and POCO devices running MIUI or HyperOS via ADB without bootloops or breaking Google Play Store.

---

## Supported Operating Systems

- **macOS**
- **Windows** (via Git Bash, WSL, or MSYS2)
- **Linux**

---

## 1. Prerequisites & ADB Setup

### macOS
Install Android Platform Tools via Homebrew:
```bash
brew install --cask android-platform-tools
```

### Windows
Install Android Platform Tools using Winget:
```powershell
winget install Google.PlatformTools
```
*(Or download the official Platform Tools ZIP from Google and add it to your PATH).*

You also need **Git Bash** (installed with Git for Windows) or **WSL** to run the bash script.

### Linux
```bash
sudo apt install adb       # Debian / Ubuntu
sudo dnf install android-tools # Fedora / RHEL
```

---

## 2. Phone Setup (Developer Options)

1. Open **Settings** > **About phone**.
2. Tap **OS version** (or **MIUI version**) 7 times consecutively to unlock Developer options.
3. Navigate to **Settings** > **Additional settings** > **Developer options**.
4. Enable **USB debugging**.
5. Connect your phone to your computer via USB cable.
6. When prompted on your phone screen, check **Always allow from this computer** and tap **Allow** / **OK**.

---

## 3. How to Run

### On macOS / Linux:
```bash
git clone git@github.com:jstani7/xiaomi-hyperos-debloater.git
cd xiaomi-hyperos-debloater
chmod +x debloat.sh
./debloat.sh
```

### On Windows (using Git Bash):
1. Right-click inside your project folder and select **Open Git Bash here**.
2. Run:
```bash
bash debloat.sh
```

---

## 4. Menu Options

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
 8) Backup Photos & Videos to PC/Mac
 0) Exit
==========================================
```

---

## 5. Network-Wide Ad & Tracker Blocking (Private DNS)

To eliminate in-app and browser banner ads across your phone:
1. Open **Settings** > **Connection & sharing** > **Private DNS**.
2. Select **Private DNS provider hostname**.
3. Type: `dns.adguard-dns.com` and tap **Save**.

---

## License

This project is licensed under the [MIT License](LICENSE).
