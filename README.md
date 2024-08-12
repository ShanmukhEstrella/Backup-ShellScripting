# Automated Backup Script

This script performs automated backups from a source directory to a destination directory. It copies files and directories whose names contain at least one vowel and updates them if there are any changes. The script also logs its activities to a specified log file.

## Features

- **Backup Files and Directories**: Only files and directories with at least one vowel in their names are processed.
- **Efficient Backup**: Files are only copied or updated if they differ from the destination.
- **Logging**: Detailed logs of the script's activities are maintained.
- **Automatic Directory Creation**: Missing directories are created in the destination path.

## Usage

To run the script, use the following command:

```bash
./backup_script.sh -s <source_directory> -d <destination_directory> -o <log_file>
