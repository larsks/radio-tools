#!/bin/bash

: "${AX25_HBAUD:=1200}"

if [ "$AX25_HBAUD" -eq "9600" ]; then
  /usr/sbin/kissparms -p $AX25_PORT -c 1 -t 100 -l 10 -s 12 -r 80 -f n
  echo 4      > /proc/sys/net/ax25/ax0/standard_window_size  # 2-7 (max frames)
  echo 256    > /proc/sys/net/ax25/ax0/maximum_packet_length # 1-512 (paclen)
  echo 3100   > /proc/sys/net/ax25/ax0/t1_timeout            # (Frack /1000 = seconds)
  echo 800    > /proc/sys/net/ax25/ax0/t2_timeout            # (RESPtime /1000 = seconds)
  echo 300000 > /proc/sys/net/ax25/ax0/t3_timeout            # (Check /1000 = seconds)
  echo 100000  > /proc/sys/net/ax25/ax0/idle_timeout         # (/10000(?) = seconds)
  echo 5      > /proc/sys/net/ax25/ax0/maximum_retry_count   # n
  echo 2      > /proc/sys/net/ax25/ax0/connect_mode          # 0 = None, 1 = Network, 2 = All
elif [ "$AX25_HBAUD" -eq "1200" ]; then
  /usr/sbin/kissparms -p $AX25_PORT -c 1 -t 300 -l 10 -s 12 -r 80 -f n
  echo 4      > /proc/sys/net/ax25/ax0/standard_window_size
  echo 128    > /proc/sys/net/ax25/ax0/maximum_packet_length
  echo 2000   > /proc/sys/net/ax25/ax0/t1_timeout
  echo 1000   > /proc/sys/net/ax25/ax0/t2_timeout
  echo 300000 > /proc/sys/net/ax25/ax0/t3_timeout
  echo 100000   > /proc/sys/net/ax25/ax0/idle_timeout
  echo 5      > /proc/sys/net/ax25/ax0/maximum_retry_count
  echo 2      > /proc/sys/net/ax25/ax0/connect_mode
else
  echo "Invalid HBAUD $3"
  return 1;
fi

# https://thomask.sdf.org/blog/2017/08/06/improving-arp-performance-on-slow-ax-25-links.html
sysctl net.ipv4.neigh.ax0.retrans_time_ms=5000
sysctl net.ipv4.neigh.ax0.base_reachable_time_ms=1200000

