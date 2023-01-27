#! /bin/sh

OS=$(uname -sr)
SUCCESS_STR="Success: all packages are installed properly"
WARNING_STR="Warning: some package(s) cannot be installed properly"

case $OS in
  *WSL*)
    echo "Windows Subsystem for Linux is detected"
    docker-compose up -d win && sleep 3 && docker ps -l \
    | grep -q "(healthy)" && echo $SUCCESS_STR || echo $WARNING_STR
    docker rm $(docker ps -lq) -f > /dev/null
    ;;
  Darwin*)
    echo "macOS is detected"
    docker-compose up -d mac && sleep 3 && docker ps -l \
    | grep -q "(healthy)" && echo $SUCCESS_STR || echo $WARNING_STR
    docker rm $(docker ps -lq) -f > /dev/null
    ;;
  *)
    echo "Your OS is unsupported in this script; GUI features and some mounts are unavailable"
    docker-compose up -d others && sleep 3 && docker ps -l \
    | grep -q "(healthy)" && echo $SUCCESS_STR || echo $WARNING_STR
    docker rm $(docker ps -lq) -f > /dev/null
    ;;
esac
