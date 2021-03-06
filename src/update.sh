#!/bin/bash

UPDATED=200

GIT_REMOTE_VERBOSE=$(git remote -v | grep -sw "fetch")
GIT_REMOTE_VERBOSE_ARR=( $GIT_REMOTE_VERBOSE )
REMOTE=${GIT_REMOTE_VERBOSE_ARR[0]}

LENGTH_REMOTE=${#REMOTE}
START=$(( $LENGTH_REMOTE +1 ))
REMOVE_FROM_END=8 # length of (fetch), the grep search expr
END=$(( ${#GIT_REMOTE_VERBOSE} - $START - $REMOVE_FROM_END))

REMOTE_URI=${GIT_REMOTE_VERBOSE:$START:$END}
LOCAL_COMMIT_ID=$(git log --format="%H" -n 1)
REMOTE_COMMIT_ID=$(git ls-remote $REMOTE_URI HEAD)

REMOTE_COMMIT_ID=( $REMOTE_COMMIT_ID )
REMOTE_COMMIT_ID="${REMOTE_COMMIT_ID[0]}"

[ ! "$REMOTE_COMMIT_ID" == "$LOCAL_COMMIT_ID" ] && git pull $REMOTE HEAD && exit $UPDATED
