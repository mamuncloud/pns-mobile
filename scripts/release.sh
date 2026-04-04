#!/bin/bash

# ==============================================================================
# 🚀 PNS Mobile - Release Helper Script
# ==============================================================================
# This script simplifies the process of creating a new version release.
# Usage: ./scripts/release.sh 1.2.3
# ==============================================================================

VERSION=$1

# 1. Colors for pretty output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 2. Check if version is provided
if [ -z "$VERSION" ]; then
    echo -e "${RED}❌ Error: No version number provided.${NC}"
    echo -e "${BLUE}Usage: ./scripts/release.sh 1.0.0${NC}"
    exit 1
fi

# 3. Add 'v' prefix if missing
if [[ $VERSION != v* ]]; then
    TAG="v$VERSION"
else
    TAG="$VERSION"
fi

echo -e "${BLUE}--------------------------------------------------${NC}"
echo -e "📦 Preparing release for: ${GREEN}$TAG${NC}"
echo -e "${BLUE}--------------------------------------------------${NC}"

# 4. Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo -e "${RED}⚠️  Warning: You have uncommitted changes.${NC}"
    echo -e "Please commit or stash your changes before releasing."
    exit 1
fi

# 5. Ensure we are on main
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "main" ] && [ "$CURRENT_BRANCH" != "develop" ]; then
    echo -e "${RED}⚠️  Warning: You are on branch '$CURRENT_BRANCH'.${NC}"
    echo -e "Releases are usually triggered from 'main' or 'develop'."
    read -p "Do you want to continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# 6. Create the tag locally
echo -e "🏷️  Creating local tag: ${GREEN}$TAG${NC}..."
if git rev-parse "$TAG" >/dev/null 2>&1; then
    echo -e "${RED}❌ Error: Tag '$TAG' already exists.${NC}"
    exit 1
fi

git tag -a "$TAG" -m "Release $TAG"

# 7. Push the tag to GitHub
echo -e "🚀 Pushing tag to GitHub..."
git push origin "$TAG"

if [ $? -eq 0 ]; then
    echo -e "${BLUE}--------------------------------------------------${NC}"
    echo -e "${GREEN}✅ Success! $TAG has been pushed.${NC}"
    echo -e "The robots will now take over to:"
    echo -e "  1. Build your APK"
    echo -e "  2. Create a GitHub Release"
    echo -e "  3. Send a WhatsApp notification"
    echo -e "${BLUE}--------------------------------------------------${NC}"
else
    echo -e "${RED}❌ Failed to push the tag to GitHub.${NC}"
    exit 1
fi
