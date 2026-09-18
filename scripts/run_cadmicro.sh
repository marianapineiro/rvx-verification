#!/bin/bash
# ==============================================================================
# Script: run_cadmicro.sh
# Description: Syncs the rvx-verification project to the CADMICRO cluster and
#              runs Synopsys VCS simulation on the specified CADMICRO PC.
# Usage:       ./scripts/run_cadmicro.sh [cadmicro01..cadmicro08]
# Example:     ./scripts/run_cadmicro.sh cadmicro03
# ==============================================================================

set -e

# Target CADMICRO server (default to cadmicro06 if no parameter provided)
TARGET_SERVER="${1:-cadmicro06}"
REMOTE_DIR="~/rvx-verification"

# Local repository path
LOCAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}[1/3] Syncing local files to ${TARGET_SERVER}...${NC}"
rsync -avz --exclude '.git' "${LOCAL_DIR}/" "${TARGET_SERVER}:${REMOTE_DIR}/"

echo -e "${GREEN}[2/3] Files synchronized successfully.${NC}"

echo -e "${BLUE}[3/3] Executing Synopsys VCS check on ${TARGET_SERVER}...${NC}"
ssh -o BatchMode=yes "${TARGET_SERVER}" "source /etc/profile && module use /tools/modulefiles/synopsys && module load vcs/W-2024.09-SP2-3 && cd ${REMOTE_DIR} && vcs -ID | grep 'Compiler version'"

echo -e "${GREEN}Done! ${TARGET_SERVER} is synced and ready for Synopsys VCS simulations.${NC}"
