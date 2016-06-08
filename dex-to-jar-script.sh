#!/bin/bash

APPS_DIR=/home/babis/apks/*


for f in $APPS_DIR

do
    
    sh ~/dex2jar/dex2jar-2.0/d2j-dex2jar.sh  $Apps_directory/$f


done











