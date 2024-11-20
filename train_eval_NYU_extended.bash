#!/bin/bash

# Function to format seconds into h:m:s
format_time() {
    local total_seconds=$1
    printf "%02d:%02d:%02d" $((total_seconds / 3600)) $(((total_seconds % 3600) / 60)) $((total_seconds % 60))
}

# Set variables
datapath="/home/roman/projects/ai/NYU_HAND_POSE_DATASET/dataset"
folder="nyu_experiment"
config_file="configs/nyu.yaml"
checkpoint_path="$folder/checkpoints"

# Define commands
ex1="" # "python main.py --check $folder --config_file $config_file"
ex2="python eval.py --path $checkpoint_path --datasetpath $datapath"

# Get the current date and time
start_time=$(date +%s)

# Run the first command and check for errors
echo "[$(date)] Running training command: $ex1"
if $ex1; then
    echo "[$(date)] Training completed successfully."
else
    echo "[$(date)] Training failed. Exiting."
    exit 1
fi

# Measure elapsed time for the first command
mid_time=$(date +%s)
train_time=$((mid_time - start_time))
echo "Training took $(format_time $train_time)."

# Run the second command and check for errors
echo "[$(date)] Running evaluation command: $ex2"
if $ex2; then
    echo "[$(date)] Evaluation completed successfully."
else
    echo "[$(date)] Evaluation failed. Exiting."
    exit 1
fi

# Measure elapsed time for the second command
end_time=$(date +%s)
eval_time=$((end_time - mid_time))
echo "Evaluation took $(format_time $eval_time)."

# Total execution time
total_time=$((end_time - start_time))
echo "Total script took $(format_time $total_time)."
