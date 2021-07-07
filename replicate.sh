#!/bin/bash

#Clone dataset and generate csv
export back=$PWD
git clone https://github.com/spgroup/mergedataset
cd mergedataset
git checkout c8b965f
cd mergedataset/semantic-conflicts
python3 get_sample.py
cd $back

#Docker commands for tool executation
docker build -t infra --build-arg DIRPATH=$PWD --build-arg DEST_CSV="mergedataset/semantic-conflicts/results_semantic_study.csv" .
docker run -v $PWD/output:$PWD/output -v $PWD/mergedataset:$PWD/mergedataset -u="$(id -u $USER)" -it infra