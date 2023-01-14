#! /bin/sh

SUBCOMMAND="$1"
shift

case $SUBCOMMAND in
  win)
    docker-compose up -d win && sleep 3 && docker ps -l \
    | grep -q "(healthy)" || echo "Warning: some package(s) cannot be installed properly"
    docker rm $(docker ps -lq) -f > /dev/null
    ;;
  mac)
    docker-compose up -d mac && sleep 3 && docker ps -l \
    | grep -q "(healthy)" || echo "Warning: some package(s) cannot be installed properly"
    docker rm $(docker ps -lq) -f > /dev/null
    ;;
  *)
    echo "The supplied subcommand is invalid"
    exit 1
    ;;
esac
