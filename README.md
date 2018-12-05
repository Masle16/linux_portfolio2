# Linux Portfolio 2
 Group Number: 27
 Group Name: Helloworld 

# How to replicate solution:
1) First unpriveleged containers are started:
	$ lxc-create -n C1 -t download -- -d alpine -r 3.4 -a armhf
	$ lxc-create -n C2 -t download -- -d alpine -r 3.4 -a armhf

2) Neccessary packages are installed:
	$ lxc-attach -n C1 -- apk update
	$ lxc-attach -n C1 -- apk add lighttpd php5 php5-cgi php5-curl php5-fpm nano

	$ lxc-attach -n C2 -- apk update
	$ lxc-attach -n C2 -- apk add bash nano

3) Changes inside C1 is now performed:
	$ lxc-attach -n C1
	-- Navigate inside /etc/lighttpd/lighttpd.conf --
	$ cd /etc/lighttpd
	$ nano lighttpd.conf
	-- mod_fastcgi.conf is uncommented --
	-- The port to show the lighttpd webpage is changed to port 8080 --
	-- The lighttpd service is now started --
	$ rc-update add lighttpd default
	$ openrc
	

