#!/bin/bash

# Configuration variables
REPO_URL="https://johnathan-sq.github.io/charts/" # URL of your GitHub repository
CHART_REPO_NAME="charts" # Name of your Helm chart repository
CHART_DIR="./generic-deployment/chart" # Path to your Helm chart directory

# Check if gh-pages branch exists and switch to it, otherwise create it
if git show-ref --quiet refs/heads/gh-pages; then
    echo "Switching to gh-pages branch..."
    git checkout gh-pages
else
    echo "Creating gh-pages branch..."
    git checkout --orphan gh-pages
    git reset --hard
    git commit --allow-empty -m "Initializing gh-pages branch"
    git push origin gh-pages
    git checkout gh-pages
fi

# Ensure the script is run from the repository root
if [ ! -d "$CHART_DIR" ]; then
    echo "Please run this script from the root of your repository where your chart directory is located."
    exit 1
fi

# Package the Helm chart
echo "Packaging Helm chart..."
helm package $CHART_DIR --destination .

# Generating or updating index.yaml
echo "Updating index.yaml..."
helm repo index . --url $REPO_URL --merge index.yaml

# Commit and push changes
echo "Committing and pushing changes to GitHub..."
git add .
git commit -m "Update Helm chart repository"
git push origin gh-pages

# Switch back to the main branch (optional)
# git checkout main

echo "Helm chart repository updated on gh-pages branch."
