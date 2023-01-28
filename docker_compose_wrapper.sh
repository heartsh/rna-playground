#! /bin/sh

OS=$(uname -sr)
SUCCESS_STR="Success: all packages are installed properly"
WARNING_STR="Warning: some package(s) cannot be installed properly"

sys="others"

case $OS in
  *WSL*)
    echo "Windows Subsystem for Linux is detected"
    sys="win"
    ;;
  Darwin*)
    echo "macOS is detected"
    sys="mac"
    ;;
  *)
    echo "Your OS is unsupported in this script; GUI features and some mounts are unavailable"
    ;;
esac

if false; then
  docker-compose up -d $sys && sleep 3 && docker ps -l \
  | grep -q "(healthy)" && echo $SUCCESS_STR || echo $WARNING_STR
  docker rm $(docker ps -lq) -f > /dev/null
fi
