#!/bin/bash
set -e

# Step 1: Ensure clean working tree
if [[ -n $(git status --porcelain) ]]; then
  echo "❌ Working tree is dirty. Please commit or stash changes before releasing."
  exit 1
fi

# Step 2: Install dependencies
pnpm install

# Step 3: Bump root version
echo "🔧 Bumping root version..."
pnpm version prerelease --preid beta

# Step 4: Bump non-private workspace versions
echo "🔧 Bumping workspace versions..."
pnpm -r exec pnpm version prerelease --preid beta

# Step 5: Extract root version
VERSION=$(node -p "require('./package.json').version")
echo "🔖 New version: $VERSION"

# Step 6: Stage all changes
git add .

# Step 7: Commit the bump
git commit -m "chore: prerelease bump to v$VERSION"

# Step 8: Create semantic tag
git tag "v$VERSION"

# Step 9: Push commit and tag
git push origin HEAD
git push origin "v$VERSION"

# Step 10: Optional dry-run publish
echo "🚀 Dry-run publishing..."
pnpm -r publish --dry-run

echo "✅ Release script completed for v$VERSION"