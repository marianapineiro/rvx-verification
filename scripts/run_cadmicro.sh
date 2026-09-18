#!/bin/bash
# ==============================================================================
# Script: run_cadmicro.sh
# Description: Syncs the rvx-verification project to CADMICRO PC #6 and runs
#              Synopsys VCS simulation remotely.
# ==============================================================================

set -e

# Target CADMICRO server configuration
SERVER="cadmicro06"
REMOTE_HOST="cadmicro-el8-06.inf.ufrgs.br"
REMOTE_DIR="~/rvx-verification"

# Local repository path
LOCAL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}[1/3] Syncing local files to CADMICRO PC #6 (${REMOTE_HOST})...${NC}"
rsync -avz --exclude '.git' "${LOCAL_DIR}/" "${SERVER}:${REMOTE_DIR}/"

echo -e "${GREEN}[2/3] Files synchronized successfully.${NC}"

echo -e "${BLUE}[3/3] Executing Synopsys VCS check on CADMICRO PC #6...${NC}"
ssh -o BatchMode=yes "${SERVER}" "source /etc/profile && module use /tools/modulefiles/synopsys && module load vcs/W-2024.09-SP2-3 && cd ${REMOTE_DIR} && vcs -ID | grep 'Compiler version'"

echo -e "${GREEN}Done! CADMICRO PC #6 is synced and ready for Synopsys VCS simulations.${NC}"
