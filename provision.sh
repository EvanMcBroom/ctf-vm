#!/bin/bash

# Updates
sudo apt-get -y update
sudo apt-get -y upgrade

sudo apt-get -y install binutils-arm-linux-gnueabi
sudo apt-get -y install build-essential
sudo apt-get -y install htop
sudo apt-get -y install python-pip python3-pip
sudo apt-get -y install unzip unrar

# These are so the 64 bit vm can build 32 bit
sudo apt-get -y install libx32gcc-4.8-dev
sudo apt-get -y install libc6-dev-i386

# Enable 32bit binaries on 64bit host
sudo dpkg --add-architecture i386
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install libc6:i386 libc6-dbg:i386 libncurses5:i386 libstdc++6:i386

# my dotfiles
git clone https://github.com/EvanMcBroom/dotfiles
sudo ./dotfiles/setup.sh
rm -rf dotfiles

cd # ~/
mkdir tools
pushd tools

# angr
sudo apt-get -y install python-dev libffi-dev build-essential virtualenvwrapper
sudo pip install virtualenv
virtualenv angr
source angr/bin/activate
pip install angr --upgrade
deactivate

# binwalk
git clone https://github.com/devttys0/binwalk
pushd binwalk
sudo python setup.py install
popd

# capstone
git clone https://github.com/aquynh/capstone
pushd capstone
git checkout -t origin/next
sudo ./make.sh
sudo ./make.sh install
cd bindings/python
# install capstone 4.0
sudo python setup.py install
sudo python3 setup.py install # Ubuntu 14.04+, GDB uses Python3
popd

# fixenv
wget https://raw.githubusercontent.com/hellman/fixenv/master/r.sh
mv r.sh fixenv
chmod +x fixenv

# fzf
git clone --depth 1 https://github.com/junegunn/fzf ~/.fzf
~/.fzf/install --key-bindings --completion --update-rc

# libnum
git clone https://github.com/hellman/libnum
pushd libnum
sudo python setup.py install
popd

# one_gadget
sudo apt-get -y install ruby-full
sudo gem install one_gadget

# pwntools
sudo apt-get -y install python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
sudo pip install --upgrade pwntools

# pwndbg
git clone https://github.com/zachriggle/pwndbg
pushd pwndbg
sudo pip3 install pycparser
./setup.sh
popd

# QEMU and other things for compiling, running, and debugging MIPS/ARM
# http://reverseengineering.stackexchange.com/questions/8829/cross-debugging-for-mips-elf-with-qemu-toolchain
sudo apt-get -y install qemu qemu-user qemu-user-static
sudo apt-get -y install gdb gdb-multiarch
sudo apt-get -y install 'binfmt*'
sudo apt-get -y install libc6-mipsel-cross libc6-armhf-armel-cross libc6-arm64-cross
sudo apt-get install gcc-mipsel-linux-gnu gcc-arm-linux-gnueabihf
mkdir /etc/qemu-binfmt
ln -s /usr/mipsel-linux-gnu /etc/qemu-binfmt/mipsel
ln -s /usr/arm-linux-gnueabihf /etc/qemu-binfmt/arm

# radare2
wget https://github.com/radare/radare2/archive/2.6.0.tar.gz
tar xzvf 2.6.0.tar.gz
rm 2.6.0.tar.gz
pushd radare2-2.6.0/
./configure --prefix=/usr
make -j8
sudo make install
r2pm update
popd

# ropper
sudo pip install filebytes
sudo pip install ropper

# xortool
git clone https://github.com/hellman/xortool
pushd xortool
sudo pip install docopt
sudo python setup.py install
popd

# z3
git clone https://github.com/Z3Prover/z3
pushd z3
python scripts/mk_make.py --python
cd build
make
sudo make install
popd

popd # ~/
