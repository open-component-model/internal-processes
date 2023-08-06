#!/bin/bash

# Check if the `gh` command is installed
if ! command -v gh &>/dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first."
    exit 1
fi

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

# Function to retrieve and save labels for a repository
# function get_and_save_labels() {
#     local repo="$1"
#     local output_file="${repo}.json"

#     # Use `gh` command to list labels for the repository
#     gh label list --json name,color,description -R "$repo" |
#         jq '[.[] | {name: .name, color: .color, description: .description}]' > "$output_file"

#     echo "Labels for repository $repo have been saved to $output_file"
# }

# Check if the organization name and JSON file path are provided as arguments
if [ $# -lt 2 ]; then
    echo "Usage: $0 <organization_name> <path_to_labels_json_file>"
    exit 1
fi

# Get the organization name and JSON file path from the arguments
organization="$1"
json_file="$2"

# Check if the JSON file exists
if [ ! -f "$json_file" ]; then
    echo "JSON file not found: $json_file"
    exit 1
fi

# Use `gh` command to list all repositories for the organization
repositories=$(gh repo list "$organization"  -L 100 --json name --jq '.[].name')

# Read and parse the JSON file containing labels
labels=$(jq -c '.[]' "$json_file")

# Iterate through the repositories and set labels
while IFS= read -r repo; do
    while IFS= read -r label; do
    # for label in $labels; do
        name=$(jq -r '.name' <<< "$label")
        color=$(jq -r '.color' <<< "$label")
        description=$(jq -r '.description' <<< "$label")
        force=$(jq -r '.force' <<< "$label")
        set_github_label "$name" "$color" "$description" "$force" "$organization/$repo"
    # done
    done <<< "$labels"
done <<< "$repositories"
