#!/bin/bash
dirName="${PWD##*/}"
prefix="vestra_"
composePath="";
command="";
execCommand=""
versionPrefix=""

clear
echo "Select version: "
select yn in "docker-run" "codeception-run" "codeception-run-tests" "prod"; do
    case $yn in
        docker-run ) composePath="docker-run/docker-compose.yml"; versionPrefix="docker_run_"; break;;
        codeception-run ) composePath="docker-codeception-run/docker-compose.yml"; versionPrefix="docker_codeception_run_"; break;;
        codeception-run-tests ) composePath="docker-codeception-run/docker-compose.test.yml"; versionPrefix="docker_codeception_run_tests_"; break;;
        prod ) composePath="docker-compose.yml";  versionPrefix="prod_"; break;;
    esac
done
clear
echo "##############"
echo "SELECTED $yn ";
echo "##############"
printf '\n \n \n'

echo "Select command: "
select yn in "up" "down" "build" "up --build" "stop" "start"; do
    case $yn in
        up ) command="up -d"; break;;
        down ) command="down"; break;;
        build ) command="build"; break;;
        "up --build" ) command="up --build"; break;;
        stop ) command="stop"; break;;
        start ) command="start"; break;;
    esac
done
execCommand="docker-compose --env-file .env -p $prefix$versionPrefix$dirName -f $composePath $command";
echo $execCommand
eval $execCommand
