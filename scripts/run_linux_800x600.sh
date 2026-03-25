#!/usr/bin/env bash
set -euo pipefail

# Start Flutter Linux desktop with fixed native window policy (configured in linux/runner/my_application.cc).
flutter run -d linux "$@"
