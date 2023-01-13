#! /bin/sh

SUBCOMMAND="$1"
shift

case $SUBCOMMAND in
  win)
    docker-compose up wslg -d && sleep 3 && docker ps -l \
    | grep "(healthy)" || echo "Warning: some package(s) cannot be installed properly"
    ;;
  mac)
    docker-compose up mac -d && sleep 3 && docker ps -l \
    | grep "(healthy)" || echo "Warning: some package(s) cannot be installed properly"
    ;;
  *)
    echo "The supplied subcommand is invalid"
    exit 1
    ;;
esac
