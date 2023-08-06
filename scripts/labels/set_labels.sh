#!/bin/bash

# Function to set GitHub label
function set_github_label() {
    local name="$1"
    local color="$2"
    local description="$3"
    local force="$4"
    local repo="$5"

    # Use `gh` command to create/update the label
    gh label create "$name" \
        -c "$color" \
        -d "$description" \
        ${force:+-f} \
        -R "$repo" # Specify the remote repository
}

# Check if the JSON file path and remote repository are provided as arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <path_to_json_file> <remote_repository>"
    exit 1
fi

# Check if the `gh` command is installed
if ! command -v gh &>/dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first."
    exit 1
fi

# Read and parse the JSON file
json_file="$1"
remote_repo="$2"
labels=$(jq -c '.[]' "$json_file")

# Iterate through the labels and set them
while IFS= read -r label; do
    name=$(jq -r '.name' <<< "$label")
    color=$(jq -r '.color' <<< "$label")
    description=$(jq -r '.description' <<< "$label")
    force=$(jq -r '.force' <<< "$label")

    set_github_label "$name" "$color" "$description" "$force" "$remote_repo"
done <<< "$labels"
