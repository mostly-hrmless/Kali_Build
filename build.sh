###########################################
##### Leidos Cyber                    #####
###########################################
##### PCN Pentesting System Build     #####
##### Tested using Kali Linux v2018.2 #####
##### Last Updated 9 July 2018        #####
###########################################

#!/bin/bash

#initial commands
apt-get clean && apt-get update && apt-get upgrade -y

#VMWare guest tools
apt-get install -y open-vm-tools*

#basic installs
apt-get install -y unace rar p7zip-rar htop terminator strace chromium zmap lynx
pip install selenium

#install deps for Nessus parser
apt-get install -y perl* libxml-treepp-perl libmath-round-perl libtest-deep-fuzzy-perl libexcel-writer-xlsx-perl libdata-table-perl

#remove pre-installed programs
apt-get remove -y responder

#Configure SSH

#Remove default SSH server keys
cd /etc/ssh/
mkdir default_kali_keys
mv ssh_host_* default_kali_keys/
#Generate new SSH server keys
dpkg-reconfigure openssh-server
#Enable SSH key authentication
echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config
echo 'AuthorizedKeysFile     /root/.ssh/authorized_keys' >> /etc/ssh/sshd_config
echo 'PermitRootLogin without-password' >> /etc/ssh/sshd_conf
mkdir /root/.ssh
touch /root/.ssh/authorized_keys

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
wget https://github.com/BloodHoundAD/BloodHound/releases/download/1.5.2/BloodHound-linux-x64.zip
unzip BloodHound-linux-x64.zip
cd BloodHound-linux-x64
chmod +x BloodHound

#GitHub Atom
mkdir /opt/atom
cd /opt/atom
wget https://github.com/atom/atom/releases/download/v1.28.1/atom-amd64.deb
dpkg -i atom-amd64.deb

#Add antivirus scan script
mkdir /root/Scripts
touch /root/Scripts/virus_scan.sh

echo "#Update Sophos" >> /root/Scripts/virus_scan.sh
echo "/opt/sophos-av/bin/savupdate" >> /root/Scripts/virus_scan.sh
echo " " >> /root/Scripts/virus_scan.sh
echo "#Scan filesystem" >> /root/Scripts/virus_scan.sh
echo "#Exclude list:" >> /root/Scripts/virus_scan.sh
echo "#/mnt/hgfs" >> /root/Scripts/virus_scan.sh
echo "#/opt" >> /root/Scripts/virus_scan.sh
echo "#/run/systemd/dynamic-uid" >> /root/Scripts/virus_scan.sh
echo "#/usr/bin/iaxflood" >> /root/Scripts/virus_scan.sh
echo "#/usr/bin/rtpflood" >> /root/Scripts/virus_scan.sh
echo "#/usr/bin/scan-view" >> /root/Scripts/virus_scan.sh
echo "#/usr/bin/scan-build" >> /root/Scripts/virus_scan.sh
echo "#/usr/bin/clang-check" >> /root/Scripts/virus_scan.sh
echo "#/usr/bin/rtpflood" >> /root/Scripts/virus_scan.sh
echo "#/usr/bin/clang-query" >> /root/Scripts/virus_scan.sh
echo "#/usr/bin/c-index-test" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/exploitdb" >> /root/Scripts/virus_scan.sh
echo "#/usr/bin/clang-apply-replacements" >> /root/Scripts/virus_scan.sh
echo "#/usr/bin/sancov" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/beef-xss" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/sqlninja" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/set/src/webattack" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/javasnoop" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/doc/libkeybinder-3.0-0" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/doc/sniffjoke" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/davtest" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/webshells" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/metasploit-framework" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/u3-pwn" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/windows-binaries" >> /root/Scripts/virus_scan.sh
echo "#/usr/share/wce" >> /root/Scripts/virus_scan.sh
echo "/opt/sophos-av/bin/savscan -exclude /mnt/hgfs /opt /run/systemd/dynamic-uid /usr/bin/iaxflood /usr/bin/rtpflood /usr/bin/scan-view /usr/bin/scan-build /usr/bin/clang-check  /usr/bin/rtpflood /usr/bin/clang-query /usr/bin/c-index-test /usr/share/exploitdb /usr/bin/clang-apply-replacements /usr/bin/sancov /usr/share/beef-xss /usr/share/sqlninja /usr/share/set/src/webattack /usr/share/javasnoop /usr/share/doc/libkeybinder-3.0-0 /usr/share/doc/sniffjoke /usr/share/davtest /usr/share/webshells /usr/share/metasploit-framework /usr/share/u3-pwn /usr/share/windows-binaries /usr/share/wce -include /" >> /root/Scripts/virus_scan.sh

#Add shared folder mount script
touch /root/Scripts/vm_share_mount.sh

echo "#!/bin/bash" >> /root/Scripts/vm_share_mount.sh
echo "mount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other" >> /root/Scripts/vm_share_mount.sh

echo
echo "Download and install Sophos AV for Linux before use"
echo "Installed tools can be found in /opt"
echo "Wordlists are located in /usr/share/wordlists"