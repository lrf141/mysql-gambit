#!/bin/sh

sharedLibName="ha_gambit.so"
seName="gambit"
fileStatus=`ls ./mysql-8.0.18/plugin_output_directory | grep $sharedLibName`

if [ $fileStatus != "" ]; then
    cp ./mysql-8.0.18/plugin_output_directory/$sharedLibName ./docker/mysql/plugin/$sharedLibName
    docker exec -it mysql cp /tmp/plugin/ha_gambit.so /usr/lib/mysql/plugin/ha_gambit.so
    docker exec -it mysql mysql -e "INSTALL PLUGIN gambit SONAME '${sharedLibName}'"
    docker exec -it mysql mysql -e "SHOW ENGINES"
fi
