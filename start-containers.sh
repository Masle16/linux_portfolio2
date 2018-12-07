for i in {1..2}
do
	lxc-start -n C$i
done

echo "Started all"
