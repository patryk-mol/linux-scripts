#!/bin/sh

SCRIPT_DIR="$(dirname $0)"

if [[ $(uname -a) == *"arch"* ]]; then
  sh $SCRIPT_DIR/update-arch.sh
elif [[ $(uname -a) == *"debian"* ]]; then
  sh $SCRIPT_DIR/update-debian.sh
else
  echo "Unknown distro"
fi
