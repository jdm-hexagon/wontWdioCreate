#!/usr/bin/env bash
LC_ALL=C

# check the branch name is correct
LOCAL_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
REGEX="^(feature|bugfix|hotfix)\/[A-Z_]{2,15}-[0-9]{1,5}-[a-z0-9._-]+|temp\/[a-z0-9._-]+|version\/[0-9].[0-9]|release\/[0-9].[0-9]|main$"
MESSAGE="Branch names must adhere to the contract: $REGEX \n\
e.g. feature/CODE-0000-branch-name OR temp/foo OR version/1.0 OR release/1.0 \n\
This commit has been rejected. Rename the branch to a valid name and try again. \n"

if [[ ! $LOCAL_BRANCH =~ $REGEX ]]; then
	echo "$MESSAGE"
	exit 1
fi
