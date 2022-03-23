#!/bin/bash

COMMAND=${1:-apply}

source .env
IFS=,
for AWS_REGION in $AWS_REGIONS;
do
   echo "$AWS_REGION"
   export TF_VAR_aws_region=${AWS_REGION}
   terraform $COMMAND -state=terraform.tfstate.${AWS_REGION}
done
