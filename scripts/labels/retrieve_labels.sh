#!/bin/bash

# Check if the `gh` command is installed
if ! command -v gh &>/dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first."
    exit 1
fi

# Check if the organization name is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <organization_name>"
    exit 1
fi

# Function to retrieve and save labels for a repository
function get_and_save_labels() {
    local repo="$1"
    local output_file="${repo}.json"

    # Use `gh` command to list labels for the repository
    gh label list -L400 -R "$repo" --sort name --json name,color,description > "$output_file"
    gh label list -L400 -R "$repo" --sort name > "${repo}.txt"

    echo "Labels for repository $repo have been saved to $output_file"
}

# Get the organization name from the argument
organization="$1"

# Use `gh` command to list all repositories for the organization
repositories=$(gh repo list "$organization" --json name --jq '.[].name')

# Iterate through the repositories and retrieve labels
while IFS= read -r repo; do
    get_and_save_labels "$organization/$repo"
    # exit 1
done <<< "$repositories"
