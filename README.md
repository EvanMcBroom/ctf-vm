# CtfVM

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

This is the VM I use for playing CTFs on Windows. The VM uses Hyper-V as its hypervisor and is provisioned by Vagrant. If your host is instead Linux or OSX, checkout [EpicTreasure](https://github.com/ctfhacker/EpicTreasure) or [pwnvm](https://github.com/OpenToAllCTF/pwnvm).  

After you setup Hyper-V<sup>1</sup> and install Vagrant<sup>2</sup>, you can run the VM with just

```bash
git clone https://github.com/EvanMcBroom/CtfVM && cd CtfVM
vagrant up
vagrant ssh
```
When prompted to choose a network switch, choose "_Default Switch_". Also, when prompted for your username and password, use the currently logged in user (`echo %USERNAME%`) and your Microsoft account password.<sup>3</sup>  

### Notes
<sup>1</sup> Here is Microsoft's guide to "_[Install Hyper-V on Windows 10](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v)._"  
<sup>2</sup>
Here is the page to [download Vagrant](https://www.vagrantup.com/downloads.html).   
<sup>3</sup> Your Microsoft account password should be the same as your local account password, but will be different than your PIN. Here is more information on the [Windows 10 PIN](https://docs.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-why-pin-is-better-than-password).