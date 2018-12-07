for i in {1..2}
do
	lxc-stop -n C$i
done
echo "Stopped all"
