import processing.serial.*;


Floor f1, f2, f3, f4;
BirdManager birds;
boolean bUseBlinkyTape = true;
BlinkyTape blinkyTape;
final int OUTPUT_COUNT = 26;

void setup() {
  size(425, 1000);
  
  
  f1 = new Floor(-45, 750, "img/1F.jpg", 1);
  f2 = new Floor(-30, 750-215, "img/2F.jpg", 2); 
  f3 = new Floor(-10, 322, "img/3F.jpg", 3);
  f4 = new Floor(0, 120, "img/4F.jpg", 4);
  
  birds = new BirdManager();
  if (bUseBlinkyTape)
    connectBlinkyTape();
}

void draw() {
  background(0);
  f1.draw();
  f2.draw();
  f3.draw();
  f4.draw();
  birds.draw();
  
  if (bUseBlinkyTape)
    lightBlinkyBirds();
}

void lightBlinkyBirds() {
  for (int i = 0; i < OUTPUT_COUNT; i++) {
    int val = birds.getBrightnessForLightIndex(i);
    blinkyTape.pushChannel(val);
  }
  blinkyTape.update(); 
}

void mouseMoved() {
  birds.setBirdLight(mouseX, mouseY);
}
