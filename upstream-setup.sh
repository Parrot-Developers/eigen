#!/bin/bash

readonly UPSTREAM_REPO="https://github.com/eigenteam/eigen-git-mirror.git"

echo "Add upstream remote: ${UPSTREAM_REPO}"
git remote add upstream ${UPSTREAM_REPO}
git fetch upstream --no-tags

echo "Setup upstream branches"
git branch upstream-3.3-branch upstream/branches/3.3 --track
