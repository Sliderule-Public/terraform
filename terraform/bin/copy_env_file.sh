#! /bin/bash

ENVIRONMENT=$1

if [ ! -f ./$ENVIRONMENT.env ]
then
	cp ../api.env.sample $ENVIRONMENT.env
fi