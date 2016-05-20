#!/usr/bin/env bash

# configure hosts file for our internal network defined by Vagrantfile
cat << EOF >> /etc/hosts

# vagrant environment nodes
10.0.0.2  mgmt
10.0.0.11  lb1
10.0.0.12  lb2
10.0.0.21  web1
10.0.0.22  web2
10.0.0.23  web3
10.0.0.24  web4
10.0.0.25  web5
10.0.0.26  web6
10.0.0.27  web7
10.0.0.28  web8
10.0.0.29  web9
EOF

# install ansible (http://docs.ansible.com/intro_installation.html)
sudo yum install epel-release -y
sudo yum install ansible -y

# copy examples into /opt/ansible
mv /home/vagrant/sync/ansible.tar.gz /opt
cd /opt
tar -xvzf ansible.tar.gz
chown -R vagrant:vagrant /opt/ansible
rm ansible.tar.gz

if [ ! -f /home/vagrant/.ssh/id_rsa.pub ]; then
  ssh-keygen -f /home/vagrant/.ssh/id_rsa -t rsa -b 2048 -N ''
fi
  
  # keyscan all hosts
if [ ! -f /home/vagrant/.ssh/known_hosts ]; then
  ssh-keyscan lb1 web1 web2 >> /home/vagrant/.ssh/known_hosts
fi

# establish first ssh with all hosts
cd /opt/ansible
su -c "sshpass -p vagrant ansible all -m ping --ask-pass" vagrant
su -c "ansible-playbook ssh-addkey.yml" vagrant
