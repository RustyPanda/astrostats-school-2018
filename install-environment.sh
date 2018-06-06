#!/bin/bash
conda create --name py36 python=3.6
source activate py36
conda install --yes --file requirements.txt
