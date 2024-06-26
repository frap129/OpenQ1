#!/usr/bin/env bash

CONFIG_PATH=${CONFIG_PATH:="/home/$USER/printer_data/config"}

kiauh_setup() {
	cd /home/$USER
	git clone https://github.com/dw-0/kiauh
}

prepare_kiauh_env() {
	cd /home/$USER
	KIAUH_SRCDIR="${HOME}/kiauh"
	source $KIAUH_SRCDIR/scripts/ui/general_ui.sh
	source $KIAUH_SRCDIR/scripts/globals.sh
	source $KIAUH_SRCDIR/scripts/utilities.sh
	set_globals
}

klipper_setup() {
	cd /home/$USER
	source $KIAUH_SRCDIR/scripts/klipper.sh
	run_klipper_setup 3 printer
	/home/$USER/klippy-env/bin/pip install numpy
}

moonraker_setup() {
	cd /home/$USER
	source $KIAUH_SRCDIR/scripts/moonraker.sh
	moonraker_setup 1
}

fluidd_setup() {
	cd /home/$USER
	source $KIAUH_SRCDIR/scripts/backup.sh
	source $KIAUH_SRCDIR/scripts/moonraker.sh
	source $KIAUH_SRCDIR/scripts/nginx.sh
	source $KIAUH_SRCDIR/scripts/fluidd.sh
	yes | install_fluidd
}

crowsnest_setup() {
	cd /home/$USER
	export CROWSNEST_UNATTENDED=1
	git clone https://github.com/mainsail-crew/crowsnest
	cd crowsnest
	sudo CROWSNEST_UNATTENDED=1 make install
}

timelapse_setup() {
	cd /home/$USER
	git clone https://github.com/mainsail-crew/moonraker-timelapse.git
	cd /home/$USER/moonraker-timelapse
	yes | make install
}

auto_z_offset_setup() {
	cd /home/$USER
	git clone https://github.com/frap129/qidi_auto_z_offset
	ln -s /home/$USER/qidi_auto_z_offset/auto_z_offset.py /home/$USER/klipper/klippy/extras/auto_z_offset.py
}

config_setup() {
	rm $CONFIG_PATH/printer.cfg
	rm $CONFIG_PATH/moonraker.conf
	rm $CONFIG_PATH/crowsnest.conf
	cp $OPENQ1_PATH/config/printer.cfg $CONFIG_PATH
	ln -s $OPENQ1_PATH/config/moonraker.conf $CONFIG_PATH/moonraker.conf
	ln -s $OPENQ1_PATH/config/crowsnest.conf $CONFIG_PATH/crowsnest.conf
	ln -s $OPENQ1_PATH/config $CONFIG_PATH/q1-pro
}

shaketune_setup() {
	cd /home/$USER
	git clone https://github.com/Frix-x/klippain-shaketune/ klippain_shaketune
	cd klippain_shaketune
	head -n -9 install.sh >tmp-install.sh
	echo "setup_venv
	link_extension" >>tmp-install.sh
	source tmp-install.sh
	rm tmp-install.sh
}

shellcmd_setup() {
	cd /home/$USER
	source $KIAUH_SRCDIR/scripts/gcode_shell_command.sh
	yes n | install_gcode_shell_command
}

first_login_setup() {
	cd /home/$USER
	echo "source $OPENQ1_PATH/scripts/firstlogin.sh" >>/home/$USER/.bashrc
	echo "first_login" >>/home/$USER/.bashrc
	touch /home/$USER/.not_logged_in_yet
}

katapult_setup() {
	cd /home/$USER
	git clone https://github.com/Arksine/katapult
}
