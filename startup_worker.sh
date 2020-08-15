# !/bin/bash
sudo mkdir /root/.ssh
sudo echo ${var.private_key} > /root/.ssh/id_rsa
sudo echo ${var.public_key} > /root/.ssh/authorized_keys
i=`cat /etc/ssh/sshd_config | grep -n PermitRootLogin\ no | awk -F: '{print $1}'`
sudo sed -i "$i"d /etc/ssh/sshd_config
i=`cat /etc/ssh/sshd_config | grep -n \#PubkeyAuthentication\ yes | awk -F: '{print $1}'`
sudo sed -i "$i"d /etc/ssh/sshd_config
i=`cat /etc/ssh/sshd_config | grep -n PasswordAuthentication\ no | awk -F: '{print $1}'`
sudo sed -i "$i"d /etc/ssh/sshd_config

sudo echo -e "PermitRootLogin yes\nPubkeyAuthentication yes\nPasswordAuthentication yes" >> /etc/ssh/sshd_config

sudo systemctl restart sshd
