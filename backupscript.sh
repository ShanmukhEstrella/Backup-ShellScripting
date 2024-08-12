usage() {
    echo "Usage: $0 -s <source_directory> -d <destination_directory> -o <log_file>"
    exit 1
}

# Parse command-line arguments
while getopts "s:d:o:" opt; do
    case ${opt} in
        s )
            source_dir=$OPTARG
            ;;
        d )
            dest_dir=$OPTARG
            ;;
        o )
            log_file=$OPTARG
            ;;
        \? )
            usage
            ;;
    esac
done

# Check if all arguments are provided
if [ -z "$source_dir" ] || [ -z "$dest_dir" ] || [ -z "$log_file" ]; then
    usage
fi
echo "Sync script started at $(date)" > "$log_file"
echo "PID: $$" >> "$log_file"
contains_vowel() 
{
    echo "$1" | grep -iq "[aeiou]"
}
find "$source_dir" -print | while read -r src_item
 do
    base_name=$(basename "$src_item")
    if ! contains_vowel "$base_name"; then
        continue
    fi
    relative_path="${src_item#$source_dir/}"
    dest_item="$dest_dir/$relative_path"

    if [ -d "$src_item" ]; then
        # If it's a directory, create the corresponding directory in the destination
        if [ ! -d "$dest_item" ]; then
            echo "Creating directory $dest_item" >> "$log_file"
            mkdir -p "$dest_item"
        fi
    elif [ -f "$src_item" ]; then
        # If it's a file, check if it exists in the destination
        if [ ! -f "$dest_item" ] || ! diff "$src_item" "$dest_item" > /dev/null; then
            # Create the directory if it doesn't exist
            mkdir -p "$(dirname "$dest_item")"
            echo "Copying/updating file $src_item to $dest_item" >> "$log_file"
            cp "$src_item" "$dest_item"
        fi
     fi
done
end_time=$(date +%s)
start_time=${start_time:-$end_time}
runtime=$((end_time - start_time))
echo "Sync script ended at $(date)" >> "$log_file"
echo "Runtime: ${runtime} seconds" >> "$log_file"
echo "$log_file" >>  "/root/status.txt"
