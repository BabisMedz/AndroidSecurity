#!/bin/bash

APPS_DIR=/home/babis/apks/*

for f in $APPS_DIR

do
    
    file=$APPS_DIR
    apktool decode -f $f
    
done

