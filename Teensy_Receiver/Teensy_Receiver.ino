#include <DmxSimple.h>
#include "SerialLoop.h"

/*
# Driver for the PWM_FTW system

## Pin map

| Pin        | Signal   | Description                    |
| ---        | ---      | ---                            |
| VUSB       | Power    | 5V power for transmitter       |
| 1          | TX1      | 
| 10         | TX2      |
| 3          | TX1_LED  |
| 4          | TX2_LED  |
| GND        | Ground   | Shared ground pin              |
*/

#define TX1_PIN       1
#define TX2_PIN       2
#define TX1_LED_PIN   3
#define TX2_LED_PIN   4

const float brightness = 1.0; // Change this to set the max brightness (0.0 - 1.0)
const float phaseTime = 1; // Change this to change the length of time each output is on for, in seconds
const int outputCount = MAX_LEDS;  // Number of outputs to scan. Set to 1 to enable only the first output, 2 to enable the first two, etc. Max val: 8

void setup() {
  Serial.begin(115200);
  
  DmxSimple.usePin(TX1_PIN);
  DmxSimple.maxChannel(outputCount);

  pinMode(TX1_LED_PIN, OUTPUT);
  pinMode(TX2_LED_PIN, OUTPUT);
  digitalWrite(TX1_LED_PIN, HIGH);
  digitalWrite(TX2_LED_PIN, HIGH);

  analogWriteFrequency(TX1_LED_PIN, 1);
  analogWriteResolution(8);
  analogWrite(TX1_LED_PIN, 127);

  pinMode(13, OUTPUT);
  digitalWrite(13, HIGH);
}

float phase = 0;
int currentChannel = 0;

void loop() {
  if(Serial.available())
    serialLoop();
  
  for(int channel = 0; channel < outputCount; channel++) {
    float value;
    
    //if((channel == currentChannel) || (channel == ((currentChannel+outputCount/2)%outputCount)))
    if(channel == currentChannel)
      value = map(cos(phase+PI), -1, 1, 0.0, 1.0);
    else
      value = 0;
      
    DmxSimple.write(channel+1, map(value*brightness,0,1,0,255));
  }

  // Increment the phase, keeping it in range 0-2*PI
  phase += 1/(1442*phaseTime);   // determined experimentally
  if(phase >= 2*PI) {
    phase = 0;//-= 2*PI;
    currentChannel = (currentChannel + 1) % outputCount;
  }
}
