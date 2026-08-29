# Essential Linux Commands Cheat Sheet & Reference Guide

This comprehensive reference guide covers essential Linux commands for system navigation, file operations, searching, inspecting log files, and text processing.

---

## Quick Reference Table

| Command | Purpose | Primary Use Case |
| :--- | :--- | :--- |
| `uname` | Print system information | Checking kernel version and system architecture |
| `pwd` | Print working directory | Finding your current path in the filesystem |
| `cd` | Change directory | Navigating between folders |
| `ls` | List directory contents | Inspecting files, permissions, and sizes |
| `cat` | Concatenate and display files | Viewing file content or combining files |
| `grep` | Global regular expression print | Searching for specific text patterns in files |
| `cp` | Copy files and directories | Creating backups or duplicating items |
| `wc` | Word, line, character count | Counting log lines, words, or bytes |
| `find` | Search files in directory tree | Locating files by name, type, or modification time |
| `diff` | Compare files line by line | Spotting differences between two config/log files |
| `curl` | Transfer data with URLs | Testing APIs or downloading remote resources |
| `vim` | Terminal text editor | Editing configuration files or log samples |
| `chmod` | Change file access permissions | Modifying read, write, and execute rights |

---

## Sample commands accourding to the tutorial
### 1. Check your initial working directory (Starts at /root)
```
pwd
```

### 2. Inspect root configuration and setup files copied into /root
```
ls -la
```

### 3. Navigate to the application log directory
```
cd /var/log/application
```

### 4. List all log files with human-readable sizes and details
```
ls -lh
```

### 5. View contents of the access log
```
cat access.log
```

### 6. Extract all lines containing "ERROR" or HTTP 500 status codes from access.log
```
grep "ERROR" access.log

grep "500" access.log
```

### 7. Count total log entries in access.log vs total error lines
```
wc -l access.log

grep "ERROR" access.log | wc -l
```

### 8. Search across system logs for failed login attempts
```
grep "Failed password" system.log
```

### 9. Find configuration files inside /etc/application
```
find /etc/application -type f -name "*.conf*"
```

### 10. Compare the database configuration with its backup file to spot changes
```
diff -u /etc/application/db.conf /etc/application/db.conf.backup
```

### 11. Test the mock server or local endpoints using curl (If server running on port 5432)
```
curl -I http://localhost:5432
```

### 12. Edit or inspect a configuration file directly using Vim
```
vim /etc/application/db.conf
```

## Detailed Command Explanations & Examples

### 1. `uname` — Print System Information

The `uname` (unix name) command outputs detailed system information about the Linux kernel, operating system, and hardware architecture.

#### Key Options
* `-a` / `--all` : Print all system information in sequence.
* `-r` / `--kernel-release` : Display the operating system kernel release version.
* `-m` / `--machine` : Show the machine hardware architecture (e.g., `x86_64`, `aarch64`).

#### Examples

```bash
# Display basic OS kernel name
uname

# Output all system details (kernel name, hostname, kernel release, arch, OS)
uname -a

# Print only the machine hardware architecture
uname -m
```

---

### 2. `pwd` — Print Working Directory

`pwd` outputs the absolute path of the directory you are currently working in.

#### Key Options
* `-P` : Print the physical directory (resolves symbolic links to their real paths).
* `-L` : Print the logical directory (includes symbolic links).

#### Examples

```bash
# Print your current directory path
pwd

# Resolve and print physical path if working inside a symlinked directory
pwd -P
```

---

### 3. `cd` — Change Directory

`cd` moves your shell session from the current directory to another specified directory.

#### Shortcuts & Syntax
* `cd /path/to/directory` : Move to a target absolute/relative path.
* `cd ~` or `cd` : Return directly to the current user's home directory.
* `cd ..` : Move up one directory level.
* `cd -` : Switch back to the previous working directory.

#### Examples

```bash
# Navigate to the system log folder
cd /var/log

# Move up two folder levels
cd ../..

# Return to your home directory
cd ~

# Toggle back to your previous directory
cd -
```

---

### 4. `ls` — List Directory Contents

`ls` lists files, directories, and metadata within a designated directory.

#### Key Options
* `-l` : Use long listing format (shows file permissions, owner, size, modification date).
* `-a` : Include hidden files (files starting with a `.`).
* `-h` : Display file sizes in human-readable formats (`KB`, `MB`, `GB`).
* `-t` : Sort contents by modification time (newest first).

#### Examples

```bash
# Basic file listing
ls

# Detailed view with human-readable file sizes and hidden files
ls -lah

# List files sorted by last modified timestamp
ls -lt /var/log/my_app
```

---

### 5. `cat` — Concatenate and Display Files

`cat` reads files sequentially and prints their contents to standard output. It is frequently used for reading small text files.

#### Key Options
* `-n` : Number all output lines.
* `-b` : Number non-empty output lines.

#### Examples

```bash
# Display content of an application log file
cat app.log

# View file content with line numbers
cat -n app.log

# Combine two log files into a combined master log file
cat app1.log app2.log > combined.log
```

---

### 6. `grep` — Pattern Searching with Regular Expressions

`grep` searches files for matching text lines based on a pattern or regular expression.

#### Key Options
* `-i` : Perform case-insensitive search.
* `-v` : Invert match (select lines that **do not** match the pattern).
* `-n` : Prefix output with line numbers from the input file.
* `-c` : Output only a count of matching lines.
* `-r` or `-R` : Search directories recursively.

#### Examples

