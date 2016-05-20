# ansible

using ansible to deploy lb and webservers in virtualbox+vagrant

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisities

What things you need to install the software and how to install them

```
mobaxterm (cygwin) 8.6 - http://mobaxterm.mobatek.net/download-home-edition.html
vagrant 1.8.1 - https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1.msi
virtualbox 5.0.16 - http://download.virtualbox.org/virtualbox/5.0.16/VirtualBox-5.0.16-105871-Win.exe 
```

# Tweaks

###VAGRANT RSYNC doesnt work out of the box for windows
-remove the follow in the below file
/drives/c/HashiCorp/Vagrant/embedded/gems/gems/vagrant-1.8.1/plugins/synced_folders/rsync/helper.rb
```
"-o ControlMaster=auto " +
"-o ControlPath=#{controlpath} " +
"-o ControlPersist=10m " +
```
###VAGRANT SSH doesnt work out of the box for windows
use ssh.sh bash script instead
-ex: ssh.sh ans

#mobaxterm - edit settings in mobaxterm to use Windows PATH:
check use WINDOWS PATH Env

### Deploy Infrastructure 

deploy virtual machines with vagrant

```
vagrant up
```

## Test Vagrant

The ansible server (ans) has been bootstratped with the following
- edit hosts file to contain ip address for lb1, web1 and web2
- host key for lb1, web1 and web2 are added to known_host in ans
- public key from ans is copied to lb1, web1 and web2 via ansible-playbook ssh-addkey.yml

To test the vagrant run the following in server ans
first ssh into ans server
'''
./ssh.sh ans
'''
change directory to ansible foler and ansible command to all hosts
'''
cd /opt/ansible
ansible -m all ping
'''

### Deploy webservers and loadbalance

using ansible playbook site.yml to deploy web1, web2 and lb1

```
cd /opt/ansible
ansible-playbook site.yml
```
verify by going to your desktop computer's web browser and enter http://localhost/












