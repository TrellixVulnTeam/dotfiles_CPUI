#!/bin/bash

echo ""
echo "========================================"
echo "Configuring Temperatures Sensors"
echo "========================================"

sudo apt install lm-sensors
(
	sudo sensors-detect
)
