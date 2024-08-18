#!/bin/bash

# Set default source and destination directories
source_dir="/source"
dest_dir="/dest"

# Set a fixed log file path (no need to specify it as an argument)
log_file="/root/default_log_file.log"

# Start logging
start_time=$(date +%s)
file_count=0
pid=$$

contains_vowel() {
    echo "$1" | grep -iq "[aeiou]"
}

# Find and process all files in the source directory
find "$source_dir" -type f -print | while read -r src_item; do
    base_name=$(basename "$src_item")
    
    echo "Checking file: $base_name"  # Debug statement

    # Skip files that do not contain vowels
    if ! contains_vowel "$base_name"; then
        echo "Skipping $base_name (no vowels)"  # Debug statement
        continue
    fi

    # Determine the relative path of the file within the source directory
    relative_path=$(realpath --relative-to="$source_dir" "$src_item")

    # Determine the destination file path
    dest_item="$dest_dir/$relative_path"
    
    # Ensure the target directory exists
    target_dir=$(dirname "$dest_item")
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
    fi

    # Only proceed if the file has been updated or doesn't exist in the destination
    if [ ! -f "$dest_item" ] || ! diff "$src_item" "$dest_item" > /dev/null; then
        # Copy the updated file to the destination directory
        cp "$src_item" "$dest_item"
        echo "Copied $src_item to $dest_item"  # Debug statement
        file_count=$((file_count + 1))
    else
        echo "No update needed for $src_item"  # Debug statement
    fi
done

end_time=$(date +%s)
runtime=$((end_time - start_time))

# Log the required details (or send them to a status file if needed)
echo "$(date +'%Y-%m-%d %H:%M:%S') PID: $pid Runtime: ${runtime} seconds Files added: $file_count" >> "$log_file"
