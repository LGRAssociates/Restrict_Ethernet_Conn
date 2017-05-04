#!/bin/bash
WORK_LOOP=1
while [ WORK_LOOP=1 ]; do
    ifconfig | grep "inet" | grep -Fv 127.0.0.1 |awk '{print $2}' > ip.txt
    File=ip.txt  
    if grep -q 10.20.2 "$File"; ## searching for partial ip address of unwanted network
    then
    	lsof -i | grep -E "(LISTEN|ESTABLISHED)" > port.txt
    	File2=port.txt  
    	if grep -q :4433 "$File2"; ## searching for Sonic Wall Port Number
    	then
        	echo "Sonic Wall: It's okay to connect to unwanted network through the Sonic Wall"
    	else
	        echo "Oops! unwanted network"
       		echo "Not Sonic Wall"
	        #reboot here
    	    	sudo shutdown -h now
   	fi
    else
       echo "Hooray! It's a welcome network"
   fi
done

