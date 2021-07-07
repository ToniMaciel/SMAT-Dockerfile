#!/bin/bash

#Clone dataset and generate csv
export back=$PWD
git clone https://github.com/spgroup/mergedataset
cd mergedataset
git checkout c8b965f
cd semantic-conflicts
python3 get_sample.py
cd $back

#Docker commands for tool executation
docker build -t infra --build-arg DIRPATH=$PWD --build-arg DEST_CSV="mergedataset/semantic-conflicts/results_semantic_study.csv" .
docker run -u="$(id -u $USER)" -v $PWD:$PWD/output -v $PWD/mergedataset:$PWD/mergedataset -it infra