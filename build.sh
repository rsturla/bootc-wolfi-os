#!/usr/bin/env bash

set -euox pipefail

BUILD_DIR=$(dirname "$0")/.build
PACKAGES_DIR=$(dirname "$0")/packages
PACKAGES_REPO_DIR=$(dirname "$0")/.repo/packages

rm -rf "$BUILD_DIR"
mkdir -p "$PACKAGES_REPO_DIR"

# Check if a package argument is provided
if [ "$#" -eq 1 ]; then
  PACKAGES=("$1")
else
  PACKAGES=($(ls "$PACKAGES_DIR"))
fi

for package in "${PACKAGES[@]}"; do
  if [ ! -d "$PACKAGES_DIR/$package" ]; then
    echo "Package '$package' does not exist!"
    exit 1
  fi

  mkdir -p "$BUILD_DIR/$package"

  melange build "$PACKAGES_DIR/$package/melange.yaml" \
    --out-dir "$PACKAGES_REPO_DIR" \
    --workspace-dir "$BUILD_DIR/$package" \
    --rm=false \
    --empty-workspace=false \
    --cleanup=false
done
