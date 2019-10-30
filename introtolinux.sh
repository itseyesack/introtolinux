sudo apt install openssh-server
sudo systemctl enable ssh
sudo cd /etc/network/
sudo rm interfaces
wget https://raw.githubusercontent.com/mrgooglegeek/introtolinux/master/interfaces
sudo /etc/init.d/networking restart
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT 1 -i lo -j ACCEPT
sudo iptables -A INPUT -j DROP
sudo groupadd -g grad
sudo groupadd -g ugrad
sudo groupadd -g staff
sudo useradd -d /home/grad -m user1
sudo useradd -d /home/ugrad -m user2
sudo useradd -d /home/staff -m -G {sudo} user3
sudo usermod -g grad user1
sudo usermod -g ugrad user2
sudo usermod -g staff user3
cd /home
sudo chgrp grad /grad
sudo chgrp ugrad /ugrad
sudo mkdir everyone
sudo chmod 1755 ./everyone
sudo apt install tasksel
sudo tasksel install lamp-server
cd /var/www/html/
wget https://raw.githubusercontent.com/mrgooglegeek/introtolinux/master/config.php
wget https://raw.githubusercontent.com/mrgooglegeek/introtolinux/master/index.php
wget https://raw.githubusercontent.com/mrgooglegeek/introtolinux/master/login.php
wget https://raw.githubusercontent.com/mrgooglegeek/introtolinux/master/logout.php
wget https://raw.githubusercontent.com/mrgooglegeek/introtolinux/master/register.php
wget https://raw.githubusercontent.com/mrgooglegeek/introtolinux/master/reset-password.php
wget https://raw.githubusercontent.com/mrgooglegeek/introtolinux/master/welcome.php
cd /tmp/
wget https://raw.githubusercontent.com/mrgooglegeek/introtolinux/master/makesql.sh
sudo chmod 755 makesql.sh
sudo ./makesql.sh CS root root
mysql --user="root" --password="root" --database="CS" --execute="CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);"
echo "done"
