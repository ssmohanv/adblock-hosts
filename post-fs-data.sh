#!/system/bin/sh

# Debugging messages
echo "[Magisk Module] post-fs-data.sh started..."

# Define paths
HOSTS_DIR="/data/local/tmp/hosts_files"
MERGED_FILE="/data/local/tmp/merged_hosts"
SYSTEM_HOSTS="/system/etc/hosts"
MODIFIED_HOSTS="$MODDIR/system/etc/hosts"  # $MODDIR points to the module's overlay

# Ensure the hosts directory exists
mkdir -p "$HOSTS_DIR"

# Check and modify SELinux status
SELINUX_STATUS=$(getenforce)
if [ "$SELINUX_STATUS" = "Enforcing" ]; then
    echo "[Magisk Module] SELinux is Enforcing. Switching to Permissive..."
    setenforce 0
else
    echo "[Magisk Module] SELinux is already Permissive."
fi

# Merge hosts files if they exist
if [ "$(ls -A $HOSTS_DIR 2>/dev/null)" ]; then
    echo "[Magisk Module] Merging hosts files from $HOSTS_DIR..."
    cat "$HOSTS_DIR"/* | sort | uniq > "$MERGED_FILE"
else
    echo "[Magisk Module] No hosts files found in $HOSTS_DIR. Skipping merge."
    exit 0
fi

# Replace system hosts file systemlessly
cp "$MERGED_FILE" "$MODIFIED_HOSTS"
chmod 644 "$MODIFIED_HOSTS"
echo "[Magisk Module] Systemless hosts file updated."

exit 0
