#!/usr/bin/env bash

OPENQ1_PATH=$(dirname -- "$(readlink -f -- "$0")")/../

source $OPENQ1_PATH/scripts/functions.sh

# Run setup functions
kiauh_setup
prepare_kiauh_env
klipper_setup
moonraker_setup
fluidd_setup
crowsnest_setup
timelapse_setup
auto_z_offset_setup
config_setup $OPENQ1_PATH
kamp_setup
shellcmd_setup
shaketune_setup
