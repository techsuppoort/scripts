**This projects uses an Arduino UNO with only a USB connection to toggle a relay in order to restart an ISP modem in case the connectivity is lost.**
# Parts:
- 1 Arduino UNO
- 1 JQC 3FF SZ relay
- 3 jumper wires (M-F)
- USB-B<->USB-A for the Arduino
- USB A Male-Female cables (if needed when the device is far away)
- 230V power cable
- 1 mountable wall outlet
- 1 MikroTik device with an USB-A port
- 1 Linux control unit which does the connectivity check and sends commands to the Arduino over RFC 2217 if needed

# Wiring:
Arduino 5V -> Relay +
Arduino GND -> Relay -
Arduino Pin 8 -> Relay S

Relay COM -> 230V input
Relay NO -> Nowhere
Relay NC -> Power outlet L

Note: I used a regular 230V M-F power cable and cut off the female end then connected the cable to the relay COM and the rest to a wall outlet (N, GND). Then the cable from the relay NC wen to the outlet's L connector.

# Connections:

Wall outlet <- Relay <- Arduino <- USB cable(s) <- MikroTik hEX <- Linux controller

# Files:

serial-relay.ino - for Arduino
MikroTik_config.txt - for MikroTik CLI
check-isp.sh and toggle-relay.sh - for the Linux controller

# Manual control:
On the Linux controller or the MikroTik device you can open a serial connection (9600/8/n/1) to the Arduino either via RFC 2217 (Linux) or directly (MikroTik) and type the *off* command to turn off the relay for 5 seconds. If you issue any other command, nothing will happen.
