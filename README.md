# adblock-hosts
Magisk/KernelSU module to update and merge hosts files for ad-blocking
# Merge Hosts Updater
A Magisk/KernelSU module to download and merge hosts files for ad-blocking. Updates the `/system/etc/hosts` file on rooted Android devices.

## Features
- Downloads hosts files from predefined sources.
- Merges and deduplicates entries.
- Automatically updates `/system/etc/hosts`.

## Installation
1. Download the module from this repository.
2. Install it via the Magisk or KernelSU app.
3. Reboot your device.

## Usage
- The module runs automatically after installation.
- To manually trigger the script:
  ```bash
  su -c "sh /system/etc/merge_hosts.sh"
