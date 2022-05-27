#! /bin/bash

ENVIRONMENT=$1

cp "$ENVIRONMENT.env" "values-$ENVIRONMENT.yaml"

if [[ $OSTYPE == 'darwin'* ]]; then
  sed -i '' "s/\=/: /" "values-$ENVIRONMENT.yaml"
else
  sed -i "s/\=/: /" "values-$ENVIRONMENT.yaml"
fi

mv "values-$ENVIRONMENT.yaml" ../../kubernetes/aws/shieldrule