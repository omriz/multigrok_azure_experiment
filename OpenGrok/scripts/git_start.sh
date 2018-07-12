#!/bin/bash
# Cloning the required repositories.
cd /src
while IFS=',' read -ra ZZZ; do
    for i in "${ZZZ[@]}";do
        git clone ${i}
    done
done <<< "$MONITORED_REPOSITORIES"
# Launching Opengrok
/scripts/start.sh