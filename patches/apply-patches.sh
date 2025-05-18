#!/bin/bash

# Exit on any error
set -e

# Apply patches
echo "Applying DevStack patches..."
patch -p1 < patches/functions-common.patch
patch -p1 < patches/horizon-compute.patch
patch -p1 < patches/trove-nova.patch

# Update Trove plugin
echo "Updating Trove plugin..."
cp plugins/trove /opt/stack/devstack/plugins/

# Clean up any existing compute service
echo "Cleaning up compute service..."
openstack service delete compute || true

# Restart services
echo "Restarting services..."
sudo systemctl restart trove-api
sudo systemctl restart trove-taskmanager
sudo systemctl restart oracle-middleware

echo "Patches applied successfully!" 