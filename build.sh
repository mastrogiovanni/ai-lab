#!/bin/bash

source env.sh

docker build . -t $IMAGE:$VERSION

docker push $IMAGE:$VERSION

