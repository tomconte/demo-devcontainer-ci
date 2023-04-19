#!/bin/bash

set -o pipefail

cd $SOURCE_PATH

echo "### dotnet version"

dotnet --version

echo "### dotnet restore"

dotnet restore

echo "### dotnet format"

# Ignore errors temporarily to handle donet format exit code
set +e

dotnet format --verify-no-changes --severity info 2>&1 | tee dotnet-format.txt

exitcode=$?
if [ $exitcode -ne 0 ]; then
    printf "%s\n" '# `dotnet-format` failure' \
    '```' \
    "$(cat dotnet-format.txt)" \
    '```' >> $GITHUB_STEP_SUMMARY
    exit $exitcode
fi

# Re-enable errors
set -e

echo "### dotnet build"

dotnet build --no-restore -warnaserror

echo "### dotnet test"

dotnet test --no-build --verbosity normal --collect:"XPlat Code Coverage" --results-directory coverage
