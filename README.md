# Linux Portfolio 2
 Group Number: 27
 Group Name: Helloworld 

# How to replicate solution:
**1) First unpriveleged containers are started:**<br />
	$ lxc-create -n C1 -t download -- -d alpine -r 3.4 -a armhf<br />
	$ lxc-create -n C2 -t download -- -d alpine -r 3.4 -a armhf<br />

**2) Neccessary packages are installed:**<br />
	$ lxc-attach -n C1 -- apk update<br />
	$ lxc-attach -n C1 -- apk add lighttpd php5 php5-cgi php5-curl php5-fpm nano<br />

	$ lxc-attach -n C2 -- apk update<br />
	$ lxc-attach -n C2 -- apk add bash nano<br />

**3)  The bridge interface is now configured**<br />
	$ cd /etc/lxc<br />
	$ sudo vim default.conf<br />
	* Add the following lines*<br />
	lxc.network.type = veth<br />
	lxc.network.link = lxcbr0<br />
	lxc.network.flags = up<br />
	lxc.network.hwaddr = 00:16:3e:xx:xx:xx<br />

	$ cd /etc/default<br />
	$ sudo vim lxc-net<br />
	* Add the following line*<br />
	USE_LXC_BRIDGE="true"<br />
	
	*Restart the lxc-net service*<br />
	$ sudo systemctl restart lxc-net<br />
	$ systemctl status lxc-net<br />

	

**4) Static IP adresses are assigned**<br />
	$ cd /etc/lxc<br />
	$ sudo vim dhcp.conf<br />
	*Add the following lines*<br />
	dhcp-host=C1,10.0.3.11<br />
	dhcp-host=C2,10.0.3.12<br />


**5) Changes inside C1 is now performed:**<br />
	*Start the container, C1*<br />
	$ lxc-start -n C1<br />

	$ lxc-attach -n C1<br />
	*Navigate inside /etc/lighttpd/lighttpd.conf *<br />
	$ cd /etc/lighttpd<br />
	$ nano lighttpd.conf<br />
	* mod_fastcgi.conf is uncommented *<br />
	* The port to show the lighttpd webpage is changed to port 8080 *<br />
	* The lighttpd service is now started *<br />
	$ rc-update add lighttpd default<br />
	$ openrc<br />
	* The port is now scanned, to verify that the webpage is outputted *<br />
	$ exit<br />
	$ nmap 10.0.3.11<br />
	

