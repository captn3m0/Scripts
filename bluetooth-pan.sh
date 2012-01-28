#!/bin/bash
sudo modprobe bnep
sudo pand --listen -c 78:CA:04:B7:9E:35 --role=NAP -n --persist
sudo ifconfig bnep0
sudo ifup bnep0
