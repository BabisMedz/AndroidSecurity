#!/bin/bash

APPS_DIR=/home/babis/apks/*

for f in $APPS_DIR

do
    
    file=$APPS_DIR
    apktool decode -f $f

 done

counter=1
mkdir permission
#mkdir service

for f in $APPS_DIR

do
  
    basenamefile=$(basename $f .apk)
    echo $basenamefile
    cd $basenamefile
    cp AndroidManifest.xml /home/babis/Έγγραφα/Διπλωματική/diassemplyManifestScript/AndroidManifest$counter.xml
    cd ..
    mv AndroidManifest$counter.xml $basenamefile.AndroidManifest.xml
    rm -rf $basenamefile
   
    let counter=counter+1
    
    grep 'permission' $basenamefile.AndroidManifest.xml |sed 's/ /\n/g' |grep 'android:name='  |sed 's/android:name=//g' |sed 's/[<:>/"]//g'> manifest-tmp.txt 
    grep -vwE '(uses-permission|uses-permission-sdk-m|provider|activity|activity-alias|receiver|application|service|grant-uri-permission)' manifest-tmp.txt > manifest.txt
    rm manifest-tmp.txt
    mv manifest.txt   $basenamefile.manifest.permission.txt
    mv  $basenamefile.manifest.permission.txt permission/$basenamefile.manifest.permission.txt

 #   grep 'service' $basenamefile.AndroidManifest.xml |sed 's/ /\n/g' |grep 'android:name='  |sed 's/android:name=//g' |sed 's/[<:>/"]//g'> manifest-tmp.txt 
  #  grep -vwE '(provider|receiver|meta-data|activity|action)' manifest-tmp.txt >manifest.txt
  #  rm manifest-tmp.txt
   # mv manifest.txt   $basenamefile.manifest.service.txt
    #mv $basenamefile.manifest.service.txt service/$basenamefile.manifest.service.txt
    


    sed 's/\./ /g'  permission/$basenamefile.manifest.permission.txt | awk '{print $NF}'|awk '!a[$0]++' >  permission/$basenamefile.permissionF.txt
    rm -rf permission/$basenamefile.manifest.permission.txt
    rename 's/\.(?=.*\.)/_/g' permission/$basenamefile.permissionF.txt
    rm -rf $basenamefile.AndroidManifest.xml

   #  sed 's/\./ /g'  service/$basenamefile.manifest.service.txt | awk '{print $NF}'|awk '!a[$0]++' >  service/$basenamefile.serviceF.txt
  # rm -rf service/$basenamefile.manifest.service.txt
  # rename 's/\.(?=.*\.)/_/g' service/$basenamefile.serviceF.txt


   

done
