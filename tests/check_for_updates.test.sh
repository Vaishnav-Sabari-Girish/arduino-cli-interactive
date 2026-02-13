#!/usr/bin/env bash

# Test: check_for_updates without GitHub token
set -x

export ACI_TEST_MODE=1
unset ACI_GITHUB_TOKEN

ping() {
  return 1
}

source ./main.sh

check_for_updates
exit_code=$?

if [ "$exit_code" -ne 1 ]; then
  echo "❌ Expected exit code 1 when ACI_GITHUB_TOKEN is missing, got $exit_code"
  exit 1
fi

echo "✅ check_for_updates returns 1 when GitHub token is missing"
