#!/bin/sh

/usr/sbin/kissparms -p "${AX25_PORT}" -c 1

# https://thomask.sdf.org/blog/2017/08/06/improving-arp-performance-on-slow-ax-25-links.html
sysctl net.ipv4.neigh.ax0.retrans_time_ms=5000
sysctl net.ipv4.neigh.ax0.base_reachable_time_ms=1200000
