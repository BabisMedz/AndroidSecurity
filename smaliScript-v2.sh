#!/bin/bash




APPS_DIR=/home/babis/apks/*

for f in $APPS_DIR

do
    
    file=$APPS_DIR
    apktool decode -f $f

   
done

for f in $APPS_DIR
do

  
    var=${f##*/}
    var2=${var%.apk}
    mkdir smaliFiles_$var2
    SMALI_DIR=/home/babis/Έγγραφα/Διπλωματική/diassemplyManifestScript/smaliFiles_$var2/*
    find . -name "*.smali" -type f -exec cp {} ./smaliFiles_$var2 \;
    
    cd smaliFiles_$var2
    
    find $SMALI_DIR -exec cat {} \; > smali-files-$var2.txt
    mv /home/babis/Έγγραφα/Διπλωματική/diassemplyManifestScript/smaliFiles_$var2/smali-files-$var2.txt  /home/babis/Έγγραφα/Διπλωματική/diassemplyManifestScript/smali-files-$var2.txt
    cd ..
        # var4=${var3%.smali}
    grep -i invoke smali-files-$var2.txt | sort | uniq > sort-uniq-output-ivnoke-$var2.txt
    sed s/[a-z]*[-][a-z]*//g sort-uniq-output-ivnoke-$var2.txt > out.1.$var2.txt
#remove spaces
   
     sed 's/ *//g' out.1.$var2.txt > out.2.$var2.txt
     sed 's/\/range//g' out.2.$var2.txt > out.3.$var2.txt
     sed 's/[{]\(\([a-zA-Z0-9]\)*[,]\)*[a-zA-Z0-9]*[}]//g' out.3.$var2.txt > out.4.$var2.txt
     sed 's/[,]//g' out.4.$var2.txt > out.5.$var2.txt
     sed 's/[{].*[.][.].*[}]//g' out.5.$var2.txt > out.6.$var2.txt
     sed 's/[/]/./g' out.6.$var2.txt > out.7.$var2.txt
     sed 's/^L//g' out.7.$var2.txt > out.8.$var2.txt
     sed 's/;$//g'  out.8.$var2.txt >out.9.$var2.txt
     sed 's/;)/)/g' out.9.$var2.txt > out.10.$var2.txt
     sed 's/;>/./g' out.10.$var2.txt > out.11.$var2.txt
     sed 's/;/,/g' out.11.$var2.txt > out.12.$var2.txt
     sed 's/)/) /g' out.12.$var2.txt > out.13.$var2.txt
     awk '{print $2 " " $1}' out.13.$var2.txt > out.14.$var2.txt
     sed 's/^L//g' out.14.$var2.txt > out.15.$var2.txt
     sed 's/^V/void/g' out.15.$var2.txt > out.16.$var2.txt
     sed 's/^I/int/g' out.16.$var2.txt > out.17.$var2.txt
     sed 's/^S/short/g' out.17.$var2.txt > out.18.$var2.txt
     sed 's/^Z/bool/g' out.18.$var2.txt > out.19.$var2.txt
     sed 's/^B/byte/g' out.19.$var2.txt > out.20.$var2.txt
     sed 's/^C/char/g' out.20.$var2.txt > out.21.$var2.txt
     sed 's/^J/long/g' out.21.$var2.txt > out.22.$var2.txt
     sed 's/^F/float/g' out.22.$var2.txt > out.23.$var2.txt
     sed 's/^D/float/g' out.23.$var2.txt > out.24.$var2.txt
     sed 's/^\[B/byte[]/g' out.24.$var2.txt > out.25.$var2.txt
     sed 's/^\[C/char[]/g' out.25.$var2.txt > out.26.$var2.txt
     sed 's/^\[I/int[]/g' out.26.$var2.txt > out.27.$var2.txt
     sed 's/^\[S/short[]/g' out.27.$var2.txt > out.28.$var2.txt
     sed 's/^\[Z/bool[]/g' out.28.$var2.txt > out.29.$var2.txt
     sed 's/^\[J/long[]/g' out.29.$var2.txt > out.30.$var2.txt
     sed 's/^\[F/float[]/g' out.30.$var2.txt > out.31.$var2.txt
     sed 's/^\[D/float[]/g' out.31.$var2.txt > out.32.$var2.txt

     mv out.32.$var2.txt smali-analysis-$var2.txt
     sed 's/^\S*//g' smali-analysis-$var2.txt | sed 's/ *//g' | sed 's/[(].*//g' > smali-analysis-names-$var2.txt
     rename 's/\.(?=.*\.)/_/g' smali-analysis-names-$var2.txt

    

    rm out.*.$var2.txt
    rm smali-files-$var2.txt
    rm sort-uniq-output-ivnoke-$var2.txt
    rm -rf smaliFiles_$var2
    rm -rf $var2


done