```bash
# Search for all lines containing "ERROR"
grep "ERROR" app.log

# Search case-insensitively for "database" with line numbers
grep -in "database" app.log

# Count how many critical events occurred
grep -c "CRITICAL" app.log

# Search recursively across all logs for "Timeout"
grep -rn "Timeout" /var/log/
```

---

### 7. `cp` — Copy Files and Directories

`cp` creates duplicates of specified files or directories at a designated destination path.

#### Key Options
* `-r` or `-R` : Copy directories recursively.
* `-i` : Prompt before overwriting an existing file.
* `-v` : Explain what is being done (verbose mode).

#### Examples

```bash
# Create a backup copy of a log file
cp app.log app.log.bak

# Copy a directory recursively to a backup destination
cp -r /var/log/my_app /tmp/my_app_backup

# Copy with interactive confirmation prompt
cp -i config.json config.json.bak
```

---

### 8. `wc` — Word, Line, and Byte Count

`wc` counts lines, words, and characters/bytes in text files or pipeline outputs.

#### Key Options
* `-l` : Count lines.
* `-w` : Count words.
* `-c` : Count bytes.

#### Examples

```bash
# Count total lines in a log file
wc -l app.log

# Combine grep and wc using pipes to count matching error logs
grep "ERROR" app.log | wc -l

# Check word count of a file
wc -w README.md
```

---

### 9. `find` — Search Files in Directory Hierarchy

`find` searches directory trees for files matching specific conditions like name, type, size, or modification date.

#### Key Options & Flags
* `-name` : Search for files matching a filename pattern (case-sensitive).
* `-iname` : Case-insensitive name search.
* `-type f` : Search for regular files only.
* `-type d` : Search for directories only.
* `-mtime -N` : Modified less than `N` days ago.

#### Examples

```bash
# Find all files ending with .log in /var/log
find /var/log -type f -name "*.log"

# Search case-insensitively for files containing "db" in their name
find . -type f -iname "*db*"

# Find files modified within the last 24 hours
find /var/log -type f -mtime -1
```

---

### 10. `diff` — Compare Files Line by Line

`diff` compares two text files and highlights line-by-line differences between them.

#### Key Options
* `-u` : Output in unified format (cleaner and standard for code reviews/patches).
* `-i` : Ignore case differences in file contents.
* `-w` : Ignore all white space differences.

#### Examples

```bash
# Compare two configuration or log files
diff app_v1.log app_v2.log

# Compare using standard unified output format
diff -u old_config.conf new_config.conf

# Ignore whitespace changes while comparing
diff -w file1.txt file2.txt
```

---

### 11. `curl` — Transfer Data from or to a Server

`curl` is a command-line tool for transferring data over protocols such as HTTP, HTTPS, FTP, and SFTP.

#### Key Options
* `-I` or `--head` : Fetch HTTP response headers only.
* `-o <filename>` : Save output to a local file.
* `-O` : Download remote file using its original filename.
* `-X <method>` : Specify custom HTTP request method (`GET`, `POST`, `PUT`, `DELETE`).

#### Examples

```bash
# Make a simple HTTP GET request and print response body
curl https://api.github.com

# Fetch HTTP headers of a website
curl -I https://www.google.com

# Download a remote log file and save locally
curl -o downloaded_app.log https://example.com/logs/app.log

# Send a JSON payload via HTTP POST
curl -X POST https://api.example.com/data -H "Content-Type: application/json" -d '{"status":"active"}'
```

---

### 12. `vim` — Terminal Text Editor

`vim` (Vi Improved) is a modal command-line text editor.

#### Essential Modal Navigation & Commands
* `i` : Enter **Insert Mode** (to type and edit text).
* `Esc` : Return to **Normal Mode**.
* `:w` : Save (write) changes.
* `:q` : Quit Vim.
* `:wq` or `ZZ` : Save changes and quit.
* `:q!` : Force quit without saving changes.
* `/pattern` : Search for text pattern inside the document.

#### Examples

```bash
# Open or create a file with Vim
vim app.log

# Useful workflow inside Vim:
# 1. Press `i` to begin editing text.
# 2. Make required edits.
# 3. Press `Esc` to exit editing mode.
# 4. Type `:wq` and press Enter to save and exit.
```

---

### 13. `chmod` — Change File Access Permissions

`chmod` modifies file system access permissions for owner (`u`), group (`g`), and others (`o`).

#### Symbolic Notation
* `u` (user/owner), `g` (group), `o` (others), `a` (all)
* `+` (add permission), `-` (remove permission), `=` (set exact permission)
* `r` (read), `w` (write), `x` (execute)

#### Octal (Numeric) Notation
* `4` : Read (`r`)
* `2` : Write (`w`)
* `1` : Execute (`x`)
* *Common modes:* `755` (`rwxr-xr-x`), `644` (`rw-r--r--`), `700` (`rwx------`)

#### Examples

```bash
# Make a shell script executable using symbolic mode
chmod +x backup.sh

# Set owner read/write, group/others read-only (numeric notation)
chmod 644 app.log

# Grant full read, write, execute permissions to owner, read/execute to group and others
chmod 755 run_container.sh
```

---

## Practical Log Analysis Workflow Example

Below is a step-by-step example combining several of these commands to analyze log files inside a Docker environment:

```bash
# 1. Check your current path
pwd

# 2. Change directory to the log folder
cd /var/log/my_app

# 3. List log files with sizes and dates
ls -lh

# 4. Count total lines in the log file
wc -l app.log

# 5. Extract all lines containing "ERROR" and count them
grep "ERROR" app.log | wc -l

# 6. Locate all files named "*.log" modified recently
find . -type f -name "*.log"

# 7. Compare baseline log with current log
diff -u app.log app.log.bak