#  Complete Linux to Bash Scripting Guide for Beginners CheatSheet


---

##  Table of Contents

1. [Linux Basics](#linux-basics)
2. [File System Navigation](#file-system-navigation)
3. [File Operations](#file-operations)
4. [Users and Permissions](#users-and-permissions)
5. [Text Processing](#text-processing)
6. [Bash Scripting Fundamentals](#bash-scripting-fundamentals)
7. [Variables](#variables)
8. [User Input](#user-input)
9. [Conditional Statements](#conditional-statements)
10. [Loops](#loops)
11. [Functions](#functions)
12. [Arrays](#arrays)
13. [String Manipulation](#string-manipulation)
14. [File Testing](#file-testing)
15. [Error Handling](#error-handling)
16. [Practical Projects](#practical-projects)
17. [Quick Reference Cheatsheet](#quick-reference-cheatsheet)

---

# Linux Basics

## Understanding the Shell

The **shell** is your command-line interface to Linux. **Bash** (Bourne Again Shell) is the most common shell.

```bash
# Check your current shell
$ echo $SHELL
/bin/bash

# Check bash version
$ bash --version
GNU bash, version 5.1.16(1)-release
```

---

## Essential Linux Commands

### Displaying Information

```bash
# Print text to screen
$ echo "Hello World"
Hello World

# Print with newline
$ echo -e "Line 1\nLine 2"
Line 1
Line 2

# Print without newline
$ echo -n "No newline"
No newline$

# Display current date and time
$ date
Mon Dec 16 10:30:45 UTC 2024

# Format date
$ date +%Y-%m-%d
2024-12-16

$ date +"%Y-%m-%d %H:%M:%S"
2024-12-16 10:30:45

# Show calendar
$ cal
   December 2024      
Su Mo Tu We Th Fr Sa  
 1  2  3  4  5  6  7  
 8  9 10 11 12 13 14  
15 16 17 18 19 20 21  
22 23 24 25 26 27 28  
29 30 31              

# Current user
$ whoami
student

# System information
$ uname -a
Linux server 5.15.0-84-generic x86_64 GNU/Linux
```

---

# File System Navigation

## Directory Structure

```
/                       # Root (top of everything)
├── home/              # User home directories
│   └── student/       # Your home
├── etc/               # Configuration files
├── var/               # Variable data (logs, databases)
├── usr/               # User programs
├── tmp/               # Temporary files
└── bin/               # Essential commands
```

---

## Navigation Commands

```bash
# Print Working Directory (where am I?)
$ pwd
/home/student

# Change Directory
$ cd /home/student/Documents    # Go to specific path
$ cd ~                          # Go to home directory
$ cd ..                         # Go up one level
$ cd ../..                      # Go up two levels
$ cd -                          # Go to previous directory

# List files
$ ls                    # Basic list
$ ls -l                 # Long format (detailed)
$ ls -a                 # Show hidden files (starting with .)
$ ls -lh                # Human-readable sizes
$ ls -lt                # Sort by time (newest first)
$ ls -ltr               # Sort by time (oldest first)
$ ls -R                 # Recursive (show subdirectories)

# Detailed ls -l output explained:
# -rw-r--r-- 1 student student 1234 Dec 16 10:00 file.txt
# │          │ │       │       │    │           └─ filename
# │          │ │       │       │    └─ date modified
# │          │ │       │       └─ size (bytes)
# │          │ │       └─ group owner
# │          │ └─ user owner
# │          └─ number of links
# └─ permissions
```

---

# File Operations

## Creating Files and Directories

```bash
# Create empty file
$ touch file.txt
$ touch file1.txt file2.txt file3.txt    # Multiple files

# Create directory
$ mkdir mydir
$ mkdir dir1 dir2 dir3                   # Multiple directories
$ mkdir -p parent/child/grandchild       # Create nested directories

# Create file with content
$ echo "Hello" > file.txt                # Create/overwrite
$ echo "World" >> file.txt               # Append

# Create multi-line file
$ cat > myfile.txt << EOF
This is line 1
This is line 2
This is line 3
EOF
```

---

## Viewing Files

```bash
# Display entire file
$ cat file.txt

# Display with line numbers
$ cat -n file.txt

# Display first 10 lines
$ head file.txt
$ head -n 5 file.txt          # First 5 lines

# Display last 10 lines
$ tail file.txt
$ tail -n 20 file.txt         # Last 20 lines
$ tail -f /var/log/syslog     # Follow file (live updates)

# Page through file
$ less file.txt               # Press q to quit
$ more file.txt               # Simple pager

# Display file type
$ file myfile.txt
myfile.txt: ASCII text

$ file image.jpg
image.jpg: JPEG image data
```

---

## Copying, Moving, and Deleting

```bash
# Copy files
$ cp source.txt destination.txt
$ cp file.txt /home/student/backup/
$ cp -r directory/ backup_directory/    # Copy directory recursively
$ cp -v file.txt dest/                  # Verbose (show what's copied)
$ cp -i file.txt dest/                  # Interactive (ask before overwrite)

# Move/Rename files
$ mv oldname.txt newname.txt            # Rename
$ mv file.txt /home/student/Documents/  # Move
$ mv file1.txt file2.txt dir/           # Move multiple files

# Delete files (CAREFUL - no undo!)
$ rm file.txt                           # Delete file
$ rm -i file.txt                        # Interactive (ask confirmation)
$ rm -r directory/                      # Delete directory recursively
$ rm -rf directory/                     # Force delete (DANGEROUS!)

# Delete empty directory
$ rmdir emptydir
```

---

## Finding Files

```bash
# Find by name
$ find . -name "file.txt"
$ find /home -name "*.txt"              # Find all .txt files
$ find . -iname "FILE.txt"              # Case-insensitive

# Find by type
$ find . -type f                        # Files only
$ find . -type d                        # Directories only

# Find by size
$ find . -size +10M                     # Larger than 10MB
$ find . -size -1k                      # Smaller than 1KB

# Find by modification time
$ find . -mtime -7                      # Modified in last 7 days
$ find . -mtime +30                     # Modified more than 30 days ago

# Find and execute command
$ find . -name "*.log" -delete          # Find and delete
$ find . -name "*.txt" -exec cat {} \;  # Find and display content

# Quick file search (uses database)
$ locate filename                       # Fast search
$ sudo updatedb                         # Update locate database
```

---

## Searching Inside Files

```bash
# Search for text in file
$ grep "error" logfile.txt
$ grep -i "error" logfile.txt           # Case-insensitive
$ grep -n "error" logfile.txt           # Show line numbers
$ grep -v "success" logfile.txt         # Invert (show non-matching)
$ grep -r "error" /var/log/             # Recursive search
$ grep -c "error" logfile.txt           # Count matches

# Search with context
$ grep -A 3 "error" file.txt            # Show 3 lines after
$ grep -B 3 "error" file.txt            # Show 3 lines before
$ grep -C 3 "error" file.txt            # Show 3 lines before and after

# Multiple patterns
$ grep -e "error" -e "warning" file.txt
```

---

# Users and Permissions

## Understanding Permissions

```bash
# Permission format: -rwxr-xr-x
# - = file type (- file, d directory, l link)
# rwx = owner permissions (read, write, execute)
# r-x = group permissions (read, no write, execute)
# r-x = others permissions (read, no write, execute)

# Permission values:
# r (read)    = 4
# w (write)   = 2
# x (execute) = 1

# Common permission patterns:
# 755 = rwxr-xr-x  (owner: all, group/others: read+execute)
# 644 = rw-r--r--  (owner: read+write, group/others: read)
# 700 = rwx------  (owner: all, group/others: none)
# 777 = rwxrwxrwx  (everyone: all - DANGEROUS!)
```

---

## Permission Commands

```bash
# Change permissions (numbers)
$ chmod 755 script.sh              # rwxr-xr-x
$ chmod 644 file.txt               # rw-r--r--
$ chmod 600 secret.txt             # rw-------

# Change permissions (letters)
$ chmod u+x script.sh              # Add execute for user
$ chmod g-w file.txt               # Remove write for group
$ chmod o-r file.txt               # Remove read for others
$ chmod a+x script.sh              # Add execute for all

# Change ownership
$ sudo chown user:group file.txt   # Change owner and group
$ sudo chown user file.txt         # Change owner only
$ sudo chgrp group file.txt        # Change group only
$ sudo chown -R user:group dir/    # Recursive

# View user information
$ id                               # Current user info
$ groups                           # Groups you belong to
$ whoami                           # Current username
```

---

# Text Processing

## Working with Text

```bash
# Word count
$ wc file.txt                      # Lines, words, characters
$ wc -l file.txt                   # Lines only
$ wc -w file.txt                   # Words only
$ wc -c file.txt                   # Characters only

# Sort lines
$ sort file.txt                    # Alphabetically
$ sort -r file.txt                 # Reverse
$ sort -n numbers.txt              # Numeric sort
$ sort -u file.txt                 # Unique lines only

# Remove duplicates
$ uniq file.txt                    # Remove consecutive duplicates
$ sort file.txt | uniq             # Remove all duplicates

# Cut columns
$ cut -d',' -f1 data.csv           # First column (comma-separated)
$ cut -d':' -f1,3 /etc/passwd      # Columns 1 and 3 (colon-separated)

# Replace text
$ sed 's/old/new/' file.txt        # Replace first occurrence per line
$ sed 's/old/new/g' file.txt       # Replace all occurrences
$ sed 's/old/new/gi' file.txt      # Case-insensitive replace

# Extract fields
$ awk '{print $1}' file.txt        # Print first field
$ awk -F',' '{print $1,$3}' data.csv  # Fields 1 and 3 (CSV)
```

---

## Piping and Redirection

```bash
# Output redirection
$ echo "Hello" > file.txt          # Overwrite file
$ echo "World" >> file.txt         # Append to file

# Input redirection
$ wc -l < file.txt                 # Read from file

# Piping (send output to next command)
$ ls -l | grep ".txt"              # List only .txt files
$ cat file.txt | sort | uniq       # Sort and remove duplicates
$ ps aux | grep nginx              # Find nginx processes

# Redirect errors
$ command 2> error.log             # Redirect errors to file
$ command > output.log 2>&1        # Redirect output and errors
$ command &> all.log               # Redirect both (shorthand)

# Discard output
$ command > /dev/null              # Discard output
$ command 2> /dev/null             # Discard errors
$ command &> /dev/null             # Discard everything
```

---

# Bash Scripting Fundamentals

## Creating Your First Script

```bash
#!/bin/bash
# This is a comment - lines starting with # are ignored
# The first line (shebang) tells the system to use bash

# Print to screen
echo "Hello, World!"
echo "This is my first bash script"

# Variables
NAME="John"
echo "Hello, $NAME"

# Run commands
DATE=$(date)
echo "Current date: $DATE"
```

**Save as:** `first_script.sh`

**Make executable:**
```bash
$ chmod +x first_script.sh
```

**Run:**
```bash
$ ./first_script.sh
Hello, World!
This is my first bash script
Hello, John
Current date: Mon Dec 16 10:30:45 UTC 2024
```

---

## Script Structure Best Practices

```bash
#!/bin/bash

################################################################################
# Script Name: example.sh
# Description: This script demonstrates proper structure
# Author: Your Name
# Date: 2024-12-16
# Version: 1.0
################################################################################

# Exit on error (stop if any command fails)
set -e

# Exit on undefined variable
set -u

# Global variables (UPPERCASE by convention)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="/var/log/myscript.log"
VERSION="1.0"

# Constants (readonly)
readonly MAX_RETRIES=3
readonly TIMEOUT=30

# Functions (define before using)
main() {
    echo "Starting script..."
    # Your main code here
    echo "Script completed successfully"
}

# Run main function
main "$@"

# Exit with success
exit 0
```

---

# Variables

## Defining and Using Variables

```bash
#!/bin/bash

# Simple variables (no spaces around =)
NAME="John Doe"
AGE=25
CITY="Lagos"

# Use variables with $
echo "Name: $NAME"
echo "Age: $AGE"
echo "City: $CITY"

# Better: Use ${} for clarity
echo "Hello, ${NAME}!"
echo "Age: ${AGE} years"

# Command substitution (store command output)
CURRENT_DATE=$(date +%Y-%m-%d)
CURRENT_TIME=$(date +%H:%M:%S)
USER=$(whoami)
HOSTNAME=$(hostname)

echo "Date: $CURRENT_DATE"
echo "Time: $CURRENT_TIME"
echo "User: $USER"
echo "Host: $HOSTNAME"

# Arithmetic (numbers only)
NUM1=10
NUM2=5
SUM=$((NUM1 + NUM2))
DIFF=$((NUM1 - NUM2))
PRODUCT=$((NUM1 * NUM2))
QUOTIENT=$((NUM1 / NUM2))

echo "$NUM1 + $NUM2 = $SUM"
echo "$NUM1 - $NUM2 = $DIFF"
echo "$NUM1 * $NUM2 = $PRODUCT"
echo "$NUM1 / $NUM2 = $QUOTIENT"

# Environment variables (system-wide)
echo "Home directory: $HOME"
echo "Current path: $PATH"
echo "Current user: $USER"
echo "Shell: $SHELL"

# Export variable (make available to child processes)
export MY_VAR="Available everywhere"

# Readonly variable (cannot be changed)
readonly PI=3.14159
# PI=3.14  # This would cause an error

# Unset variable (delete it)
TEMP="temporary"
unset TEMP
```

---

## Special Variables

```bash
#!/bin/bash

# Script demonstrates special variables

# $0 = Script name
echo "Script name: $0"

# $1, $2, $3... = Arguments
echo "First argument: $1"
echo "Second argument: $2"
echo "Third argument: $3"

# $@ = All arguments (as separate words)
echo "All arguments: $@"

# $# = Number of arguments
echo "Number of arguments: $#"

# $? = Exit status of last command
ls /existing/path
echo "Exit status: $?"  # 0 (success)

ls /nonexistent/path 2>/dev/null
echo "Exit status: $?"  # non-zero (failure)

# $$ = Current process ID
echo "Process ID: $$"

# $! = Last background process ID
sleep 10 &
echo "Background process ID: $!"

# Example usage:
# $ ./script.sh arg1 arg2 arg3
# Script name: ./script.sh
# First argument: arg1
# Second argument: arg2
# Third argument: arg3
# All arguments: arg1 arg2 arg3
# Number of arguments: 3
```

---

## Variable Manipulation

```bash
#!/bin/bash

# Default values
NAME=${USERNAME:-"Guest"}        # Use Guest if USERNAME is empty
echo "Welcome, $NAME"

# String length
TEXT="Hello World"
echo "Length: ${#TEXT}"          # 11

# Substring
STRING="Hello World"
echo "${STRING:0:5}"             # Hello (start at 0, length 5)
echo "${STRING:6}"               # World (start at 6, to end)

# Replace text
TEXT="Hello World"
echo "${TEXT/World/Bash}"        # Hello Bash (replace first)
echo "${TEXT//o/0}"              # Hell0 W0rld (replace all)

# Convert case
LOWER="hello world"
UPPER="HELLO WORLD"
echo "${LOWER^^}"                # HELLO WORLD (to uppercase)
echo "${UPPER,,}"                # hello world (to lowercase)

# Remove prefix/suffix
FILENAME="document.txt"
echo "${FILENAME%.txt}"          # document (remove suffix)
echo "${FILENAME#doc}"           # ument.txt (remove prefix)

PATH="/home/user/documents/file.txt"
echo "${PATH##*/}"               # file.txt (basename)
echo "${PATH%/*}"                # /home/user/documents (dirname)
```

---

# User Input

## Reading Input

```bash
#!/bin/bash

# Basic input
echo "What is your name?"
read NAME
echo "Hello, $NAME!"

# Input with prompt (better)
read -p "Enter your name: " NAME
echo "Hello, $NAME!"

# Multiple inputs
read -p "Enter first and last name: " FIRST LAST
echo "First: $FIRST"
echo "Last: $LAST"

# Silent input (for passwords)
read -sp "Enter password: " PASSWORD
echo ""  # New line (since -s doesn't add one)
echo "Password saved!"

# Read with timeout
read -t 5 -p "Quick! Enter your name (5 seconds): " NAME
if [ -z "$NAME" ]; then
    echo "Too slow! Using default."
    NAME="Guest"
fi
echo "Hello, $NAME"

# Read single character
read -n 1 -p "Press Y to continue: " ANSWER
echo ""
if [ "$ANSWER" == "Y" ]; then
    echo "Continuing..."
else
    echo "Cancelled"
fi

# Read from file
while read LINE; do
    echo "Line: $LINE"
done < input.txt

# Read with default value
read -p "Enter your name [Guest]: " NAME
NAME=${NAME:-Guest}
echo "Hello, $NAME"
```

---

## Input Validation

```bash
#!/bin/bash

# Validate non-empty input
while true; do
    read -p "Enter your name: " NAME
    if [ -z "$NAME" ]; then
        echo "Name cannot be empty! Try again."
    else
        break
    fi
done

# Validate number
while true; do
    read -p "Enter your age: " AGE
    if [[ "$AGE" =~ ^[0-9]+$ ]]; then
        break
    else
        echo "Please enter a valid number!"
    fi
done

# Validate yes/no
while true; do
    read -p "Continue? (y/n): " ANSWER
    case $ANSWER in
        [Yy]* ) echo "Continuing..."; break;;
        [Nn]* ) echo "Cancelled"; exit;;
        * ) echo "Please answer y or n";;
    esac
done

# Validate email format
while true; do
    read -p "Enter email: " EMAIL
    if [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "Valid email!"
        break
    else
        echo "Invalid email format!"
    fi
done
```

---

# Conditional Statements

## If-Then-Else

```bash
#!/bin/bash

# Basic if statement
if [ condition ]; then
    # commands if true
fi

# If-else
if [ condition ]; then
    # commands if true
else
    # commands if false
fi

# If-elif-else
if [ condition1 ]; then
    # commands if condition1 true
elif [ condition2 ]; then
    # commands if condition2 true
elif [ condition3 ]; then
    # commands if condition3 true
else
    # commands if all false
fi
```

---

## Numeric Comparisons

```bash
#!/bin/bash

NUM1=10
NUM2=20

# Equal
if [ $NUM1 -eq $NUM2 ]; then
    echo "Equal"
fi

# Not equal
if [ $NUM1 -ne $NUM2 ]; then
    echo "Not equal"
fi

# Greater than
if [ $NUM1 -gt $NUM2 ]; then
    echo "$NUM1 is greater than $NUM2"
fi

# Greater than or equal
if [ $NUM1 -ge $NUM2 ]; then
    echo "$NUM1 is greater than or equal to $NUM2"
fi

# Less than
if [ $NUM1 -lt $NUM2 ]; then
    echo "$NUM1 is less than $NUM2"
fi

# Less than or equal
if [ $NUM1 -le $NUM2 ]; then
    echo "$NUM1 is less than or equal to $NUM2"
fi

# Practical example: Grade checker
read -p "Enter your score: " SCORE

if [ $SCORE -ge 90 ]; then
    echo "Grade: A (Excellent!)"
elif [ $SCORE -ge 80 ]; then
    echo "Grade: B (Good job!)"
elif [ $SCORE -ge 70 ]; then
    echo "Grade: C (Satisfactory)"
elif [ $SCORE -ge 60 ]; then
    echo "Grade: D (Needs improvement)"
else
    echo "Grade: F (Failed)"
fi
```

---

## String Comparisons

```bash
#!/bin/bash

STRING1="hello"
STRING2="world"

# Equal
if [ "$STRING1" == "$STRING2" ]; then
    echo "Strings are equal"
fi

# Not equal
if [ "$STRING1" != "$STRING2" ]; then
    echo "Strings are not equal"
fi

# Empty string
if [ -z "$STRING1" ]; then
    echo "String is empty"
fi

# Not empty
if [ -n "$STRING1" ]; then
    echo "String is not empty"
fi

# Practical example: Password checker
read -sp "Enter password: " PASSWORD
echo ""

if [ -z "$PASSWORD" ]; then
    echo "Password cannot be empty!"
elif [ ${#PASSWORD} -lt 8 ]; then
    echo "Password too short! Minimum 8 characters."
elif [ "$PASSWORD" == "password123" ]; then
    echo "Password too weak! Don't use common passwords."
else
    echo "Password accepted!"
fi
```

---

## File Testing

```bash
#!/bin/bash

FILE="test.txt"
DIR="mydir"

# File exists
if [ -e "$FILE" ]; then
    echo "File exists"
fi

# Regular file (not directory)
if [ -f "$FILE" ]; then
    echo "Is a regular file"
fi

# Directory exists
if [ -d "$DIR" ]; then
    echo "Directory exists"
fi

# File is readable
if [ -r "$FILE" ]; then
    echo "File is readable"
fi

# File is writable
if [ -w "$FILE" ]; then
    echo "File is writable"
fi

# File is executable
if [ -x "$FILE" ]; then
    echo "File is executable"
fi

# File is not empty
if [ -s "$FILE" ]; then
    echo "File is not empty"
fi

# Symbolic link
if [ -L "$FILE" ]; then
    echo "Is a symbolic link"
fi

# Practical example: Backup script
BACKUP_DIR="/backup"
SOURCE_FILE="important.txt"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file not found!"
    exit 1
fi

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Creating backup directory..."
    mkdir -p "$BACKUP_DIR"
fi

if [ -w "$BACKUP_DIR" ]; then
    cp "$SOURCE_FILE" "$BACKUP_DIR/"
    echo "Backup completed!"
else
    echo "Error: Cannot write to backup directory!"
    exit 1
fi
```

---

## Logical Operators

```bash
#!/bin/bash

AGE=25
NAME="John"

# AND (&&)
if [ $AGE -ge 18 ] && [ -n "$NAME" ]; then
    echo "Adult with a name"
fi

# OR (||)
if [ $AGE -lt 18 ] || [ $AGE -gt 65 ]; then
    echo "Child or senior"
fi

# NOT (!)
if [ ! -f "file.txt" ]; then
    echo "File does not exist"
fi

# Multiple conditions
if [ $AGE -ge 18 ] && [ $AGE -le 65 ] && [ -n "$NAME" ]; then
    echo "Working age adult with name"
fi

# Using -a (AND) and -o (OR) inside single brackets
if [ $AGE -ge 18 -a $AGE -le 65 ]; then
    echo "Working age"
fi

# Practical example: User eligibility
read -p "Enter age: " AGE
read -p "Enter country: " COUNTRY
read -p "Have ID? (yes/no): " HAS_ID

if [ $AGE -ge 18 ] && [ "$COUNTRY" == "NG" ] && [ "$HAS_ID" == "yes" ]; then
    echo "✓ Eligible to vote!"
else
    echo "✗ Not eligible to vote"
    
    if [ $AGE -lt 18 ]; then
        echo "  Reason: Too young (must be 18+)"
    fi
    
    if [ "$COUNTRY" != "NG" ]; then
        echo "  Reason: Not a Nigerian citizen"
    fi
    
    if [ "$HAS_ID" != "yes" ]; then
        echo "  Reason: No valid ID"
    fi
fi
```

---

## Case Statements

```bash
#!/bin/bash

# Basic case statement
read -p "Enter choice (1-3): " CHOICE

case $CHOICE in
    1)
        echo "You chose option 1"
        ;;
    2)
        echo "You chose option 2"
        ;;
    3)
        echo "You chose option 3"
        ;;
    *)
        echo "Invalid choice"
        ;;
esac

# Multiple patterns
read -p "Enter day of week: " DAY

case $DAY in
    Monday|Mon|monday|mon)
        echo "Start of work week"
        ;;
    Friday|Fri|friday|fri)
        echo "End of work week"
        ;;
    Saturday|Sunday|Sat|Sun)
        echo "Weekend!"
        ;;
    *)
        echo "Midweek day"
        ;;
esac

# Pattern matching
read -p "Enter filename: " FILE

case $FILE in
    *.txt)
        echo "Text file"
        ;;
    *.jpg|*.png|*.gif)
        echo "Image file"
        ;;
    *.sh)
        echo "Shell script"
        ;;
    *.tar.gz|*.zip)
        echo "Archive file"
        ;;
    *)
        echo "Unknown file type"
        ;;
esac

# Practical example: Menu system
while true; do
    echo ""
    echo "===== Main Menu ====="
    echo "1) Start service"
    echo "2) Stop service"
    echo "3) Restart service"
    echo "4) Check status"
    echo "5) Exit"
    echo "===================="
    read -p "Enter choice: " CHOICE
    
    case $CHOICE in
        1)
            echo "Starting service..."
            # service start command here
            ;;
        2)
            echo "Stopping service..."
            # service stop command here
            ;;
        3)
            echo "Restarting service..."
            # service restart command here
            ;;
        4)
            echo "Checking status..."
            # service status command here
            ;;
        5)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice! Please enter 1-5"
            ;;
    esac
done
```

---

# Loops

## For Loop

```bash
#!/bin/bash

# Loop through list
for NAME in John Sarah Mike Lisa; do
    echo "Hello, $NAME"
done

# Loop through numbers
for i in 1 2 3 4 5; do
    echo "Number: $i"
done

# Loop through range
for i in {1..10}; do
    echo "Count: $i"
done

# Loop with step
for i in {0..20..2}; do
    echo "Even number: $i"
done

# Loop through files
for FILE in *.txt; do
    echo "Processing: $FILE"
done

# C-style for loop
for ((i=1; i<=10; i++)); do
    echo "Iteration: $i"
done

# Loop through command output
for USER in $(cat users.txt); do
    echo "User: $USER"
done

# Loop through array
FRUITS=("Apple" "Banana" "Cherry")
for FRUIT in "${FRUITS[@]}"; do
    echo "Fruit: $FRUIT"
done

# Practical example: Backup multiple files
FILES=("config.txt" "data.csv" "settings.json")
BACKUP_DIR="/backup"

mkdir -p "$BACKUP_DIR"

for FILE in "${FILES[@]}"; do
    if [ -f "$FILE" ]; then
        cp "$FILE" "$BACKUP_DIR/"
        echo "✓ Backed up: $FILE"
    else
        echo "✗ Not found: $FILE"
    fi
done

# Nested loops
for i in {1..3}; do
    for j in {1..3}; do
        echo "i=$i, j=$j"
    done
done
```

---

## While Loop

```bash
#!/bin/bash

# Basic while loop
COUNT=1
while [ $COUNT -le 5 ]; do
    echo "Count: $COUNT"
    COUNT=$((COUNT + 1))
done

# Infinite loop (use with break)
while true; do
    read -p "Enter command (exit to quit): " CMD
    
    if [ "$CMD" == "exit" ]; then
        break
    fi
    
    echo "You entered: $CMD"
done

# Read file line by line
while IFS= read -r LINE; do
    echo "Line: $LINE"
done < input.txt

# While with counter
COUNTER=10
while [ $COUNTER -gt 0 ]; do
    echo "Countdown: $COUNTER"
    COUNTER=$((COUNTER - 1))
    sleep 1
done
echo "Blast off!"

# Practical example: Retry mechanism
MAX_RETRIES=3
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    echo "Attempting connection... (Attempt $((RETRY_COUNT + 1))/$MAX_RETRIES)"
    
    # Simulated connection attempt
    if ping -c 1 google.com &> /dev/null; then
        echo "✓ Connection successful!"
        break
    else
        echo "✗ Connection failed"
        RETRY_COUNT=$((RETRY_COUNT + 1))
        
        if [ $RETRY_COUNT -lt $MAX_RETRIES ]; then
            echo "Retrying in 3 seconds..."
            sleep 3
        fi
    fi
done

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
    echo "Failed after $MAX_RETRIES attempts"
    exit 1
fi

# Menu with while loop
while true; do
    echo ""
    echo "1) Option 1"
    echo "2) Option 2"
    echo "3) Exit"
    read -p "Choice: " CHOICE
    
    case $CHOICE in
        1) echo "Selected option 1";;
        2) echo "Selected option 2";;
        3) echo "Goodbye!"; break;;
        *) echo "Invalid choice";;
    esac
done
```

---

## Until Loop

```bash
#!/bin/bash

# Basic until loop (opposite of while)
COUNT=1
until [ $COUNT -gt 5 ]; do
    echo "Count: $COUNT"
    COUNT=$((COUNT + 1))
done

# Wait until file exists
until [ -f "ready.txt" ]; do
    echo "Waiting for ready.txt..."
    sleep 2
done
echo "File found!"

# Practical example: Wait for service
until systemctl is-active --quiet nginx; do
    echo "Waiting for nginx to start..."
    sleep 5
done
echo "Nginx is running!"
```

---

## Loop Control

```bash
#!/bin/bash

# break - Exit loop immediately
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        echo "Breaking at $i"
        break
    fi
    echo "Number: $i"
done

# continue - Skip to next iteration
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        echo "Skipping $i"
        continue
    fi
    echo "Number: $i"
done

# Practical example: Process files, skip errors
for FILE in *.txt; do
    if [ ! -r "$FILE" ]; then
        echo "Cannot read $FILE, skipping..."
        continue
    fi
    
    if grep -q "ERROR" "$FILE"; then
        echo "ERROR found in $FILE, stopping..."
        break
    fi
    
    echo "Processing $FILE..."
    # Process file here
done
```

---

# Functions

## Defining Functions

```bash
#!/bin/bash

# Method 1: Using function keyword
function greet {
    echo "Hello, World!"
}

# Method 2: Without function keyword (more common)
greet() {
    echo "Hello, World!"
}

# Method 3: One-liner
greet() { echo "Hello, World!"; }

# Call function
greet
```

---

## Functions with Arguments

```bash
#!/bin/bash

# Function with one argument
greet() {
    echo "Hello, $1!"
}

greet "John"      # Hello, John!
greet "Sarah"     # Hello, Sarah!

# Function with multiple arguments
introduce() {
    local NAME=$1
    local AGE=$2
    local CITY=$3
    
    echo "Name: $NAME"
    echo "Age: $AGE"
    echo "City: $CITY"
}

introduce "John" "25" "Lagos"

# Function with default values
greet_user() {
    local NAME=${1:-"Guest"}
    local GREETING=${2:-"Hello"}
    
    echo "$GREETING, $NAME!"
}

greet_user                        # Hello, Guest!
greet_user "John"                 # Hello, John!
greet_user "Sarah" "Hi"          # Hi, Sarah!

# Check number of arguments
create_user() {
    if [ $# -lt 2 ]; then
        echo "Usage: create_user <username> <email>"
        return 1
    fi
    
    local USERNAME=$1
    local EMAIL=$2
    
    echo "Creating user: $USERNAME"
    echo "Email: $EMAIL"
}

create_user                       # Shows usage
create_user "john" "john@example.com"  # Creates user
```

---

## Local vs Global Variables

```bash
#!/bin/bash

# Global variable
GLOBAL_VAR="I am global"

test_scope() {
    # Local variable (only in function)
    local LOCAL_VAR="I am local"
    
    echo "Inside function:"
    echo "  Global: $GLOBAL_VAR"
    echo "  Local: $LOCAL_VAR"
    
    # Modify global
    GLOBAL_VAR="Modified by function"
}

echo "Before function:"
echo "  Global: $GLOBAL_VAR"
# echo "  Local: $LOCAL_VAR"  # Would be empty

test_scope

echo "After function:"
echo "  Global: $GLOBAL_VAR"  # Changed!
# echo "  Local: $LOCAL_VAR"   # Still empty (doesn't exist outside)

# Best practice: ALWAYS use local in functions
calculate() {
    local NUM1=$1
    local NUM2=$2
    local RESULT=$((NUM1 + NUM2))
    
    echo $RESULT
}

SUM=$(calculate 10 20)
echo "Sum: $SUM"
```

---

## Return Values

```bash
#!/bin/bash

# Return exit status (0-255)
is_even() {
    local NUM=$1
    
    if [ $((NUM % 2)) -eq 0 ]; then
        return 0  # Success (even)
    else
        return 1  # Failure (odd)
    fi
}

is_even 4
if [ $? -eq 0 ]; then
    echo "4 is even"
fi

is_even 5
if [ $? -eq 0 ]; then
    echo "5 is even"
else
    echo "5 is odd"
fi

# "Return" values using echo
add() {
    local NUM1=$1
    local NUM2=$2
    local RESULT=$((NUM1 + NUM2))
    
    echo $RESULT  # "Return" by echoing
}

SUM=$(add 10 20)  # Capture output
echo "10 + 20 = $SUM"

# Return multiple values
get_user_info() {
    echo "John Doe"
    echo "25"
    echo "Lagos"
}

# Capture into array
read -r NAME AGE CITY <<< "$(get_user_info)"
echo "Name: $NAME"
echo "Age: $AGE"
echo "City: $CITY"
```

---

## Practical Function Examples

```bash
#!/bin/bash

# Function library

# Check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Usage
if command_exists "git"; then
    echo "Git is installed"
else
    echo "Git is not installed"
fi

# Print colored message
print_success() {
    local GREEN='\033[0;32m'
    local NC='\033[0m'
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    local RED='\033[0;31m'
    local NC='\033[0m'
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    local YELLOW='\033[1;33m'
    local NC='\033[0m'
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Usage
print_success "Operation completed!"
print_error "Something went wrong!"
print_warning "Please check configuration"

# File backup function
backup_file() {
    local SOURCE=$1
    local DEST_DIR=${2:-"./backups"}
    
    if [ ! -f "$SOURCE" ]; then
        print_error "File not found: $SOURCE"
        return 1
    fi
    
    mkdir -p "$DEST_DIR"
    
    local TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    local BASENAME=$(basename "$SOURCE")
    local BACKUP_NAME="${BASENAME}.${TIMESTAMP}.backup"
    
    cp "$SOURCE" "$DEST_DIR/$BACKUP_NAME"
    
    if [ $? -eq 0 ]; then
        print_success "Backup created: $BACKUP_NAME"
        return 0
    else
        print_error "Backup failed"
        return 1
    fi
}

# Usage
backup_file "important.txt"
backup_file "config.json" "/var/backups"

# Validate email
validate_email() {
    local EMAIL=$1
    local REGEX="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    
    if [[ "$EMAIL" =~ $REGEX ]]; then
        return 0
    else
        return 1
    fi
}

# Usage
if validate_email "user@example.com"; then
    echo "Valid email"
else
    echo "Invalid email"
fi

# Get file size in human readable format
get_file_size() {
    local FILE=$1
    
    if [ ! -f "$FILE" ]; then
        echo "File not found"
        return 1
    fi
    
    du -h "$FILE" | cut -f1
}

# Usage
SIZE=$(get_file_size "large_file.dat")
echo "File size: $SIZE"
```

---

# Arrays

## Creating and Using Arrays

```bash
#!/bin/bash

# Create array
FRUITS=("Apple" "Banana" "Cherry" "Date")

# Access elements (0-indexed)
echo "${FRUITS[0]}"      # Apple
echo "${FRUITS[1]}"      # Banana

# All elements
echo "${FRUITS[@]}"      # Apple Banana Cherry Date

# Number of elements
echo "${#FRUITS[@]}"     # 4

# Add element
FRUITS+=("Elderberry")
echo "${FRUITS[@]}"      # Apple Banana Cherry Date Elderberry

# Modify element
FRUITS[1]="Blueberry"
echo "${FRUITS[@]}"      # Apple Blueberry Cherry Date Elderberry

# Remove element (unset)
unset FRUITS[2]
echo "${FRUITS[@]}"      # Apple Blueberry Date Elderberry

# Get array indices
echo "${!FRUITS[@]}"     # 0 1 3 4 (notice 2 is missing)

# Loop through array
for FRUIT in "${FRUITS[@]}"; do
    echo "Fruit: $FRUIT"
done

# Loop with index
for i in "${!FRUITS[@]}"; do
    echo "Index $i: ${FRUITS[$i]}"
done

# Slice array
echo "${FRUITS[@]:1:2}"  # Start at index 1, get 2 elements
```

---

## Associative Arrays (Bash 4+)

```bash
#!/bin/bash

# Declare associative array
declare -A AGES

# Add elements
AGES["John"]=25
AGES["Sarah"]=30
AGES["Mike"]=28

# Access elements
echo "${AGES[John]}"     # 25

# All keys
echo "${!AGES[@]}"       # John Sarah Mike

# All values
echo "${AGES[@]}"        # 25 30 28

# Loop through
for NAME in "${!AGES[@]}"; do
    echo "$NAME is ${AGES[$NAME]} years old"
done

# Check if key exists
if [ -n "${AGES[John]}" ]; then
    echo "John's age is known"
fi

# Practical example: Configuration
declare -A CONFIG
CONFIG["host"]="localhost"
CONFIG["port"]="8080"
CONFIG["database"]="mydb"
CONFIG["user"]="admin"

echo "Connecting to ${CONFIG[host]}:${CONFIG[port]}"
echo "Database: ${CONFIG[database]}"
echo "User: ${CONFIG[user]}"
```

---

## Array Practical Examples

```bash
#!/bin/bash

# Process list of servers
SERVERS=("web-01" "web-02" "db-01" "cache-01")

echo "Checking servers..."
for SERVER in "${SERVERS[@]}"; do
    echo -n "Pinging $SERVER... "
    
    if ping -c 1 -W 1 "$SERVER" &> /dev/null; then
        echo "✓ UP"
    else
        echo "✗ DOWN"
    fi
done

# Store command output in array
readarray -t FILES < <(ls *.txt)

echo "Found ${#FILES[@]} text files:"
for FILE in "${FILES[@]}"; do
    echo "  - $FILE"
done

# Student grades
STUDENTS=("John" "Sarah" "Mike" "Lisa")
GRADES=(85 92 78 88)

echo "Student Grades:"
for i in "${!STUDENTS[@]}"; do
    STUDENT="${STUDENTS[$i]}"
    GRADE="${GRADES[$i]}"
    
    echo "$STUDENT: $GRADE"
    
    if [ $GRADE -ge 90 ]; then
        echo "  Status: Excellent"
    elif [ $GRADE -ge 80 ]; then
        echo "  Status: Good"
    elif [ $GRADE -ge 70 ]; then
        echo "  Status: Satisfactory"
    else
        echo "  Status: Needs improvement"
    fi
done
```

---

# String Manipulation

## String Operations

```bash
#!/bin/bash

TEXT="Hello World"

# Length
echo "${#TEXT}"              # 11

# Substring
echo "${TEXT:0:5}"           # Hello
echo "${TEXT:6}"             # World
echo "${TEXT:6:5}"           # World
echo "${TEXT: -5}"           # World (last 5 chars)

# Replace
echo "${TEXT/World/Bash}"    # Hello Bash (first occurrence)
echo "${TEXT//o/0}"          # Hell0 W0rld (all occurrences)

# Remove from start
echo "${TEXT#Hello }"        # World
echo "${TEXT##*/}"           # Remove everything up to last /

# Remove from end
echo "${TEXT% World}"        # Hello
echo "${TEXT%%/*}"           # Remove everything from first /

# Uppercase/Lowercase
LOWER="hello world"
UPPER="HELLO WORLD"

echo "${LOWER^^}"            # HELLO WORLD (all uppercase)
echo "${UPPER,,}"            # hello world (all lowercase)
echo "${LOWER^}"             # Hello world (first char uppercase)

# Check if string contains substring
if [[ "$TEXT" == *"World"* ]]; then
    echo "Contains 'World'"
fi

# String concatenation
FIRST="Hello"
LAST="World"
FULL="$FIRST $LAST"
echo "$FULL"                 # Hello World

# Split string into array
IFS=',' read -ra PARTS <<< "apple,banana,cherry"
for PART in "${PARTS[@]}"; do
    echo "$PART"
done
```

---

## Pattern Matching

```bash
#!/bin/bash

# Wildcard matching
FILE="document.txt"

if [[ "$FILE" == *.txt ]]; then
    echo "Text file"
fi

# Multiple patterns
case "$FILE" in
    *.txt|*.doc|*.pdf)
        echo "Document file"
        ;;
    *.jpg|*.png|*.gif)
        echo "Image file"
        ;;
    *)
        echo "Other file"
        ;;
esac

# Regular expression matching
EMAIL="user@example.com"

if [[ "$EMAIL" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Valid email"
else
    echo "Invalid email"
fi

# Extract parts with regex
IP="192.168.1.100"
if [[ "$IP" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
    echo "First octet: ${BASH_REMATCH[1]}"
    echo "Second octet: ${BASH_REMATCH[2]}"
    echo "Third octet: ${BASH_REMATCH[3]}"
    echo "Fourth octet: ${BASH_REMATCH[4]}"
fi
```

---

# File Testing

## Complete File Test Reference

```bash
#!/bin/bash

FILE="test.txt"
DIR="mydir"

# Existence tests
[ -e "$FILE" ]    # Exists (file or directory)
[ -f "$FILE" ]    # Regular file (not directory)
[ -d "$DIR" ]     # Directory
[ -L "$FILE" ]    # Symbolic link
[ -S "$FILE" ]    # Socket
[ -p "$FILE" ]    # Named pipe
[ -b "$FILE" ]    # Block device
[ -c "$FILE" ]    # Character device

# Permission tests
[ -r "$FILE" ]    # Readable
[ -w "$FILE" ]    # Writable
[ -x "$FILE" ]    # Executable
[ -u "$FILE" ]    # SUID bit set
[ -g "$FILE" ]    # SGID bit set
[ -k "$FILE" ]    # Sticky bit set

# Size tests
[ -s "$FILE" ]    # Not empty (size > 0)

# Ownership tests
[ -O "$FILE" ]    # Owned by effective UID
[ -G "$FILE" ]    # Owned by effective GID

# Comparison tests
[ file1 -nt file2 ]  # file1 newer than file2
[ file1 -ot file2 ]  # file1 older than file2
[ file1 -ef file2 ]  # file1 and file2 are same file (hard links)

# Practical examples
if [ -f "config.txt" ]; then
    echo "Config file exists"
    
    if [ -r "config.txt" ]; then
        echo "Config is readable"
        source config.txt
    else
        echo "Cannot read config!"
        exit 1
    fi
else
    echo "Config file not found!"
    exit 1
fi

# Check before operations
if [ ! -d "backup" ]; then
    mkdir backup
fi

if [ -s "data.txt" ]; then
    echo "Data file has content"
    wc -l data.txt
else
    echo "Data file is empty"
fi
```

---

# Error Handling

## Exit Codes

```bash
#!/bin/bash

# Exit codes: 0 = success, 1-255 = error

# Check last command status
ls /existing/path
if [ $? -eq 0 ]; then
    echo "Success"
else
    echo "Failed"
fi

# Exit with specific code
exit 0    # Success
exit 1    # Generic error
exit 2    # Misuse of shell command
exit 127  # Command not found
exit 130  # Script terminated by Ctrl+C

# Set exit on error
set -e    # Exit immediately if any command fails

# Example:
#!/bin/bash
set -e

mkdir /tmp/mydir
cd /tmp/mydir
touch file.txt
# If any command fails, script exits
```

---

## Error Messages

```bash
#!/bin/bash

# Print to stderr
echo "Error message" >&2

# Better error function
error_exit() {
    echo "ERROR: $1" >&2
    exit 1
}

# Usage
if [ ! -f "required_file.txt" ]; then
    error_exit "required_file.txt not found"
fi

# Warning function
warning() {
    echo "WARNING: $1" >&2
}

# Usage
if [ $DISK_USAGE -gt 80 ]; then
    warning "Disk usage is ${DISK_USAGE}%"
fi
```

---

## Try-Catch Pattern

```bash
#!/bin/bash

# Error handling with trap
trap 'echo "Error on line $LINENO"' ERR

# Cleanup on exit
cleanup() {
    echo "Cleaning up..."
    rm -f /tmp/tempfile
}
trap cleanup EXIT

# Practical example
#!/bin/bash

set -e  # Exit on error

# Cleanup function
cleanup() {
    echo "Performing cleanup..."
    rm -f /tmp/lockfile
    echo "Cleanup complete"
}

# Set trap
trap cleanup EXIT ERR INT TERM

# Main script
echo "Starting process..."
touch /tmp/lockfile

# Your code here
if [ -f "important.txt" ]; then
    echo "Processing file..."
    # Process file
else
    echo "File not found!"
    exit 1
fi

echo "Process complete"
# cleanup() runs automatically
```

---

## Validation and Error Checking

```bash
#!/bin/bash

# Validate arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <source> <destination>"
    exit 1
fi

SOURCE=$1
DEST=$2

# Validate source file
if [ ! -f "$SOURCE" ]; then
    echo "Error: Source file not found: $SOURCE"
    exit 1
fi

if [ ! -r "$SOURCE" ]; then
    echo "Error: Cannot read source file: $SOURCE"
    exit 1
fi

# Validate destination directory
DEST_DIR=$(dirname "$DEST")
if [ ! -d "$DEST_DIR" ]; then
    echo "Error: Destination directory does not exist: $DEST_DIR"
    exit 1
fi

if [ ! -w "$DEST_DIR" ]; then
    echo "Error: Cannot write to destination: $DEST_DIR"
    exit 1
fi

# Perform operation
cp "$SOURCE" "$DEST"
if [ $? -eq 0 ]; then
    echo "Success: File copied"
    exit 0
else
    echo "Error: Copy failed"
    exit 1
fi
```

---

# Practical Projects

## Project 1: System Information Script

```bash
#!/bin/bash

################################################################################
# System Information Reporter
# Displays comprehensive system information
################################################################################

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Functions
print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_section() {
    echo -e "${YELLOW}--- $1 ---${NC}"
}

# System Information
clear
print_header "SYSTEM INFORMATION REPORT"
echo ""

# Date and Time
print_section "Date and Time"
echo "Current Date: $(date '+%Y-%m-%d')"
echo "Current Time: $(date '+%H:%M:%S')"
echo "Uptime: $(uptime -p)"
echo ""

# System
print_section "System"
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo "Architecture: $(uname -m)"
echo "OS: $(lsb_release -d | cut -f2)"
echo ""

# CPU
print_section "CPU"
echo "Model: $(lscpu | grep 'Model name' | cut -d':' -f2 | xargs)"
echo "Cores: $(nproc)"
echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo ""

# Memory
print_section "Memory"
free -h | awk 'NR==2{printf "Total: %s\nUsed: %s (%s)\nFree: %s\n", $2, $3, int($3/$2 * 100) "%", $4}'
echo ""

# Disk
print_section "Disk Usage"
df -h / | awk 'NR==2{printf "Total: %s\nUsed: %s (%s)\nAvailable: %s\n", $2, $3, $5, $4}'
echo ""

# Network
print_section "Network"
echo "IP Address: $(hostname -I | awk '{print $1}')"
echo "Gateway: $(ip route | grep default | awk '{print $3}')"
echo ""

# Users
print_section "Logged In Users"
who | awk '{print $1}' | sort -u
echo ""

# Top Processes
print_section "Top 5 Processes (by CPU)"
ps aux --sort=-%cpu | head -6 | tail -5 | awk '{printf "%-20s %5s%%\n", $11, $3}'
echo ""

print_header "REPORT COMPLETE"
```

---

## Project 2: File Backup System

```bash
#!/bin/bash

################################################################################
# Automated Backup Script
# Backs up directories with compression and rotation
################################################################################

# Configuration
BACKUP_SOURCE="$HOME/Documents"
BACKUP_DEST="$HOME/backups"
MAX_BACKUPS=7
DATE=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$BACKUP_DEST/backup.log"

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Functions
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
    log_message "SUCCESS: $1"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
    log_message "ERROR: $1"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
    log_message "INFO: $1"
}

# Main Script
echo "=========================================="
echo "  Automated Backup System"
echo "=========================================="
echo ""

# Validate source
if [ ! -d "$BACKUP_SOURCE" ]; then
    print_error "Source directory not found: $BACKUP_SOURCE"
    exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DEST"

# Calculate source size
SOURCE_SIZE=$(du -sh "$BACKUP_SOURCE" | cut -f1)
print_info "Source: $BACKUP_SOURCE ($SOURCE_SIZE)"

# Create backup
BACKUP_NAME="backup_${DATE}.tar.gz"
BACKUP_PATH="$BACKUP_DEST/$BACKUP_NAME"

print_info "Creating backup..."

tar -czf "$BACKUP_PATH" -C "$(dirname "$BACKUP_SOURCE")" "$(basename "$BACKUP_SOURCE")" 2>/dev/null

if [ $? -eq 0 ]; then
    BACKUP_SIZE=$(du -sh "$BACKUP_PATH" | cut -f1)
    print_success "Backup created: $BACKUP_NAME ($BACKUP_SIZE)"
    
    # Generate checksum
    sha256sum "$BACKUP_PATH" > "${BACKUP_PATH}.sha256"
    print_success "Checksum generated"
    
    # Rotate old backups
    BACKUP_COUNT=$(ls -1 "$BACKUP_DEST"/backup_*.tar.gz 2>/dev/null | wc -l)
    
    if [ $BACKUP_COUNT -gt $MAX_BACKUPS ]; then
        print_info "Rotating old backups..."
        ls -1t "$BACKUP_DEST"/backup_*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | while read OLD_BACKUP; do
            rm -f "$OLD_BACKUP" "${OLD_BACKUP}.sha256"
            print_info "Deleted: $(basename "$OLD_BACKUP")"
        done
    fi
    
    # Summary
    echo ""
    echo "=========================================="
    echo "Backup Summary:"
    echo "  Source: $BACKUP_SOURCE"
    echo "  Backup: $BACKUP_NAME"
    echo "  Size: $BACKUP_SIZE"
    echo "  Location: $BACKUP_DEST"
    echo "  Total backups: $(ls -1 "$BACKUP_DEST"/backup_*.tar.gz | wc -l)"
    echo "=========================================="
    
    exit 0
else
    print_error "Backup failed!"
    exit 1
fi
```

---

## Project 3: User Management Script

```bash
#!/bin/bash

################################################################################
# User Management System
# Create, delete, and manage users
################################################################################

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

# Functions
create_user() {
    local USERNAME=$1
    local FULLNAME=$2
    
    echo "Creating user: $USERNAME"
    
    # Check if user exists
    if id "$USERNAME" &>/dev/null; then
        echo "Error: User already exists"
        return 1
    fi
    
    # Create user
    useradd -m -s /bin/bash -c "$FULLNAME" "$USERNAME"
    
    if [ $? -eq 0 ]; then
        echo "✓ User created successfully"
        
        # Set password
        echo "Setting password for $USERNAME"
        passwd "$USERNAME"
        
        # Show user info
        echo ""
        echo "User Information:"
        id "$USERNAME"
        
        return 0
    else
        echo "✗ Failed to create user"
        return 1
    fi
}

delete_user() {
    local USERNAME=$1
    
    # Check if user exists
    if ! id "$USERNAME" &>/dev/null; then
        echo "Error: User does not exist"
        return 1
    fi
    
    # Confirm deletion
    read -p "Delete user $USERNAME and home directory? (yes/no): " CONFIRM
    
    if [ "$CONFIRM" == "yes" ]; then
        userdel -r "$USERNAME"
        
        if [ $? -eq 0 ]; then
            echo "✓ User deleted successfully"
            return 0
        else
            echo "✗ Failed to delete user"
            return 1
        fi
    else
        echo "Cancelled"
        return 1
    fi
}

list_users() {
    echo "Regular Users:"
    echo "=============="
    awk -F: '$3 >= 1000 && $3 < 65534 {printf "%-15s %-30s %s\n", $1, $5, $6}' /etc/passwd
}

show_menu() {
    echo ""
    echo "=============================="
    echo "   User Management System"
    echo "=============================="
    echo "1) Create user"
    echo "2) Delete user"
    echo "3) List users"
    echo "4) Lock user"
    echo "5) Unlock user"
    echo "6) Exit"
    echo "=============================="
}

# Main loop
while true; do
    show_menu
    read -p "Enter choice: " CHOICE
    
    case $CHOICE in
        1)
            read -p "Enter username: " USERNAME
            read -p "Enter full name: " FULLNAME
            create_user "$USERNAME" "$FULLNAME"
            ;;
        2)
            read -p "Enter username to delete: " USERNAME
            delete_user "$USERNAME"
            ;;
        3)
            list_users
            ;;
        4)
            read -p "Enter username to lock: " USERNAME
            passwd -l "$USERNAME"
            echo "✓ User locked"
            ;;
        5)
            read -p "Enter username to unlock: " USERNAME
            passwd -u "$USERNAME"
            echo "✓ User unlocked"
            ;;
        6)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
    
    read -p "Press Enter to continue..."
done
```

---

## Project 4: Log Analyzer

```bash
#!/bin/bash

################################################################################
# Log Analyzer
# Analyzes system logs and generates reports
################################################################################

LOG_FILE="${1:-/var/log/syslog}"
REPORT_FILE="log_report_$(date +%Y%m%d_%H%M%S).txt"

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file not found: $LOG_FILE"
    exit 1
fi

# Check if readable
if [ ! -r "$LOG_FILE" ]; then
    echo "Error: Cannot read log file (try with sudo)"
    exit 1
fi

echo "Analyzing log file: $LOG_FILE"
echo ""

# Generate report
{
    echo "========================================"
    echo "LOG ANALYSIS REPORT"
    echo "Generated: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Log file: $LOG_FILE"
    echo "========================================"
    echo ""
    
    # File info
    echo "--- File Information ---"
    echo "Size: $(du -h "$LOG_FILE" | cut -f1)"
    echo "Lines: $(wc -l < "$LOG_FILE")"
    echo "Last modified: $(stat -c %y "$LOG_FILE")"
    echo ""
    
    # Error count
    echo "--- Error Analysis ---"
    ERROR_COUNT=$(grep -i "error" "$LOG_FILE" | wc -l)
    WARNING_COUNT=$(grep -i "warning" "$LOG_FILE" | wc -l)
    CRITICAL_COUNT=$(grep -i "critical" "$LOG_FILE" | wc -l)
    
    echo "Errors: $ERROR_COUNT"
    echo "Warnings: $WARNING_COUNT"
    echo "Critical: $CRITICAL_COUNT"
    echo ""
    
    # Top errors
    if [ $ERROR_COUNT -gt 0 ]; then
        echo "--- Top 10 Error Messages ---"
        grep -i "error" "$LOG_FILE" | awk '{print $5, $6, $7, $8, $9}' | sort | uniq -c | sort -rn | head -10
        echo ""
    fi
    
    # Recent errors
    echo "--- Last 5 Errors ---"
    grep -i "error" "$LOG_FILE" | tail -5
    echo ""
    
    # Failed logins (if auth.log)
    if [[ "$LOG_FILE" == *"auth.log"* ]]; then
        echo "--- Failed Login Attempts ---"
        FAILED_LOGINS=$(grep -i "failed password" "$LOG_FILE" | wc -l)
        echo "Total: $FAILED_LOGINS"
        
        if [ $FAILED_LOGINS -gt 0 ]; then
            echo ""
            echo "By IP address:"
            grep -i "failed password" "$LOG_FILE" | awk '{print $(NF-3)}' | sort | uniq -c | sort -rn | head -10
        fi
        echo ""
    fi
    
    # Time-based analysis
    echo "--- Activity by Hour ---"
    awk '{print $3}' "$LOG_FILE" | cut -d: -f1 | sort | uniq -c | sort -rn | head -10
    echo ""
    
    echo "========================================"
    echo "Report generated: $REPORT_FILE"
    echo "========================================"
    
} | tee "$REPORT_FILE"

echo ""
echo "Report saved to: $REPORT_FILE"
```

---

## Project 5: Interactive Calculator

```bash
#!/bin/bash

################################################################################
# Interactive Calculator
# Performs basic arithmetic operations
################################################################################

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Functions
add() {
    echo $(($1 + $2))
}

subtract() {
    echo $(($1 - $2))
}

multiply() {
    echo $(($1 * $2))
}

divide() {
    if [ $2 -eq 0 ]; then
        echo "Error: Division by zero"
        return 1
    fi
    echo $(($1 / $2))
}

modulo() {
    echo $(($1 % $2))
}

power() {
    echo $(($1 ** $2))
}

show_menu() {
    clear
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}        CALCULATOR${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
    echo "1) Addition (+)"
    echo "2) Subtraction (-)"
    echo "3) Multiplication (×)"
    echo "4) Division (÷)"
    echo "5) Modulo (%)"
    echo "6) Power (^)"
    echo "7) Exit"
    echo ""
}

get_numbers() {
    while true; do
        read -p "Enter first number: " NUM1
        if [[ "$NUM1" =~ ^-?[0-9]+$ ]]; then
            break
        else
            echo -e "${RED}Invalid number! Try again.${NC}"
        fi
    done
    
    while true; do
        read -p "Enter second number: " NUM2
        if [[ "$NUM2" =~ ^-?[0-9]+$ ]]; then
            break
        else
            echo -e "${RED}Invalid number! Try again.${NC}"
        fi
    done
}

# Main loop
while true; do
    show_menu
    read -p "Enter choice (1-7): " CHOICE
    
    case $CHOICE in
        1)
            echo -e "${YELLOW}--- Addition ---${NC}"
            get_numbers
            RESULT=$(add $NUM1 $NUM2)
            echo -e "${GREEN}$NUM1 + $NUM2 = $RESULT${NC}"
            ;;
        2)
            echo -e "${YELLOW}--- Subtraction ---${NC}"
            get_numbers
            RESULT=$(subtract $NUM1 $NUM2)
            echo -e "${GREEN}$NUM1 - $NUM2 = $RESULT${NC}"
            ;;
        3)
            echo -e "${YELLOW}--- Multiplication ---${NC}"
            get_numbers
            RESULT=$(multiply $NUM1 $NUM2)
            echo -e "${GREEN}$NUM1 × $NUM2 = $RESULT${NC}"
            ;;
        4)
            echo -e "${YELLOW}--- Division ---${NC}"
            get_numbers
            RESULT=$(divide $NUM1 $NUM2)
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}$NUM1 ÷ $NUM2 = $RESULT${NC}"
            fi
            ;;
        5)
            echo -e "${YELLOW}--- Modulo ---${NC}"
            get_numbers
            RESULT=$(modulo $NUM1 $NUM2)
            echo -e "${GREEN}$NUM1 % $NUM2 = $RESULT${NC}"
            ;;
        6)
            echo -e "${YELLOW}--- Power ---${NC}"
            get_numbers
            RESULT=$(power $NUM1 $NUM2)
            echo -e "${GREEN}$NUM1 ^ $NUM2 = $RESULT${NC}"
            ;;
        7)
            echo -e "${GREEN}Thank you for using Calculator!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice!${NC}"
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
done
```

---

# Quick Reference Cheatsheet

## File Operations

```bash
# Navigation
pwd                     # Print working directory
cd /path               # Change directory
cd ~                   # Go to home
cd ..                  # Go up one level
cd -                   # Go to previous directory

# Listing
ls                     # List files
ls -l                  # Long format
ls -a                  # Show hidden files
ls -lh                 # Human readable sizes
ls -lt                 # Sort by time

# Creating
touch file.txt         # Create empty file
mkdir dir              # Create directory
mkdir -p a/b/c        # Create nested directories

# Copying/Moving/Deleting
cp src dest           # Copy file
cp -r dir1 dir2       # Copy directory
mv old new            # Move/rename
rm file               # Delete file
rm -r dir             # Delete directory
rm -rf dir            # Force delete

# Viewing
cat file              # Display file
head file             # First 10 lines
head -n 5 file        # First 5 lines
tail file             # Last 10 lines
tail -f file          # Follow file (live)
less file             # Page through file
```

---

## Text Processing

```bash
# Searching
grep "text" file              # Search in file
grep -i "text" file           # Case-insensitive
grep -r "text" dir/           # Recursive search
grep -n "text" file           # Show line numbers
grep -v "text" file           # Invert match

# Sorting and Counting
sort file                     # Sort lines
sort -r file                  # Reverse sort
uniq file                     # Remove duplicates
wc -l file                    # Count lines
wc -w file                    # Count words

# Text Manipulation
cut -d',' -f1 file           # Cut first column
sed 's/old/new/g' file       # Replace text
awk '{print $1}' file        # Print first field
```

---

## Permissions

```bash
# View Permissions
ls -l                  # Shows: -rwxr-xr-x

# Change Permissions (Numbers)
chmod 755 file         # rwxr-xr-x
chmod 644 file         # rw-r--r--
chmod 700 file         # rwx------

# Change Permissions (Letters)
chmod u+x file         # Add execute for user
chmod g-w file         # Remove write for group
chmod o+r file         # Add read for others
chmod a+x file         # Add execute for all

# Change Owner
chown user:group file  # Change owner and group
chown user file        # Change owner only
```

---

## Bash Scripting Basics

```bash
#!/bin/bash
# Shebang - must be first line

# Variables
NAME="value"
echo "$NAME"
echo "${NAME}"

# Command Substitution
DATE=$(date)
FILES=$(ls)

# User Input
read VARIABLE
read -p "Prompt: " VARIABLE
read -sp "Password: " PASS    # Silent

# Arithmetic
SUM=$((5 + 3))
DIFF=$((10 - 5))
PRODUCT=$((4 * 2))
QUOTIENT=$((10 / 2))
```

---

## Conditionals

```bash
# If Statement
if [ condition ]; then
    # commands
fi

# If-Else
if [ condition ]; then
    # commands
else
    # commands
fi

# If-Elif-Else
if [ condition1 ]; then
    # commands
elif [ condition2 ]; then
    # commands
else
    # commands
fi

# Numeric Comparisons
-eq    # Equal
-ne    # Not equal
-gt    # Greater than
-ge    # Greater or equal
-lt    # Less than
-le    # Less or equal

# String Comparisons
==     # Equal
!=     # Not equal
-z     # Empty string
-n     # Not empty

# File Tests
-f     # File exists
-d     # Directory exists
-r     # Readable
-w     # Writable
-x     # Executable
-s     # Not empty

# Logical Operators
&&     # AND
||     # OR
!      # NOT

# Case Statement
case $VAR in
    pattern1)
        # commands
        ;;
    pattern2)
        # commands
        ;;
    *)
        # default
        ;;
esac
```

---

## Loops

```bash
# For Loop
for VAR in list; do
    # commands
done

for i in {1..10}; do
    echo $i
done

for FILE in *.txt; do
    echo $FILE
done

# While Loop
while [ condition ]; do
    # commands
done

COUNT=1
while [ $COUNT -le 5 ]; do
    echo $COUNT
    COUNT=$((COUNT + 1))
done

# Until Loop
until [ condition ]; do
    # commands
done

# Loop Control
break       # Exit loop
continue    # Skip to next iteration
```

---

## Functions

```bash
# Define Function
function_name() {
    # commands
}

# With Arguments
greet() {
    local NAME=$1
    echo "Hello, $NAME"
}

greet "John"

# Return Value
add() {
    echo $(($1 + $2))
}

RESULT=$(add 5 3)

# Return Status
check() {
    if [ condition ]; then
        return 0  # Success
    else
        return 1  # Failure
    fi
}

# Function Variables
$1, $2, $3    # Arguments
$@            # All arguments
$#            # Number of arguments
local VAR     # Local variable
```

---

## Arrays

```bash
# Create Array
ARRAY=("item1" "item2" "item3")

# Access Elements
${ARRAY[0]}        # First element
${ARRAY[@]}        # All elements
${#ARRAY[@]}       # Number of elements

# Add Element
ARRAY+=("item4")

# Loop Through Array
for ITEM in "${ARRAY[@]}"; do
    echo $ITEM
done

# Associative Array (Bash 4+)
declare -A DICT
DICT["key"]="value"
echo "${DICT[key]}"
```

---

## String Manipulation

```bash
# Length
${#STRING}

# Substring
${STRING:start:length}
${STRING:6}            # From position 6 to end

# Replace
${STRING/old/new}      # First occurrence
${STRING//old/new}     # All occurrences

# Case Conversion
${STRING^^}            # Uppercase
${STRING,,}            # Lowercase

# Remove Prefix/Suffix
${STRING#prefix}       # Remove shortest prefix
${STRING%suffix}       # Remove shortest suffix
```

---

## Special Variables

```bash
$0     # Script name
$1-$9  # Arguments 1-9
$@     # All arguments
$#     # Number of arguments
$?     # Exit status of last command
$$     # Current process ID
$!     # Last background process ID

# Environment Variables
$HOME  # Home directory
$PATH  # Command search path
$USER  # Current user
$PWD   # Current directory
```

---

## Input/Output Redirection

```bash
# Output Redirection
command > file         # Overwrite file
command >> file        # Append to file
command 2> file        # Redirect errors
command &> file        # Redirect all output

# Input Redirection
command < file         # Read from file

# Piping
command1 | command2    # Output of cmd1 to cmd2

# Discard Output
command > /dev/null    # Discard output
command 2>&1           # Redirect errors to output
```

---

## Useful Patterns

```bash
# Check if file exists
if [ -f "file.txt" ]; then
    echo "File exists"
fi

# Check if directory exists
if [ ! -d "mydir" ]; then
    mkdir mydir
fi

# Loop through files
for FILE in *.txt; do
    echo "Processing $FILE"
done

# Read file line by line
while IFS= read -r LINE; do
    echo "$LINE"
done < file.txt

# Error handling
command || {
    echo "Command failed"
    exit 1
}

# Default value
VALUE=${VAR:-"default"}

# Check number of arguments
if [ $# -lt 1 ]; then
    echo "Usage: $0 <arg>"
    exit 1
fi

# Yes/No prompt
read -p "Continue? (y/n): " ANSWER
if [ "$ANSWER" == "y" ]; then
    echo "Continuing..."
fi

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
echo -e "${RED}Error${NC}"
echo -e "${GREEN}Success${NC}"
```

---

## Debugging

```bash
# Debug mode
bash -x script.sh      # Print commands as executed
set -x                 # Enable debug in script
set +x                 # Disable debug

# Strict mode
set -e                 # Exit on error
set -u                 # Exit on undefined variable
set -o pipefail        # Exit on pipe failure

# Verbose mode
set -v                 # Print input lines

# Combined
set -euo pipefail      # Strict mode
```

---

## Common Commands Reference

```bash
# System Information
uname -a               # System info
hostname               # Computer name
whoami                 # Current user
date                   # Current date/time
uptime                 # System uptime
df -h                  # Disk space
free -h                # Memory usage
top                    # Process monitor

# File Information
file filename          # File type
stat filename          # File statistics
du -sh dir            # Directory size
wc -l file            # Count lines

# Process Management
ps aux                 # All processes
kill PID              # Kill process
killall name          # Kill by name
bg                    # Background job
fg                    # Foreground job
jobs                  # List jobs

# Network
ping host             # Test connection
wget url              # Download file
curl url              # Transfer data
ssh user@host         # Remote login
scp file user@host:   # Copy to remote
```

---

## Tips and Best Practices

1. **Always quote variables**: `"$VAR"` instead of `$VAR`
2. **Use `local` in functions**: Prevents global variable pollution
3. **Check exit codes**: Use `$?` or `if command; then`
4. **Validate input**: Check arguments and user input
5. **Use meaningful names**: `USER_NAME` not `UN`
6. **Add comments**: Explain complex logic
7. **Handle errors**: Use `set -e` and check return values
8. **Use shellcheck**: Lint your scripts (install with `sudo apt install shellcheck`)
9. **Make scripts executable**: `chmod +x script.sh`
10. **Start with shebang**: `#!/bin/bash`

---

## Additional Resources

### Online Learning
- [Linux Journey](https://linuxjourney.com) - Interactive Linux tutorials
- [ExplainShell](https://explainshell.com) - Explains any shell command
- [Bash Academy](https://guide.bash.academy) - Comprehensive bash guide
- [ShellCheck](https://www.shellcheck.net) - Online script validator

### Manual Pages
```bash
man bash               # Complete bash manual
man command            # Manual for any command
help command           # Help for bash built-ins
command --help         # Quick reference

# Examples
man ls                 # ls command manual
help read              # read built-in help
grep --help            # grep quick reference
```



---

## Glossary

**Bash** - Bourne Again Shell, the default Linux shell  
**Shell** - Command-line interface to the operating system  
**Script** - A file containing a series of commands  
**Variable** - Named storage for data  
**Function** - Reusable block of code  
**Loop** - Repeated execution of commands  
**Conditional** - Execute commands based on conditions  
**Pipe** - Send output of one command to another  
**Redirect** - Send output to a file  
**Permissions** - Who can read/write/execute files  
**Exit Code** - Number indicating command success/failure  
**Shebang** - `#!/bin/bash` - tells system which interpreter to use  

---

## License

This guide is provided for educational purposes. Feel free to share, modify, and distribute.




