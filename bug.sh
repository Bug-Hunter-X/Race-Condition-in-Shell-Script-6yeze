#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Start two processes that write to the files simultaneously
(while true; do echo "process1" >> file1.txt; sleep 0.1; done) &
(while true; do echo "process2" >> file2.txt; sleep 0.1; done) &

# Wait for some time
sleep 5

# Kill the processes
kill %1
kill %2

# The files might be incomplete or corrupted due to race condition