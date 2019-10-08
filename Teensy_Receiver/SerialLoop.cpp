#include <Arduino.h>
#include <DmxSimple.h>
#include "SerialLoop.h"

#define PIXEL_DATA_SIZE 1

void serialLoop() {
  uint16_t currentPixel;     // Pixel that should be written to next
  uint8_t c;
  
  // Wait for serial data
  while(true) {
    if (Serial.available() > 0) {
      c = Serial.read();
      if (c == 255) {
        currentPixel = 0;
      } else {
        if(currentPixel < MAX_LEDS) {
          DmxSimple.write(currentPixel+1, c);
          currentPixel++;
        }
      }
    }
  }
}
