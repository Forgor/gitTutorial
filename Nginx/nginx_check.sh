
# 检测脚本

#!/bin/bash

A=`ps -C nginx -no-header | wc -1`
if [ $A -eq 0];then
	/usr/local/nginx/sbin/nginx
	sleep 2
	if [`ps -C nginx --no-header | wc -1` -eq 0];then
		killall keepalived
	fi
fi
