#!/bin/bash

# My default path values for variables
source_dir=""
dest_dir=""
log_file="/root/backup_stats.csv"
while [[ $# -gt 0 ]]
   do
    case $1 in
        --source)
            source_dir="$2"
            shift 2
            ;;
        --dest)
            dest_dir="$2"
            shift 2
            ;;
        --log)
            log_file="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done
if [[ -z "$source_dir" || -z "$dest_dir" ]]; then
    echo "Usage: $0 --source <source_directory> --dest <destination_directory> --log <log_file>" #Mentioned again in readme about the command which should be give to run the script
    exit 1
fi
file_count=0
start_time=$(date +%s)
pid=$$
contains_vowel()
{
    echo "$1" | grep -iq "[aeiou]"
}
for src_item in $(find "$source_dir" -type f)
    do
    base_name=$(basename "$src_item")
    if ! contains_vowel "$base_name"
      then
        continue
    fi

    relative_path=$(realpath --relative-to="$source_dir" "$src_item")
    dest_item="$dest_dir/$relative_path"
    target_dir=$(dirname "$dest_item")
    if [ ! -d "$target_dir" ]
    then
        mkdir -p "$target_dir"
    fi

    if [ ! -f "$dest_item" ] || [ "$src_item" -nt "$dest_item" ]
     then
        cp "$src_item" "$dest_item"
        file_count=$((file_count + 1))
    fi
done
end_time=$(date +%s)
runtime=$((end_time - start_time))
echo "PID:$pid, RUNTIME in SECONDS:$runtime, NUMBER OF FILES COPIED:$file_count" >> "$log_file"
echo "Total files copied: $file_count"
