# Linux Portfolio 2
 Group Number: 27
 Group Name: Helloworld 

# How to replicate solution:
**1) First unpriveleged containers are started:**<br />

	$ lxc-create -n C1 -t download -- -d alpine -r 3.4 -a armhf
	$ lxc-create -n C2 -t download -- -d alpine -r 3.4 -a armhf

**2) Neccessary packages are installed:**<br />

	$ lxc-attach -n C1 -- apk update
	$ lxc-attach -n C1 -- apk add lighttpd php5 php5-cgi php5-curl php5-fpm nano

	$ lxc-attach -n C2 -- apk update
	$ lxc-attach -n C2 -- apk add bash nano

**3)  The bridge interface is now configured**<br />

	$ cd /etc/lxc
	$ sudo vim default.conf
	* Add the following lines *
	lxc.network.type = veth
	lxc.network.link = lxcbr0
	lxc.network.flags = up
	lxc.network.hwaddr = 00:16:3e:xx:xx:xx

	$ cd /etc/default
	$ sudo vim lxc-net
	* Add the following line *
	USE_LXC_BRIDGE="true"
	
	* Restart the lxc-net service *
	$ sudo systemctl restart lxc-net
	$ systemctl status lxc-net

	

**4) Static IP adresses are assigned**<br />

	$ cd /etc/lxc
	$ sudo vim dhcp.conf
	* Add the following lines *
	dhcp-host=C1,10.0.3.11
	dhcp-host=C2,10.0.3.12


**5) Changes inside C1 is now performed:**<br />

	* Start the container, C1 *
	$ lxc-start -n C1
	$ lxc-attach -n C1
	*Navigate inside /etc/lighttpd/lighttpd.conf *
	$ cd /etc/lighttpd
	$ nano lighttpd.conf
	* mod_fastcgi.conf is uncommented *
	* The port to show the lighttpd webpage is changed to port 8080 *
	* The lighttpd service is now started *
	$ rc-update add lighttpd default
	$ openrc
	* The port is now scanned, to verify that the webpage is outputted *
	$ exit
	$ nmap 10.0.3.11
	

