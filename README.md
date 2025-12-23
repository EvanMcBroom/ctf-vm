# Ctf VM

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

This is a VM for playing CTFs on Windows.
The VM uses Hyper-V as its hypervisor and is provisioned by Vagrant.
If your host is instead Linux or OSX, checkout [EpicTreasure](https://github.com/ctfhacker/EpicTreasure) or [pwnvm](https://github.com/OpenToAllCTF/pwnvm).  

After you setup Hyper-V<sup>1</sup> and install Vagrant<sup>2</sup>, you can run the VM in an Administrator command prompt with just

```bash
git clone https://github.com/EvanMcBroom/ctf-vm && cd ctf-vm
vagrant up
vagrant ssh
```
When prompted to choose a network switch, choose "_Default Switch_".
Also, when prompted for your username and password, use the credentials of the currently logged on user (e.g. `echo %USERNAME%`).
If you logged on using a Microsoft account, your Microsoft account password will be the same as your local account password, but will be different than your PIN.<sup>3</sup>
Vagrant will then provision the VM, which will take about 20 minutes.

### Notes
<sup>1</sup> Here is Microsoft's guide to "[install Hyper-V](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v)."  
<sup>2</sup>
Here is the page to [download Vagrant](https://www.vagrantup.com/downloads).   
<sup>3</sup> 
Here is more information on the Windows PIN for [Windows Hello](https://www.microsoft.com/en-us/windows/tips/windows-hello) and [Windows Hello for Business](https://docs.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-why-pin-is-better-than-password).
