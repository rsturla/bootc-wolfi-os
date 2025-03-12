#!/usr/bin/env bash

set -euo pipefail

rm -rf ./.build
melange build melange.yaml --workspace-dir ./.build --rm=false --empty-workspace=false --cleanup=false
