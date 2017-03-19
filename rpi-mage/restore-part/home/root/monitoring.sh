#!/bin/bash
while true ; 
do 
	PLOP=`ls -lh /backup/test.dd`
	nc -l -p 1500 -c 'echo -e "HTTP/1.1 200 OK\n\n $(date)\n\n $PLOP"'; 
	
done
