#!/bin/sh

START_DATE=$(date +"%s")

RESOURCE_NAME="event.yml"

RESOURCE_CHANGED=$(git diff --name-only | grep $RESOURCE_NAME)

if [[ "$RESOURCE_CHANGED" == "" ]]; then
	RESOURCE_CHANGED=$(git diff --cached --name-only | grep $RESOURCE_NAME)
fi

if [[ "$RESOURCE_CHANGED" != "" ]]; then
    echo "begin excute swiftgen"
    /$PODS_ROOT/SwiftGen/bin/swiftgen config run --config "$PODS_ROOT/../../Sources/Generated/swiftgen.yml"
fi

END_DATE=$(date +"%s")

DIFF=$(($END_DATE - $START_DATE))
echo "took $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds to complete."
