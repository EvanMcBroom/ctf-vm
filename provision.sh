#!/bin/bash

# Updates
sudo dpkg --add-architecture i386
sudo apt-get -y update
DEBIAN_FRONTEND=noninteractive sudo -E apt-get -y upgrade

# Basic utilities
sudo apt-get -y install binutils-multiarch build-essential
sudo apt-get -y install cmake curl
sudo apt-get -y install gdb gdb-multiarch
sudo apt-get -y install foremost
sudo apt-get -y install htop
sudo apt-get -y install libc6-dbg libc6-dev-i386 libc6-i386 libffi-dev libssl-dev
sudo apt-get -y install nasm
sudo apt-get -y install python3 python3-dev python3-pip
sudo apt-get -y install tmux
sudo apt-get -y install unzip
sudo apt-get -y install vim
sudo apt-get -y install python-is-python3 python3-pip python3-virtualenv python3-virtualenvwrapper
sudo apt-get -y install 7zip

# 32 bit libs
# Source: https://wiki.debian.org/Multiarch/HOWTO
sudo apt-get -y install libc6:i386 libc6-dbg:i386 libncurses5:i386 libstdc++6:i386

# Update pip
python3 -m pip install --upgrade --break-system-packages pip

# Qemu and other requirements for cross compiling, running, and debugging:
# - i386
# - mips little endian
# - arm 32 bit with floating-point instructions
# - arm 64 bit
# Source: http://reverseengineering.stackexchange.com/questions/8829/cross-debugging-for-mips-elf-with-qemu-toolchain
sudo apt-get -y install binfmt-support
sudo apt-get -y install gcc-multilib g++-multilib # Does not include mips or arm
sudo apt-get -y install gcc-mipsel-linux-gnu gcc-arm-linux-gnueabihf g++-mipsel-linux-gnu g++-arm-linux-gnueabihf
sudo apt-get -y install libc6-i386-cross libc6-mipsel-cross libc6-armhf-cross libc6-arm64-cross
sudo apt-get -y install qemu-utils qemu-user qemu-user-static
sudo mkdir /etc/qemu-binfmt
sudo ln -s /usr/aarch64-linux-gnu /etc/qemu-binfmt/aarch64
sudo ln -s /usr/mipsel-linux-gnu /etc/qemu-binfmt/mipsel
sudo ln -s /usr/arm-linux-gnueabihf /etc/qemu-binfmt/arm

# Fix urllib3 InsecurePlatformWarning
sudo python3 -m pip install --upgrade --break-system-packages urllib3[secure]

# My dotfiles
git clone https://github.com/EvanMcBroom/dotfiles
./dotfiles/setup.sh apply
sudo ./dotfiles/setup.sh apply
rm -rf dotfiles

# My scripts
python3 -m pip install --break-system-packages git+https://github.com/EvanMcBroom/scripts
sudo python3 -m pip install --break-system-packages git+https://github.com/EvanMcBroom/scripts

cd # ~/
mkdir tools
pushd tools

# angr
virtualenv angr
source angr/bin/activate
python3 -m pip install angr
deactivate

# binwalk
sudo apt-get -y install libfontconfig1-dev liblzma-dev
git clone https://github.com/ReFirmLabs/binwalk
pushd binwalk
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. $HOME/.cargo/env
cargo build --release
sudo cp ./target/release/binwalk /usr/local/bin/
popd

# capstone
sudo apt-get -y install capstone-tool libcapstone4 libcapstone-dev python3-capstone

# fixenv
wget https://raw.githubusercontent.com/hellman/fixenv/master/r.sh
mv r.sh fixenv
chmod +x fixenv
sudo cp fixenv /usr/local/bin/

# frida
virtualenv frida
source frida/bin/activate
python3 -m pip install frida frida-tools
deactivate

# fzf
git clone --depth 1 https://github.com/junegunn/fzf ~/.fzf
~/.fzf/install --key-bindings --completion --update-rc

# jc
sudo python3 -m pip install --break-system-packages jc

# goodasm
sudo apt-get -y install qt6-base-dev qt6-declarative-dev
git clone https://github.com/travisgoodspeed/goodasm
mkdir goodasm/builds
pushd goodasm/builds
cmake ..
make -j 8 clean all
sudo cp goodasm /usr/local/bin/
popd

# libnum
git clone https://github.com/hellman/libnum
pushd libnum
sudo python3 -m pip install --break-system-packages libnum
popd

# one_gadget
sudo apt-get -y install ruby-full
sudo gem install one_gadget

# preeny
sudo apt-get -y install libini-config-dev libseccomp-dev
git clone https://github.com/zardus/preeny
pushd preeny
make
popd

# pwntools
python3 -m pip install --break-system-packages pwntools

# pwndbg
curl -qsL 'https://install.pwndbg.re' | sh -s -- -t pwndbg-gdb

# radare2
git clone https://github.com/radareorg/radare2
radare2/sys/install.sh

# ropper
python3 -m pip install --break-system-packages filebytes ropper

# xortool
python3 -m pip install --break-system-packages xortool

# xrop
git clone --recurse-submodules https://github.com/acama/xrop.git
pushd xrop
make
sudo make install
popd

# z3
sudo apt-get -y install python3-z3 z3

popd # ~/
