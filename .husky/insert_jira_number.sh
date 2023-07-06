#!/usr/bin/env bash

# Exclude primary branches that shouldn't be prepended
if [ -z "$BRANCHES_TO_SKIP" ]; then
	BRANCHES_TO_SKIP[0]=main
	BRANCHES_TO_SKIP[1]=master
	BRANCHES_TO_SKIP[2]=develop
	BRANCHES_TO_SKIP[3]=version
	BRANCHES_TO_SKIP[4]=release
	BRANCHES_TO_SKIP[5]=temp
fi

# Get the current branch name and check if it is excluded
BRANCH_NAME=$(git symbolic-ref --short HEAD)

# Get the matching pattern from the branch
BRANCH_CODE=$(echo $BRANCH_NAME | grep -Eo "[A-Z_]{2,15}-[0-9]{1,5}" | awk '{$1=$1};1')

# Check if the prefix already exists in the message
EXISTING_CODE=$(cat $1 | grep -Eo "[A-Z_]{2,15}-[0-9]{1,5}" | awk '{$1=$1};1')

# If the branch isn't excluded, and the code doesn't already exist,
# prepend the code to the message
if [ -n "$BRANCH_NAME" ] &&  ! [[ " $BRANCHES_TO_SKIP[@] " =~ " $BRANCH_NAME " ]]; then
	if [ "$BRANCH_CODE" != "$EXISTING_CODE" ]; then
    echo "Adding jira number $BRANCH_CODE"
		echo "$BRANCH_CODE - $(cat $1)" > $1
	fi
fi

exit 0
