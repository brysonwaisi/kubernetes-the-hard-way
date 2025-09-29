#!/usr/bin/env bash

set -e

echo "Checking Multipass daemon..."
if ! multipass version >/dev/null 2>&1; then
  echo "Multipass is not running or not installed. Please install or fix it first."
  exit 1
fi

echo "Launching VMs..."

multipass launch --name jumpbox --cpus 1 --memory 512M --disk 10G 22.04
multipass launch --name server --cpus 1 --memory 2G --disk 20G 22.04
multipass launch --name node-0 --cpus 1 --memory 2G --disk 20G 22.04
multipass launch --name node-1 --cpus 1 --memory 2G --disk 20G 22.04

echo
echo "All VMs launched. Current status:"
multipass list

echo
echo "IP addresses:"
for vm in jumpbox server node-0 node-1; do
  ip=$(multipass info "$vm" | awk '/IPv4/ {print $2}')
  printf "%-8s %s\n" "$vm" "$ip"
done

echo
