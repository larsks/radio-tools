#!/bin/sh
#
# This script is written to help configure an axport to use as a winlink node.
# It sets AX.25 and KISS params appropriate to the given HBAUD (link baudrate)
set -e

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
  then echo "Usage: $0 [tty] [axport] [1200/9600]"
  exit 1;
fi

while :; do
	ax25_tty=$(readlink -f "$1")
	[ -c "${ax25_tty}" ] && break
	sleep 1
done

ax25_port=$2
ax25_speed=$3

if [ "${ax25_speed}" -eq "9600" ]; then
  /usr/sbin/kissattach "${ax25_tty}" "${ax25_port}" -m 256
  /usr/sbin/kissparms -p "${ax25_port}" -t 100 -l 10 -s 12 -r 80 -f n
  echo 4      > /proc/sys/net/ax25/ax0/standard_window_size  # 2-7 (max frames)
  echo 256    > /proc/sys/net/ax25/ax0/maximum_packet_length # 1-512 (paclen)
  echo 3100   > /proc/sys/net/ax25/ax0/t1_timeout            # (Frack /1000 = seconds)
  echo 800    > /proc/sys/net/ax25/ax0/t2_timeout            # (RESPtime /1000 = seconds)
  echo 300000 > /proc/sys/net/ax25/ax0/t3_timeout            # (Check /1000 = seconds)
  echo 100000 > /proc/sys/net/ax25/ax0/idle_timeout          # (/10000(?) = seconds)
  echo 5      > /proc/sys/net/ax25/ax0/maximum_retry_count   # n
  echo 2      > /proc/sys/net/ax25/ax0/connect_mode          # 0 = None, 1 = Network, 2 = All
elif [ "${ax25_speed}" -eq "1200" ]; then
  /usr/sbin/kissattach "${ax25_tty}" "${ax25_port}" -m 128
  /usr/sbin/kissparms -p "${ax25_port}" -t 300 -l 10 -s 12 -r 80 -f n
  echo 4      > /proc/sys/net/ax25/ax0/standard_window_size
  echo 128    > /proc/sys/net/ax25/ax0/maximum_packet_length
  echo 2000   > /proc/sys/net/ax25/ax0/t1_timeout
  echo 1000   > /proc/sys/net/ax25/ax0/t2_timeout
  echo 300000 > /proc/sys/net/ax25/ax0/t3_timeout
  echo 100000 > /proc/sys/net/ax25/ax0/idle_timeout
  echo 5      > /proc/sys/net/ax25/ax0/maximum_retry_count
  echo 2      > /proc/sys/net/ax25/ax0/connect_mode
else
  echo "Invalid speed $3"
  return 1;
fi

# https://thomask.sdf.org/blog/2017/08/06/improving-arp-performance-on-slow-ax-25-links.html
sysctl net.ipv4.neigh.ax0.retrans_time_ms=5000
sysctl net.ipv4.neigh.ax0.base_reachable_time_ms=1200000
