# OpenQ1
The goal of this project is to create custom, community supported firmware for the QIDI Q1 Pro 3D printer, including:
- All features of the stock firmware, excluding PLR (it doesn't really work on stock anyways)
- The latest versions of klipper, moonraker, fluidd, etc
- Latest version of Debian & Linux LTS for improved security 
- Improved configuration and macros

## Features:
- Latest version of Debian (Bookworm currently)
- Latest LTS Linux Kernel (6.6.x currently)
- Printer software pre-installed:
    - Klipper
    - Moonraker
    - Fluidd
    - Crowsnest
    - moonraker-timelapse
    - Shake&Tune
    - [QIDI Auto Z Offset](https://github.com/frap129/qidi_auto_z_offset)
- Improved Q1 Pro klipper config and macros
- All stock features of the Q1 Pro, except
    - Power loss recovery was hacky at best on the stock fimrware, and is not included.
    - [Screen support](https://github.com/frap129/klipmi) is still a WIP and is not included by default.

# How to install:
Follow the [installation guide](docs/Installation.md). Note that this is still in testing, bugs are to be expected. Please report issues and feature requests in this repo.

### Calibrate Z Offset
Unlike the stock firmware, you must manually run Z offset calibration. This step is not optional. See the explanation and guide here: [Calibrating Z Offset](docs/Calibrating-Z-Offset.md).

### Change Slicer Settings
OpenQ1 makes some changes to the `PRINT_START` and `PRINT_END` macros that don't always behave well with the default slicer settings. It is recommended that you change them, following the guide here: [Slicer Setup](docs/Slicer-Setup.md).
