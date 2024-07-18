#!/bin/bash

DIR=$(dirname $_)

source $DIR/env.sh

docker run -v $(pwd):/app --gpus all -p 8888:8888 docker.io/$IMAGE:$VERSION
