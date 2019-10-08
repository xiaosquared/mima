import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
import ch.bildspur.artnet.*;
import processing.serial.*;
import websockets.*;

Floor f1, f2, f3, f4;

PImage layout;
PVector offset = new PVector(450, 200);
PVector bird_offset = new PVector(-60, 120);
PVector balls_offset = new PVector(40, 0);
Shelves shelves;
BirdManager birds;
BallManager balls;

// House Lights
boolean bSendToHouses = false;
final String mappingFile = "mapping_coordinates.csv";
final String targetIp = "192.168.4.100";
ArtNetClient artnet;
Mapper mapper;

// Bird Lights
boolean bUseBlinkyTape = true;
BlinkyTape blinkyTape;
final int OUTPUT_COUNT = 26;

// Sensors
boolean bUseWebsocket = false;
WebsocketClient wsc;
float DEBOUNCE_TIME_TOUCH = 500;
float DEBOUNCE_TIME_UNTOUCH = 100;


void setup() {
  size(1650, 1000);
  textAlign(CENTER, CENTER);
  Ani.init(this);
  
  f1 = new Floor(-95, 640, "1F.jpg", 1);
  f2 = new Floor(-80,400, "2F.jpg", 2); 
  f3 = new Floor(-60, 200, "3F.jpg", 3);
  f4 = new Floor(-50, 0, "4F.jpg", 4);
  
  layout = loadImage("data/house_layout3.jpg");
  shelves = new Shelves();
  birds = new BirdManager();
  balls = new BallManager();
  
  if (bUseBlinkyTape)
    connectBlinkyTape();
  
  if (bSendToHouses) {
    artnet = new ArtNetClient(null);
    artnet.start();
    mapper = new Mapper(mappingFile, targetIp, offset);
  }
  
  if (bUseWebsocket)
    wsc = new WebsocketClient(this, "ws://192.168.0.101:3333");
}

void draw() {
  background(0);
  
  f1.draw();
  f2.draw();
  f3.draw();
  f4.draw();
  noStroke(); fill(0);
  rect(321, 0, 100, height);
  
  
  balls.update();
  pushMatrix();
  translate(balls_offset.x, balls_offset.y);
  balls.draw();
  popMatrix();
  
  pushMatrix();
  translate(bird_offset.x, bird_offset.y);
  birds.run();
  birds.draw();
  popMatrix();
 
  fill(255, 200);
  ellipse(mouseX, mouseY, 50, 50);

  pushMatrix();
  translate(offset.x, offset.y);
  tint(255,64);
  image(layout, 0, 0);
  shelves.draw();
  popMatrix();
  
  if (bSendToHouses) {
    mapper.sample(artnet);
    pushMatrix();
    translate(offset.x, offset.y);
    mapper.draw();
    popMatrix();
  }
  
  if (bUseBlinkyTape)
    lightBlinkyBirds();
}
void mousePressed() {
  float x = mouseX; //- offset.x;
  float y = mouseY; //- offset.y;
  println(x + ", " + y);
}

void lightBlinkyBirds() {
  for (int i = 0; i < OUTPUT_COUNT; i++) {
    int val = birds.getBrightnessForLightIndex(i);
    blinkyTape.pushChannel(val);
  }
  blinkyTape.update(); 
}

void onPressed(Ball b) {
  int floor = b.getFloor();
  int myBird = birds.getStartBird(floor);
  birds.setBirdCharge(myBird, true);
  shelves.onKeyPress(b.id);
}

void onReleased(Ball b) {
  int floor = b.getFloor();
  if (floor >= 0 ) {
      int startBird = birds.getStartBird(floor);
    
      if (!balls.touchingFloor(floor))
        birds.setBirdCharge(startBird, false);
    
      float touchedInterval = b.getLastTouchedInterval();
    
      Cascade c = new Cascade(startBird, birds.getNumBirds(), touchedInterval);
      birds.addCascade(c);
  }
  shelves.onKeyRelease(b.id);
}


void webSocketEvent(String msg) {
  MsgType type = MsgType.getType(msg);
  println(msg);
  
  if (type == MsgType.OTHER)
    return;
    
  String id = balls.getBallId(msg);
  
  if (type == MsgType.TOUCH) {
    balls.onKeyPress(id);
    
  }
  else if (type == MsgType.UNTOUCH) {
    balls.onKeyRelease(id);
  }
  
  println("END");
}

void keyPressed() {
  String keyString = Character.toString(key);
  Ball touchedBall = balls.onKeyPress(keyString);
  if (touchedBall != null)
    onPressed(touchedBall);
}

void keyReleased() {
  String keyString = Character.toString(key);
  Ball touchedBall = balls.onKeyRelease(keyString);
  if (touchedBall != null)
    onReleased(touchedBall);
}
