#!/bin/bash

# Script to set up snapper configurations for root and home
# Only creates configs if the subvolumes exist

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Error: This script must be run as root${NC}"
   exit 1
fi

# Check if snapper is installed
if ! command -v snapper &> /dev/null; then
    echo -e "${RED}Error: snapper is not installed${NC}"
    echo "Install it with: dnf install snapper"
    exit 1
fi

# Function to create snapper config
create_snapper_config() {
    local config_name=$1
    local mount_point=$2
    
    # Check if config already exists
    if snapper -c "$config_name" get-config &> /dev/null; then
        echo -e "${YELLOW}Snapper config '$config_name' already exists, skipping${NC}"
        return 0
    fi
    
    echo -e "${GREEN}Creating snapper config for $config_name at $mount_point${NC}"
    
    # Create the config
    snapper -c "$config_name" create-config "$mount_point"
    
    # Configure timeline snapshots
    snapper -c "$config_name" set-config "TIMELINE_CREATE=yes"
    snapper -c "$config_name" set-config "TIMELINE_CLEANUP=yes"
    snapper -c "$config_name" set-config "TIMELINE_LIMIT_HOURLY=3"
    snapper -c "$config_name" set-config "TIMELINE_LIMIT_DAILY=3"
    snapper -c "$config_name" set-config "TIMELINE_LIMIT_WEEKLY=3"
    snapper -c "$config_name" set-config "TIMELINE_LIMIT_MONTHLY=3"
    snapper -c "$config_name" set-config "TIMELINE_LIMIT_QUARTERLY=3"
    snapper -c "$config_name" set-config "TIMELINE_LIMIT_YEARLY=3"
    
    echo -e "${GREEN}✓ Config '$config_name' created successfully${NC}"
}

echo "Checking for btrfs subvolumes..."
echo

# Check and configure root
if btrfs subvolume show "/" &> /dev/null; then
    echo -e "${GREEN}✓ Found btrfs subvolume at /${NC}"
    create_snapper_config "root" "/"
else
    echo -e "${YELLOW}✗ / is not a btrfs subvolume, skipping${NC}"
fi

echo

# Check and configure home
if btrfs subvolume show "/home" &> /dev/null; then
    echo -e "${GREEN}✓ Found btrfs subvolume at /home${NC}"
    create_snapper_config "home" "/home"
else
    echo -e "${YELLOW}✗ /home is not a btrfs subvolume, skipping${NC}"
fi

echo
echo -e "${GREEN}Setup complete!${NC}"
echo
echo "To view your configurations:"
echo "  sudo snapper list-configs"
echo
echo "To list snapshots:"
echo "  sudo snapper -c root list"
echo "  sudo snapper -c home list"
echo
echo "To create a manual snapshot:"
echo "  sudo snapper -c root create --description 'My snapshot'"
