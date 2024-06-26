# Calibrating Z Offset
Unlike how the stock firmware automatically sets the Z Offset for the probe every time you print, OpenQ1 requires that you calibrate the Z Offset prior to printing. This is because of inconsistencies that have discovered when operating under different temperatures, bed screw tightness, and even between different machines. These inconsistencies can lead to inaccurate results from both the bed sensors and inductive probes, and in rare cases failure to trigger. Pre-calibrating the Z offset avoids random print failures or damage to the print bed, as some users have experienced both on stock firmware and previous versions of OpenQ1.

To calibrate the Z Offset:
1. Heat the extruder to a reasonable temperature that wont ooze (160+)
2. Home all axes
3. Run `AUTO_Z_CALIBRATE`
4. Move Z to 0
5. Verify that you can slide a piece of paper under the nozzle
6. Run `SAVE_CONFIG` to save the measured offset.
    - Note, this does not modify the `z_offset` of the inductive probe in your config. This value is only used by
    `auto_z_offset`
7. You can make adujstments to the offset by micro-stepping durring a print, and save them with `AUTO_Z_SAVE_GCODE_OFFSET` and `SAVE_CONFIG`

See [qidi_auto_z_offset](https://github.com/frap129/qidi_auto_z_offset) for more information and advanced usage
