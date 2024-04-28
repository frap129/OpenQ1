#!/usr/bin/env bash

setup_kernel_updates() {
	deb-get update --repos-only
	deb-get install aic8800-usb-dkms aic8800-firmware
	deb-get install linux-dtb-current-rockchip64 linux-headers-current-rockchip64 \
		linux-image-current-rockchip64 linux-libc-current-rockchip64 \
		linux-u-boot-qidi-q1
}
