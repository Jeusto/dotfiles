#!/usr/bin/bash

num_commits=${1:-1}

for ((i=0; i<num_commits; i++)); do
    gitRan=$(curl -L -s http://whatthecommit.com/ | grep -A 1 "\"c" | tail -1 | sed 's/<p>//')
    commitTemp="$i:$gitRan"
    commitLowercase=$(echo "$commitTemp" | awk '{ print tolower($0) }')
    git add . && git commit -m "$commitLowercase"
done