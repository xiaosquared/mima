# MiMa - Minds in the Making

Interactivity code for elevator cage installation

## Processing

### HouselightWithBirds
Code that controls entire installation

### BirdTest
Testing individual bird functionality. Mouse over circles to light up individual birds.

### RelayTestProcessing
Test for Relay. Press any key to turn on relay. Release it to turn it off.

### MimaSimulation
Old bird test code that just has key presses trigger bird cascades. HouselightWithBirds has the same functionality plus extras.

## Arduino Code

### Teensy_Receiver
To be uploaded onto Teensy board via Arduino.
MAX_LEDS within SerialLoop.h indicates how many light slots are getting controlled.
There are 4 LED controllers, two for floor 1, one for floor 2, and one for floor 3.
Floors 2 and 3 have 2 empty slots at the end. Floor 1 has 6 empty slots at the end.

### RelayTest
For Arduino Micro that is controlling the motor. Interfaces with "RelayTestProcessing" sketch
