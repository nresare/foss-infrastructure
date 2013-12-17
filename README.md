= Spotify's free software infrastructure setup

This project contains files and instructions on how our FOSS (Free / Open Source Software)
infrastructure is set up. It's a few AWS hosts providing services like automated 
unit testing and normalized builds for our Free Software.


== Spawning machines

* Use the io-foss@spotify.com account.
* Make sure you spawn machines in the 192.168.192.0/18 VPC to have private network
  interoperability with the already existing instances.
* Use the Ubuntu 13.10 64 bit AMI
* Once you're up and logged in, update packages: # aptitude update && aptitude safe-upgrade
* When the kernel gets updated it opts for keeping the system /boot/grub/menu.lst, you should instead opt for the package maintainer's version.

== Setting up puppet

* aptitude install puppet
* git clone 
