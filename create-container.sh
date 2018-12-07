for i in {1..4}
do
	lxc-create -n C$i -t download -- -d alpine -r 3.4 -a armhf
done

echo "Done"
