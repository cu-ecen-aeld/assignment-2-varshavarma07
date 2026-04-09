#!/bin/bash

make clean
make

# Default test values
WRITE_STR=${1:-"AELD_IS_FUN"}
NUM_FILES=${2:-10}
DATA_DIR="/tmp/aeld-data"

echo "Using default value $WRITE_STR for string to write"
echo "Using default value $NUM_FILES for number of files to write"

# Create data directory
mkdir -p "$DATA_DIR"
echo "$DATA_DIR created"

# Write files
for i in $(seq 1 $NUM_FILES); do
    ./writer "$DATA_DIR/file$i.txt" "$WRITE_STR"
done

echo "Writing $NUM_FILES files containing string $WRITE_STR to $DATA_DIR"

# Count files and matching lines
file_count=$(find "$DATA_DIR" -name "*.txt" | wc -l)
matching_lines=$(grep -r "$WRITE_STR" "$DATA_DIR" | wc -l)

echo "The number of files are $file_count and the number of matching lines are $matching_lines"

if [ "$file_count" -eq "$NUM_FILES" ] && [ "$matching_lines" -eq "$NUM_FILES" ]; then
    echo "success"
    exit 0
else
    echo "FAIL: file_count=$file_count, matching_lines=$matching_lines"
    exit 1
fi
