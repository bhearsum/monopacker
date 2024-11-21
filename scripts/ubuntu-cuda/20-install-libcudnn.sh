#!/bin/bash

set -exv

# init helpers
helpers_dir=${MONOPACKER_HELPERS_DIR:-"/etc/monopacker/scripts"}
for h in ${helpers_dir}/*.sh; do
    . $h;
done

# see https://developer.nvidia.com/cudnn
# steps from https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html
#   alternate resource: https://gist.github.com/valgur/fcd72fcdf5db81a826f8ff9802621d75

# official steps

UBUNTU_RELEASE=$(lsb_release -rs) # 18.04
DISTRO=ubuntu${UBUNTU_RELEASE//\./} # ubuntu1804

wget https://developer.download.nvidia.com/compute/cuda/repos/${DISTRO}/x86_64/cuda-${DISTRO}.pin 

sudo mv cuda-${DISTRO}.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/${DISTRO}/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/${DISTRO}/x86_64/ /"
sudo apt-get update

sudo apt-get -y install cudnn9-cuda-12
sudo apt-get -y install libcudnn9-dev-cuda-12