#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <org_name> <file_relative_path> <new_branch_name>"
    exit 1
fi

org_name="$1"
file_relative_path="$2"
new_branch_name="$3"

repository_names=$(gh repo list "$org_name" --json name --jq '.[].name' -L 100 --no-archived)

for repo_name in $repository_names; do
    git clone "https://github.com/$org_name/$repo_name.git"
    cd "$repo_name" || continue

    # Fetch remote changes
    git fetch origin

    # Create or switch to the new branch
    git checkout -B "$new_branch_name" origin/main

    # Create .github directory if it doesn't exist
    if [ ! -d ".github" ]; then
        mkdir ".github"
    fi

    file_name=$(basename "$file_relative_path")
    file_path=".github/$file_name"

    # Remove existing file if it exists
    if [ -f "$file_path" ]; then
        ls -asl "$file_path"
        echo "file "$file_path" exists removing"
        rm "$file_path"
        ls -asl "$file_path"
    fi
    
    cp "../$file_relative_path" "$file_path"
        echo "New file "$file_path""
        ls -asl "$file_path"

    git add "$file_path"
    git commit -m "Add $file_name"

    # Push with force to the new branch
    git push origin "$new_branch_name" --force

    gh pr create --base main --head "$new_branch_name" --title "New PR Template" --body "New PR Template"

    cd ..
    rm -rf "$repo_name"
done
