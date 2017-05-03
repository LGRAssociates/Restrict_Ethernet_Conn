#!/bin/bash
APS=1
while [ APS=1 ]; do
    ifconfig | grep "inet" | grep -Fv 127.0.0.1 |awk '{print $2}' > ip.txt
    File=ip.txt  
    if grep -q 10.20.2 "$File"; ##note the space after the string you are searching for
    then
    	lsof -i | grep -E "(LISTEN|ESTABLISHED)" > port.txt
    	File2=port.txt  
    	if grep -q :4433 "$File2"; ##note the space after the string you are searching for
    	then
        	echo "Sonic Wall"
    	else
	        echo "Oops!! Not APS"
       		echo "Not Sonic Wall"
	        #reboot here
    	    sudo shutdown -h now
   		fi
    else
       echo "Hooray!!It's APS"
   fi
done

