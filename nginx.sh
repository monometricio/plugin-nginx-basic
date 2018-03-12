#!/bin/bash
if [ -z "$NGINX_URL" ]; then
    echo "Missing environment variable NGINX_URL" >&2
    exit 1
fi
OUTPUT=$(curl -q -s $NGINX_URL | tr '\n' ' ' | sed 's/  / /g')
echo $OUTPUT | grep -q ^Active
[ $? -eq 0 ] || exit 0

ACTIVE_CONN=$(echo $OUTPUT | cut -d' ' -f 3)
READING=$(echo $OUTPUT | cut -d' ' -f 12)
WRITING=$(echo $OUTPUT | cut -d' ' -f 14)
WAITING=$(echo $OUTPUT | cut -d' ' -f 16)
ACCEPTS=$(echo $OUTPUT | cut -d' ' -f 8)
HANDLED=$(echo $OUTPUT | cut -d' ' -f 9)
REQUESTS=$(echo $OUTPUT | cut -d' ' -f 10)

CPUVALUES=$(ps aux | grep "nginx: " | grep -v grep | awk '{print $3}' | tr '\n' '+'; echo 0)
CPU_USAGE_PERCENT=$(awk "BEGIN {print $CPUVALUES; exit}")
MEMVALUES=$(ps aux | grep "nginx: " | grep -v grep | awk '{print $4}' | tr '\n' '+'; echo 0)
MEM_USAGE_PERCENT=$(awk "BEGIN {print $MEMVALUES; exit}")

echo "nginx.active_connections:$ACTIVE_CONN"
echo "nginx.reading:$READING"
echo "nginx.writing:$WRITING"
echo "nginx.waiting:$WAITING"
echo "_counter.nginx.accepts:$ACCEPTS"
echo "_counter.nginx.handled:$HANDLED"
echo "_counter.nginx.requests_per_sec:$REQUESTS"
echo "nginx.cpu_usage_percent:$CPU_USAGE_PERCENT"
echo "nginx.mem_usage_percent:$MEM_USAGE_PERCENT"
