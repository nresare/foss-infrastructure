# Spotify's free software infrastructure setup

This project contains files and instructions on how our FOSS (Free / Open Source Software)
infrastructure is set up. It's a few AWS hosts providing services like automated 
unit testing and normalized builds for our Free Software.

## Spawning machines

* Use the io-foss@spotify.com account.
* Make sure you spawn machines in the 192.168.192.0/18 VPC to have private network
  interoperability with the already existing instances.
* Use the Ubuntu 13.10 64 bit AMI
* Once you're up and logged in, update packages: `aptitude update && aptitude safe-upgrade`
* When the kernel gets updated it opts for keeping the system /boot/grub/menu.lst, you should instead opt for the package maintainer's version.

## Setting up puppet

* `aptitude install puppet git`
* `cd /var/lib`
* `git clone https://github.com/noaresare/foss-infrastructure`
* `cd /var/lib/foss-infrastructure/puppet`
* `puppet apply --modulepath ./modules builder.pp`


## Setting up jenkins

* The puppet class sets up jenkins to pull it's configuration from git (the repo https://github.com/noaresare/foss-jenkins-config) that it clones to /var/lib/foss-jenkins-config.git.
* For some reason you need to access the web UI and navigate to SCM Sync configuration and click "Reload config from SCM" and then restart jenkins with `initctl restart jenkins`
* Once that is done you need to log into the server to change configuration. Create a user and send your username to to foss-discuss@spotify.com to request access
* Changes to configuration should be pushed from the local git repo to one linked above at regular intervals
