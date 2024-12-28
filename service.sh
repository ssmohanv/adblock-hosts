#!/system/bin/sh

# Debugging message
echo "[DEBUG] service.sh executed" >> /data/local/tmp/debug_log.txt

# Paths
UPDATE_SCRIPT="/data/local/tmp/update_hosts.sh"
USER_TIME_FILE="/data/local/tmp/update_time"
DEFAULT_TIME="1:00"  # Default time if no user-defined time is set

# Check if user-defined time exists
if [ -f "$USER_TIME_FILE" ]; then
    USER_TIME=$(cat "$USER_TIME_FILE")
    # Validate user-provided time (HH:MM format)
    if echo "$USER_TIME" | grep -Eq '^([01]?[0-9]|2[0-3]):[0-5][0-9]$'; then
        SCHEDULE_TIME="$USER_TIME"
        echo "[DEBUG] Using user-defined schedule time: $SCHEDULE_TIME" >> /data/local/tmp/debug_log.txt
    else
        SCHEDULE_TIME="$DEFAULT_TIME"
        echo "[DEBUG] Invalid time format in $USER_TIME_FILE. Falling back to default: $DEFAULT_TIME" >> /data/local/tmp/debug_log.txt
    fi
else
    SCHEDULE_TIME="$DEFAULT_TIME"
    echo "[DEBUG] No user-defined time found. Using default: $DEFAULT_TIME" >> /data/local/tmp/debug_log.txt
fi

# Schedule the update task
echo "sh $UPDATE_SCRIPT" | at "$SCHEDULE_TIME"
echo "[DEBUG] Update task scheduled at $SCHEDULE_TIME" >> /data/local/tmp/debug_log.txt
