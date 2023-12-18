#!/bin/bash

mkdir api
cd api

python3 -m venv venv
source venv/bin/activate
sudo apt-get install python3-pip
pip install Flask Flask-HTTPAuth PyJWT
