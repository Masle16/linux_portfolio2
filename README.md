# Linux Portfolio 2
 Group Number: 27
 Group Name: Helloworld 

# How to replicate solution:
1) First unpriveleged containers are started:<br />
	$ lxc-create -n C1 -t download -- -d alpine -r 3.4 -a armhf__
	$ lxc-create -n C2 -t download -- -d alpine -r 3.4 -a armhf__

2) Neccessary packages are installed:__
	$ lxc-attach -n C1 -- apk update__
	$ lxc-attach -n C1 -- apk add lighttpd php5 php5-cgi php5-curl php5-fpm nano__

	$ lxc-attach -n C2 -- apk update__
	$ lxc-attach -n C2 -- apk add bash nano__

3) Changes inside C1 is now performed:__
	$ lxc-attach -n C1__
	-- Navigate inside /etc/lighttpd/lighttpd.conf --__
	$ cd /etc/lighttpd__
	$ nano lighttpd.conf__
	-- mod_fastcgi.conf is uncommented --__
	-- The port to show the lighttpd webpage is changed to port 8080 --__
	-- The lighttpd service is now started --__
	$ rc-update add lighttpd default__
	$ openrc__
	

