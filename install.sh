#!/usr/bin/env bash

config_path=$1
pwd=$(pwd)

if [[ -z "$config_path" ]]; then
	echo "You must supply the path to your config directory!
	Example: $0 ~/printer_data/config"
	exit 1
fi

rm $config_path/printer.cfg
rm $config_path/moonraker.conf
cp $pwd/config/printer.cfg $config_path
ln -s $pwd/config/moonraker.conf $config_path/moonraker.conf
ln -s $pwd/config $config_path/q1-pro
