#! /bin/bash
# Prepares generic value for an env file

ENVIRONMENT=$1
COMPANY_NAME=$2

if [[ $OSTYPE == 'darwin'* ]]; then
  sed -i '' "s/SHIELDRULE_ENVIRONMENT=.*/SHIELDRULE_ENVIRONMENT=$ENVIRONMENT/" "$ENVIRONMENT.env"
  sed -i '' "s|AUDIENCE_URL=.*|AUDIENCE_URL=https://$ENVIRONMENT.usemodernlogic.com/api|" "$ENVIRONMENT.env"
  sed -i '' "s|ISSUER_URL=.*|ISSUER_URL=https://sliderule-auth.us.auth0.com/|" "$ENVIRONMENT.env"
  sed -i '' "s|SLACK_REDIRECT_URI=.*|SLACK_REDIRECT_URI=https://$ENVIRONMENT.usemodernlogic.com/credentials|" "$ENVIRONMENT.env"
  sed -i '' "s/AUTH0_ENVIRONMENT_PREFIX=.*/AUTH0_ENVIRONMENT_PREFIX=$COMPANY_NAME_$ENVIRONMENT/" "$ENVIRONMENT.env"
else
  sed -i "s/SHIELDRULE_ENVIRONMENT=.*/SHIELDRULE_ENVIRONMENT=$ENVIRONMENT/" "$ENVIRONMENT.env"
  sed -i "s|AUDIENCE_URL=.*|AUDIENCE_URL=https://$ENVIRONMENT.usemodernlogic.com/api|" "$ENVIRONMENT.env"
  sed -i "s|ISSUER_URL=.*|ISSUER_URL=https://sliderule-auth.us.auth0.com/|" "$ENVIRONMENT.env"
  sed -i "s|SLACK_REDIRECT_URI=.*|SLACK_REDIRECT_URI=https://$ENVIRONMENT.usemodernlogic.com/credentials|" "$ENVIRONMENT.env"
  sed -i "s/AUTH0_ENVIRONMENT_PREFIX=.*/AUTH0_ENVIRONMENT_PREFIX=$COMPANY_NAME_$ENVIRONMENT/" "$ENVIRONMENT.env"
fi