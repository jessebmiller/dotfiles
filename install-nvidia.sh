#!/bin/bash

set -e

sudo snapper -c root create --description "installing nvidia"
sudo dnf update -y
sudo dnf install -y akmod-nvidia

echo "run 'modinfo -F vesrion nvidia' until it lists the module, which is being compiled in the background"
echo "you'll need to disable secure boot or figure out how to sign the module"
