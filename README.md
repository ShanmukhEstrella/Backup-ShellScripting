# Automated Backup Script

This script performs automated backups from a source directory to a destination directory. It copies files and their corresponding directory structure if the file name contains at least one vowel and updates them in destination directory if there are any changes. The script also logs its activities(PID of back up process, the runtime of the backup process and no.of files copied during that backup process) to a specified file location as given by user. If not given it automatically creates that stats file in the default loacation set at the starting of the script that is:
```bash
"/root/backup_stats.csv"

# Features

- **Backup Files and Directories**: Only files  with at least one vowel in their names are processed.
- **Efficient Backup**: Files are only copied or updated if they differ from the destination.
- **Logging**: Detailed logs of the script's activities are maintained.
- **Automatic Directory Creation**: Missing directories are created in the destination path.

# Usage
To run the script, use the following command:
```bash
./backup_script.sh -s <source_directory> -d <destination_directory> -o <log_file>

It will be better if the absolute paths are given in <source_directory> and <destination_directory> and <log_file>.
As it is stated earlier, -o <log_file> is optional, if not given, the stats will be automatically stored in the file location:
```bash
"/root/backup_stats.csv"

The backup_stats.csv file gets appended with the corresponding stats whenever the script file gets executed.
