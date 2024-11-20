#!/bin/bash

# Function to format seconds into h:m:s
format_time() {
    local total_seconds=$1
    printf "%02d:%02d:%02d" $((total_seconds / 3600)) $(((total_seconds % 3600) / 60)) $((total_seconds % 60))
}

# Set variables
folder="nyu_experiment"
config_file="configs/nyu.yaml"

# Define commands
ex="python main.py --check $folder --config_file $config_file"

# Get the current date and time
start_time=$(date +%s)

# Run the first command and check for errors
echo "[$(date)] Running training command: $ex"
if $ex; then
    echo "[$(date)] Training completed successfully."
else
    echo "[$(date)] Training failed. Exiting."
    exit 1
fi

# Measure elapsed time for the first command
end_time=$(date +%s)
train_time=$((end_time - start_time))
echo "Training took $(format_time $train_time)."

