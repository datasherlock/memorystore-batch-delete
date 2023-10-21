#!/bin/bash
./config

EXCLUDE="demo1 demo2" # clusters to exclude from the batch deletion
# Get a list of all Memorystore instances in the project
INSTANCES=$(gcloud redis instances list --project=$PROJECT_ID --region=$REGION --format="value(name)")
INSTANCES=$(echo "$INSTANCES" | grep -vwE "$(echo $EXCLUDE | tr ' ' '|')")

echo "$INSTANCES" | while read -r INSTANCE
do
  echo "Deleting Memorystore instance: $INSTANCE"
  echo "gcloud redis instances delete $INSTANCE --project=$PROJECT_ID --region=$REGION --async"
  gcloud redis instances delete $INSTANCE --project=$PROJECT_ID --region=$REGION --async


echo "All Memorystore instances have been deleted in the project: $PROJECT_ID"
