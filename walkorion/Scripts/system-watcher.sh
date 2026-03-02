#!/bin/bash
while true; do
  echo "--- Merenje na: $(date) ---" >> /home/walkorion/Scripts/ram_usage.log
  free -m >> /home/walkorion/Scripts/ram_usage.log
  sleep 300
done

