#!/bin/bash
set -eo pipefail
REGION=$(aws configure get region)
ACCOUNT_ID=$(aws sts get-caller-identity | jq -r .Account)

docker build -t hello-world .
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
docker tag  hello-world:latest $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/hello-world:latest
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/hello-world:latest
docker logout $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com
