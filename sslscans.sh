#!/usr/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
file=$1
cat $file | while read array; do
  line=(${array//,/ })
  ip_port=${line[0]}
  sniname=${line[1]}
  logfile=$SCRIPT_DIR/logs/"sslscan-"$(echo $ip_port | sed -e 's/[^A-Za-z0-9_-]/_/g').log
  if [ -n "$sniname" ]; then
    /usr/bin/sslscan --xml=$logfile".xml" --sni-name=$sniname $ip_port | tee $logfile
  else
    /usr/bin/sslscan --xml=$logfile".xml" $ip_port | tee $logfile
  fi
done
