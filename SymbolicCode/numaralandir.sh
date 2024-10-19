## Script

```bash
#!/bin/bash

# List all files in the current directory
files=(*)

# Sort files by creation date
sorted_files=($(ls -t --time=creation))

# Initialize counter
counter=1

# Loop through sorted files and rename them
for file in "${sorted_files[@]}"; do
    # Check if it's a file
    if [ -f "$file" ]; then
        # Extract the filename without the path
        filename=$(basename "$file")
        # Rename the file with the prefix
        mv "$file" "${counter}_$filename"
        # Increment the counter
        ((counter++))
    fi
done
