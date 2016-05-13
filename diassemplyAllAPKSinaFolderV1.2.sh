#!/bin/bash




APPS_DIR=/home/babis/apks/*
for f in $APPS_DIR

do
    
    file=$APPS_DIR
    apktool decode -f $f

   
done

counter=1
mkdir uses-permission
mkdir uses-permission-sdk-23
mkdir permission
mkdir permission-tree
mkdir AndroidManifestFiles
mkdir permission-group
mkdir grant-uri-permission

for f in $APPS_DIR

do
  
    basenamefile=$(basename $f .apk)
    echo $basenamefile
    cd $basenamefile
    cp AndroidManifest.xml /home/babis/Λήψεις/AndroidManifest$counter.xml
    cd ..
    mv AndroidManifest$counter.xml $basenamefile.AndroidManifest.xml
    rm -rf $basenamefile
   
    let counter=counter+1
    




    echo "$(grep "uses-permission android:name=" $basenamefile.AndroidManifest.xml | sed 's/uses-permission android:name=//g')" > manifest-tmp.txt
    echo "$(sed 's/[<:>/ "]//g' manifest-tmp.txt)" > $basenamefile.manifest.uses-permission.txt

    mv $basenamefile.manifest.uses-permission.txt uses-permission/$basenamefile.manifest.uses-permission.txt

    
    echo "$(grep "permission android:name=" $basenamefile.AndroidManifest.xml | sed 's/permission android:name=//g')" > manifest-tmp.txt
    echo "$(sed 's/[<:>/ "]//g' manifest-tmp.txt)" > $basenamefile.manifest.permission.txt

    mv $basenamefile.manifest.permission.txt permission/$basenamefile.manifest.permission.txt

    
    echo "$(grep "permission-tree android:name=" $basenamefile.AndroidManifest.xml | sed 's/permission-tree android:name=//g')" > manifest-tmp.txt
    echo "$(sed 's/[<:>/ "]//g' manifest-tmp.txt)" > $basenamefile.manifest.permission-tree.txt

    mv $basenamefile.manifest.permission-tree.txt permission/$basenamefile.manifest.permission-tree.txt
    

    echo "$(grep "permission-group android:name=" $basenamefile.AndroidManifest.xml | sed 's/permission-group android:name=//g')" > manifest-tmp.txt
    echo "$(sed 's/[<:>/ "]//g' manifest-tmp.txt)" > $basenamefile.manifest.permission-group.txt

    mv $basenamefile.manifest.permission-group.txt permission-group/$basenamefile.manifest.permission-group.txt
  
    echo "$(grep "grant-uri-permission android:name=" $basenamefile.AndroidManifest.xml | sed 's/grant-uri-permission android:name=//g')" > manifest-tmp.txt
    echo "$(sed 's/[<:>/ "]//g' manifest-tmp.txt)" > $basenamefile.manifest.grant-uri-permission.txt

    mv $basenamefile.manifest.grant-uri-permission.txt grant-uri-permission/$basenamefile.manifest.grant-uri-permission.txt

    echo "$(grep "uses-permission-sdk-23 android:name=" $basenamefile.AndroidManifest.xml | sed 's/uses-permission-sdk-23 android:name=//g')" > manifest-tmp.txt
    echo "$(sed 's/[<:>/ "]//g' manifest-tmp.txt)" > $basenamefile.manifest.uses-permission-sdk-23.txt

    mv $basenamefile.manifest.uses-permission-sdk-23.txt uses-permission-sdk-23/$basenamefile.manifest.uses-permission-sdk-23.txt
    
    mv $basenamefile.AndroidManifest.xml AndroidManifestFiles/$basenamefile.AndroidManifest.xml

    rm manifest-tmp.txt
    
done


