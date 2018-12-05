# Linux Portfolio 2
 Group Number: **27**<br />
 Group Name: **Helloworld**<br />

# How to replicate the solution:
**1) First unpriveleged containers are started:**<br />

	$ lxc-create -n C1 -t download -- -d alpine -r 3.4 -a armhf
	$ lxc-create -n C2 -t download -- -d alpine -r 3.4 -a armhf

**2) Neccessary packages are installed:**<br />

	$ lxc-attach -n C1 -- apk update
	$ lxc-attach -n C1 -- apk add lighttpd php5 php5-cgi php5-curl php5-fpm nano

	$ lxc-attach -n C2 -- apk update
	$ lxc-attach -n C2 -- apk add bash nano socat

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
	* Navigate inside /etc/lighttpd/lighttpd.conf *
	$ cd /etc/lighttpd
	$ nano lighttpd.conf
	* mod_fastcgi.conf is uncommented *
	* The port to show the lighttpd webpage is changed to port 8080 *
	
	* Configure an index page *
	$ cd /var/www/localhost/htdocs	
	$ nano index.php
	* Add the following inside the index.php: *
	<!DOCTYPE html>
	<html><body><pre>
		<?php 
        		// create curl resource 
        		$ch = curl_init(); 
        		// set url 
        		curl_setopt($ch, CURLOPT_URL, "C2:8080"); 
        		//return the transfer as a string 
        		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
        		// $output contains the output string 
        		$output = curl_exec($ch); 
        		// close curl resource to free up system resources
        		curl_close($ch);
        		print $output;
		?>
	</body></html>

	* The lighttpd service is now started *
	$ rc-update add lighttpd default
	$ openrc
	* The port is now scanned, to verify that the webpage is outputted *
	$ exit
	$ nmap 10.0.3.11

**6) Changes inside C2 is now performed:**<br />

	* Install the randomness service *
	$ lxc-start -n C2
	$ lxc-attach -n C2
	$ cd /bin
	$ nano rng.sh
	* Add the following *
	#!/bin/bash

	dd if=/dev/random bs=4 count=16 status=none | od -A none -t u4
	* Serve the script *
	$ socat -v -v tcp-listen:8080,fork,reuseaddr exec:/bin/rng.sh

**7) Verify the assignment of static IP**

	$ lxc-ls -f

**8) Route a port on the Raspberry Pi to a container**

	$ iptables -t nat -A PREROUTING -i wlan0 -p tcp --dport 80 -j DNAT --to-destination 10.0.3.11:8080

**9) Verify results**

	Open a browser and navigate to:
	<raspberrypi-ip>:80	->	10.126.53.171:80
