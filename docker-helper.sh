#!/bin/bash

#CONFIG
dirName="${PWD##*/}"
prefix="vestra_"
testEnv="test.env"
runEnv="run.env"
defaultEnv=".env"

#DO NOT CHANGE
composePath=""
command=""
execCommand=""
versionPrefix=""
chosenEnv=""

function selectEnvOrDefault() {
    #$1 - envName
    if [ -f ./$1 ]; then
        chosenEnv="$1"
        return;
    fi
    echo "Cannot find $1, setting env to default: $defaultEnv"
    chosenEnv="$defaultEnv"
}

clear
echo "Select version: "
select yn in "docker-run" "codeception-run" "codeception-run-tests" "prod"; do
    case $yn in
        docker-run ) composePath="docker-run/docker-compose.yml"; versionPrefix="docker_run_"; selectEnvOrDefault $runEnv; break;;
        codeception-run ) composePath="docker-codeception-run/docker-compose.yml"; versionPrefix="docker_codeception_run_"; selectEnvOrDefault $testEnv; break;;
        codeception-run-tests ) composePath="docker-codeception-run/docker-compose.test.yml"; versionPrefix="docker_codeception_run_tests_"; selectEnvOrDefault $testEnv; break;;
        prod ) composePath="docker-compose.yml";  versionPrefix="prod_"; selectEnvOrDefault $defaultEnv; break;;
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
execCommand="docker-compose -p $prefix$versionPrefix$dirName --env-file $chosenEnv -f $composePath $command";
echo $execCommand
eval $execCommand
