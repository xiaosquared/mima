import processing.serial.*;


Floor f1, f2, f3, f4;
BirdManager birds;
boolean bUseBlinkyTape = false;
BlinkyTape blinkyTape;
final int OUTPUT_COUNT = 23;

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
}

void lightBlinkyBirds() {
  ArrayList<Bird> birdlist = birds.getBirds();
  blinkyTape.pushChannel(0);
  for (int i = 0; i < OUTPUT_COUNT-1; i++) {
    if (i >= 10 && i <= 15)
      blinkyTape.pushChannel(0);
    else {
      int j = i;
      if (i > 15)
        j = i - 6;
      Bird b = birdlist.get(j);
      int val = b.getBrightness();
      blinkyTape.pushChannel(val);
    }
  }
  blinkyTape.update(); 
}

void mouseMoved() {
  birds.setBirdLight(mouseX, mouseY);
}
