#!/system/bin/sh

# Paths
HOSTS_DIR="/data/local/tmp/hosts_files"
MERGED_FILE="/data/local/tmp/merged_hosts"
HOSTS_SOURCES=(
    "https://github.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/raw/refs/heads/master/hosts/hosts0"
    "https://github.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/raw/refs/heads/master/hosts/hosts1"
    "https://github.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/raw/refs/heads/master/hosts/hosts2"
    "https://github.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist/raw/refs/heads/master/hosts/hosts3"
)

# Ensure the hosts directory exists
mkdir -p "$HOSTS_DIR"

# Download the hosts files
echo "[Magisk Module] Downloading hosts files..."
for i in "${!HOSTS_SOURCES[@]}"; do
    FILE="$HOSTS_DIR/hosts$i"
    echo "[Magisk Module] Downloading ${HOSTS_SOURCES[i]} to $FILE"
    curl -sSL -o "$FILE" "${HOSTS_SOURCES[i]}"
    if [ $? -ne 0 ]; then
        echo "[Magisk Module] Failed to download ${HOSTS_SOURCES[i]}"
        exit 1
    fi
done

# Merge the downloaded files
echo "[Magisk Module] Merging hosts files..."
cat "$HOSTS_DIR"/* | sort | uniq > "$MERGED_FILE"
if [ $? -ne 0 ]; then
    echo "[Magisk Module] Error while merging hosts files."
    exit 1
fi

echo "[Magisk Module] Hosts files downloaded and merged successfully."
