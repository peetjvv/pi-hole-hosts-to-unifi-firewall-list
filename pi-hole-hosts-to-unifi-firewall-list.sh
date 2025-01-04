#!/bin/bash

# Check if URL is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <URL to Pi-hole hosts file>"
    exit 1
fi

URL=$1
OUTPUT=$2
if [ -z "$OUTPUT" ]; then
    OUTPUT="./out/pi-hole-domains.txt"
fi

TEMP_FILE="./tmp/pi-hole-hosts.txt"

# Create the directories if they don't exist
mkdir -p $(dirname $OUTPUT)
mkdir -p $(dirname $TEMP_FILE)

# Download the Pi-hole hosts file
curl -s $URL > $TEMP_FILE

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download the Pi-hole hosts file from $URL"
    exit 1
fi

# Read the hosts file
DOMAINS=$(cat $TEMP_FILE)

# Remove empty lines
DOMAINS=$(echo "$DOMAINS" | sed '/^$/d')

# Remove everything before `# Custom host records are listed here.` line
DOMAINS=$(echo "$DOMAINS" | sed '1,/# Custom host records are listed here./d')

# Remove IP addresses within lines
DOMAINS=$(echo "$DOMAINS" | sed 's/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*//g')

# Remove leading and trailing whitespace
DOMAINS=$(echo "$DOMAINS" | sed 's/^[ \t]*//;s/[ \t]*$//')

# Remove commented lines
DOMAINS=$(echo "$DOMAINS" | grep -v '^#')

# Sort alphabetically
DOMAINS=$(echo "$DOMAINS" | sort)

# Remove duplicates
DOMAINS=$(echo "$DOMAINS" | uniq)

# Remove empty lines
DOMAINS=$(echo "$DOMAINS" | sed '/^$/d')

# Output the domains
echo "----------------------------------------"
echo "Extracted domains:"
echo "----------------------------------------"
echo "$DOMAINS"
echo "----------------------------------------"
echo "Total domains: $(echo "$DOMAINS" | wc -l)"
echo "----------------------------------------"
echo "Saving result to $OUTPUT"
echo "$DOMAINS" > $OUTPUT

# Clean up
rm $TEMP_FILE