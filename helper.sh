dirName="${PWD##*/}"
composePath="";
command="";
execCommand=""

clear
echo "Select version: "
select yn in "docker-run" "codeception-run" "codeception-run-tests" "prod"; do
    case $yn in
        docker-run ) composePath="docker-run/docker-compose.yml"; break;;
        codeception-run ) composePath="docker-codeception-run/docker-compose.yml"; break;;
        codeception-run-tests ) composePath="docker-codeception-run/docker-compose.test.yml"; break;;
        prod ) composePath="docker-compose.yml"; break;;
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
execCommand="docker-compose -p $dirName -f $composePath $command";
echo $execCommand
eval $execCommand