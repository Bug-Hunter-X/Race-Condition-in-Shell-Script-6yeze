#!/bin/bash

# This script demonstrates the solution to the race condition bug using flock.

# Create two files
touch file1.txt
touch file2.txt

# Function to write to a file using flock for locking
write_to_file() {
  local file=$1
  local message=$2
  flock -x "$file" || exit 1  # Acquire an exclusive lock
  echo "$message" >> "$file"
  flock -u "$file" # Release the lock
}

# Start two processes that write to the files simultaneously
(while true; do write_to_file file1.txt "process1"; sleep 0.1; done) &
(while true; do write_to_file file2.txt "process2"; sleep 0.1; done) &

# Wait for some time
sleep 5

# Kill the processes
kill %1
kill %2

# The files are now much less likely to be corrupted because of the use of flock.