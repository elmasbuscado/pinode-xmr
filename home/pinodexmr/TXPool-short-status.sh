#!/bin/sh
#Establish IP/Port
DEVICE_IP="$(hostname -I)"
#Import Start Flag Values:
	#Load boot status - what condition was node last run
	. /home/pinodexmr/bootstatus.sh
	#Import Un-restricted Port Number (for internal status updates)
	. /home/pinodexmr/monero-stats-port.sh
	#Import Restricted Port Number (external use)
	. /home/pinodexmr/monero-port.sh
	#Import RPC username
	. /home/pinodexmr/RPCu.sh
	#Import RPC password
	. /home/pinodexmr/RPCp.sh
	
		if [ $BOOT_STATUS -eq 6 ]
then
		#Adapted command for restricted public rpc calls (payments)
		./monero-active/monerod --rpc-bind-ip=$DEVICE_IP --rpc-bind-port=$MONERO_STATS_PORT --rpc-ssl disabled print_pool_sh | sed '1d' > /var/www/html/TXPool-short_Status.txt	
else
		#Node MemPool status
		./monero-active/monerod --rpc-bind-ip=$DEVICE_IP --rpc-bind-port=$MONERO_PORT --rpc-login=$RPCu:$RPCp --rpc-ssl disabled print_pool_sh | sed '1d' > /var/www/html/TXPool-short_Status.txt	
fi
