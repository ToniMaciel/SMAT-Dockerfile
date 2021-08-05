#!/bin/bash
#Clone dataset and generate csv
export back=$PWD
if [ ! -d "mergedataset" ]; then git clone https://github.com/spgroup/mergedataset; fi
cd mergedataset
git checkout c8b965f
cd semantic-conflicts
python3 get_sample.py
cd $back
#Docker commands for tool executation
mkdir output
docker build -t infra --build-arg DIRPATH=$PWD --build-arg DEST_CSV="$PWD/mergedataset/semantic-conflicts/results_semantic_study.csv" .
docker run -u="$(id -u $USER)" -v $PWD/output:$PWD/output -v $PWD/mergedataset:$PWD/mergedataset -it infra
