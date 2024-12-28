#!/system/bin/sh

# Debugging messages
echo "[DEBUG] post-fs-data.sh executed" > /data/local/tmp/debug_log.txt

# Define paths
HOSTS_DIR="/data/local/tmp/hosts_files"
MERGED_FILE="/data/local/tmp/merged_hosts"
MODIFIED_HOSTS="$MODDIR/system/etc/hosts"  # $MODDIR points to the module's overlay

# Copy update_hosts.sh to /data/local/tmp
cp $MODDIR/common/update_hosts.sh /data/local/tmp/update_hosts.sh
chmod +x /data/local/tmp/update_hosts.sh
echo "[DEBUG] update_hosts.sh deployed" >> /data/local/tmp/debug_log.txt

# Ensure the hosts directory exists
mkdir -p "$HOSTS_DIR"

# Check and modify SELinux status
SELINUX_STATUS=$(getenforce)
if [ "$SELINUX_STATUS" = "Enforcing" ]; then
    echo "[DEBUG] SELinux is Enforcing. Switching to Permissive..." >> /data/local/tmp/debug_log.txt
    setenforce 0
else
    echo "[DEBUG] SELinux is already Permissive." >> /data/local/tmp/debug_log.txt
fi

# Merge hosts files if they exist
if [ "$(ls -A $HOSTS_DIR 2>/dev/null)" ]; then
    echo "[DEBUG] Merging hosts files from $HOSTS_DIR..." >> /data/local/tmp/debug_log.txt
    cat "$HOSTS_DIR"/* | sort | uniq > "$MERGED_FILE"
    cp "$MERGED_FILE" "$MODIFIED_HOSTS"
    chmod 644 "$MODIFIED_HOSTS"
    echo "[DEBUG] Hosts file successfully updated." >> /data/local/tmp/debug_log.txt
else
    echo "[DEBUG] No hosts files found in $HOSTS_DIR. Skipping merge." >> /data/local/tmp/debug_log.txt
fi

exit 0

