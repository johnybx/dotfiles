#!/bin/bash
set -e

mkdir -p /snapshots
mount /snapshots

mkdir -p /snapshots/root
mkdir -p /snapshots/boot
mkdir -p /snapshots/home
mkdir -p /snapshots/root
mkdir -p /snapshots/root-home
mkdir -p /snapshots/workspace
mkdir -p /snapshots/jan

DATE="$(date +%Y-%M-%d)"

btrfs su snapshot / /snapshots/root/"$DATE"
btrfs su snapshot /boot /snapshots/boot/"$DATE"
btrfs su snapshot /root /snapshots/root-home/"$DATE"
btrfs su snapshot /home/jan/workspace/ /snapshots/workspace/"$DATE"
btrfs su snapshot /home/jan /snapshots/jan/"$DATE"
