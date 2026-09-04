#!/bin/bash

case "$2" in

t1)
for(( i=0;i<$1;i++ ))do
	for(( j=0;j<$1-$i;j++ ))do
	echo -n " "
	done
	for(( k=0;k<=$i;k++ ))do
	echo -n "*"
	done
	echo
done
;;

t2)
for(( i=0; i<$1; i++ ))do
	for (( j=$i; j>=0; j-- ))do
	echo -n "*"
	done
	echo
done    ;;

t3)
for(( i=0;i<$1;i++ ))do
	for(( j=0;j<$1-i-1;j++ ))do
	echo -n " "
	done
	for(( k=0;k<=2*i;k++ ))do
	echo -n "*"
	done
	echo
done
;;



t4)
for(( i=0; i<$1; i++ ))do
	for (( j=$1; j>$i; j-- ))do
	echo -n "*"
	done
	echo
done
 ;;

t5)
for((i=0;i<$1;i++))do
	for((j=0;j<i;j++))do
	echo -n " "
	done
	for((k=0;k<$1-i;k++))do
	echo -n "*"
    	done
    	echo
done
;;

t6)
for (( i=$1; i>0; i-- ))
do
    	for (( j=$1; j>i; j-- ))
    	do
        echo -n " "
    	done

    	for (( k=0; k<2*i-1; k++ ))
    	do
        echo -n "*"
    	done
    	echo
done
;;

t7)
for(( i=0;i<$1;i++ ))do
	for(( j=0;j<$1-i-1;j++ ))do
	echo -n " "
	done
	for(( k=0;k<2*i+1;k++ ))do
	echo -n "*"
	done
	echo
	done

	for(( i=$1-2;i>=0;i-- ))do
	for(( j=0;j<$1-i-1;j++ ))do
	echo -n " "
	done
	for(( k=0;k<2*i+1;k++ ))do
	echo -n "*"
	done
	echo
done
;;

*)
esac
