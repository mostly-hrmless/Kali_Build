#!/bin/bash

#Empire
cd /opt
git clone https://github.com/PowerShellEmpire/Empire.git
cd /opt/Empire/setup
./install.sh
#Need to press enter at password creation prompt for now.

#Veil-Evasion setup
cd /opt
git clone https://github.com/Veil-Framework/Veil.git
git clone https://github.com/Veil-Framework/PowerTools.git
cd /opt/Veil/setup
./setup.sh -s

#Responder Setup
cd /opt
git clone https://github.com/SpiderLabs/Responder.git
cd Responder
cp -r * /usr/bin

#Shell_Shocker Setup
cd /opt
git clone https://github.com/mubix/shellshocker-pocs.git

#Frogger Setup
cd /opt
git clone https://github.com/nccgroup/vlan-hopping.git

#DBeaver Setup
mkdir /opt/dbeaver
cd /opt/dbeaver
wget http://dbeaver.jkiss.org/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb

#Core Impact Impacket
cd /opt
git clone https://github.com/CoreSecurity/impacket.git

#Download Crackstation Human Wordlist
cd /usr/share/wordlists
wget https://crackstation.net/files/crackstation-human-only.txt.gz
gzip -d crackstation-human-only.txt.gz
#Full list can be downloaded here: https://crackstation.net/files/crackstation.txt.gz

#Bloodhound Setup
wget -O - https://debian.neo4j.org/neotechnology.gpg.key | sudo apt-key add -
echo 'deb http://debian.neo4j.org/repo stable/' | tee /etc/apt/sources.list.d/neo4j.list
echo "deb http://httpredir.debian.org/debian jessie-backports main" | tee -a /etc/apt/sources.list.d/jessie-backports.list
apt-get update
apt-get install openjdk-8-jdk openjdk-8-jre -y
apt-get install neo4j -y
cd /opt
git clone https://github.com/adaptivethreat/BloodHound.git
cd /opt/BloodHound
cp -R /var/lib/neo4j/data/databases/graph.db /var/lib/neo4j/data/databases/graph.db.bak
cp -R BloodHoundExampleDB.graphdb/* /var/lib/neo4j/data/databases/
neo4j restart
cd /opt/BloodHound
wget https://github.com/BloodHoundAD/BloodHound/releases/download/1.2.1/BloodHound-linux-x64.zip
unzip BloodHound-linux-x64.zip
cd BloodHound-linux-x64
chmod +x BloodHound

#GitHub Atom
mkdir /opt/atom
cd /opt/atom
wget https://github.com/atom/atom/releases/download/v1.16.0/atom-amd64.deb
dpkg -i atom-amd64.deb

#Important Stuff
gem install lolcat

echo
echo "Installed tools can be found in /opt"
echo "Wordlists are located in /usr/share/wordlists"
echo "Happy Pentesting!"

reboot
