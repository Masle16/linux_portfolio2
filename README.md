# Linux Portfolio 2
 Group Number: 27
 Group Name: Helloworld 

# How to replicate solution:
1) First unpriveleged containers are started:<br />
	$ lxc-create -n C1 -t download -- -d alpine -r 3.4 -a armhf<br />
	$ lxc-create -n C2 -t download -- -d alpine -r 3.4 -a armhf<br />

2) Neccessary packages are installed:<br />
	$ lxc-attach -n C1 -- apk update<br />
	$ lxc-attach -n C1 -- apk add lighttpd php5 php5-cgi php5-curl php5-fpm nano<br />

	$ lxc-attach -n C2 -- apk update<br />
	$ lxc-attach -n C2 -- apk add bash nano<br />

3) Changes inside C1 is now performed:<br />
	$ lxc-attach -n C1<br />
	-- Navigate inside /etc/lighttpd/lighttpd.conf --<br />
	$ cd /etc/lighttpd<br />
	$ nano lighttpd.conf<br />
	-- mod_fastcgi.conf is uncommented --<br />
	-- The port to show the lighttpd webpage is changed to port 8080 --<br />
	-- The lighttpd service is now started --<br />
	$ rc-update add lighttpd default<br />
	$ openrc<br />
	

