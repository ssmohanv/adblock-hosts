!/system/bin/sh

# Path to the update script
UPDATE_SCRIPT="/data/local/tmp/update_hosts.sh"

# Default update time (1:00 AM)
DEFAULT_TIME="1:00"

# User-defined time file
USER_TIME_FILE="/data/local/tmp/update_time"

# Read user-preferred time if available
if [ -f "$USER_TIME_FILE" ]; then
    USER_TIME=$(cat "$USER_TIME_FILE")
    # Validate time format (HH:MM)
    if echo "$USER_TIME" | grep -Eq '^([01]?[0-9]|2[0-3]):[0-5][0-9]$'; then
        SCHEDULE_TIME="$USER_TIME"
    else
        echo "[Magisk Module] Invalid time format in $USER_TIME_FILE. Falling back to default."
        SCHEDULE_TIME="$DEFAULT_TIME"
    fi
else
    echo "[Magisk Module] No user time file found. Using default time."
    SCHEDULE_TIME="$DEFAULT_TIME"
fi

# Schedule the update task
echo "sh $UPDATE_SCRIPT" | at "$SCHEDULE_TIME"

echo "[Magisk Module] Hosts update task scheduled at $SCHEDULE_TIME."
exit 0

