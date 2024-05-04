# OpenQ1
The goal of this project is to create custom, community supported firmware for the QIDI Q1 Pro 3D printer, including:
- All features of the stock firmware, excluding PLR (it doesn't really work on stock anyways)
- The latest versions of klipper, moonraker, fluidd, etc
- Latest version of Debian & Linux LTS for improved security 
- Improved configuration and macros

## Features:
- Klipper, Moonraker, Fluidd, Crowsnest, mookeraker-timelapse, KAMP, Shake&Tune, QIDI Auto Z Offset all preinstalled 
- Improved Q1 Pro klipper config and macros 
- All stock features of the Q1 Pro, except
    - Filament width sensor does not report valid values, needs investigation
    - Power loss recovery was hacky at best on the stock fimrware, and is not included.
    - Screen support is still a WIP and is not included by default.
- Latest version of Debian (Bookworm currently)
- Latest LTS Linux Kernel (6.6.x currently)

# How to install:
Follow the [installation guide](docs/Installation.md). Note that this is still in testing, bugs are to be expected. Please report issues and feature requests in this repo.



