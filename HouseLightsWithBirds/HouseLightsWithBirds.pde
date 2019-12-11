import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
import ch.bildspur.artnet.*;
import processing.serial.*;
import websockets.*;
import processing.video.*;

Floor f1, f2, f3, f4;
PSurface controlSurface;

PImage layout;
PVector offset = new PVector(450, 200);
PVector bird_offset = new PVector(-60, 120);
PVector balls_offset = new PVector(40, 0);
Shelves shelves;
BirdManager birds;
BallManager balls;

// House Lights
boolean bSendToHouses = true;
final String mappingFile = "mapping_coordinates.csv";
final String targetIp = "192.168.4.100";
ArtNetClient artnet;
Mapper mapper;

// Bird Lights
boolean bUseBlinkyTape = true;
BlinkyTape blinkyTape;
final int OUTPUT_COUNT = 26;

// Sensors
boolean bUseWebsocket = true;

WebsocketClient wsc;
float DEBOUNCE_TIME_TOUCH = 200;
float DEBOUNCE_TIME_UNTOUCH = 100;

// Motor
boolean bMotor = true;
Machine machine;

// Second screen
ProjectionWindow projection;

// 4th floor projections
Movie m_bg;
Movie m_fg;
PGraphics mask_left, mask_right, left, right;
String foregroundPath = "Oct29_foreground.mp4";
String backgroundPath = "Oct29_background.mp4";
int fly_across_time = 9;

void settings() {
  size(1650, 1000);
}

void setup() {
  prepareExitHandler();
  projection = new ProjectionWindow(this);

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

  if (bMotor)
    machine = new Machine();

  m_bg = new Movie(this, backgroundPath);
  m_bg.loop();
  m_bg.play();

  m_fg = new Movie(this, foregroundPath);
  m_fg.play();

  controlSurface = getSurface();
}

void draw() {
  background(0);

  f1.draw(); f2.draw(); f3.draw(); f4.draw();
  noStroke(); fill(0);
  rect(321, 0, 100, height);

  balls.update();
  pushMatrix(); translate(balls_offset.x, balls_offset.y);
  balls.draw(); popMatrix();

  pushMatrix();
  translate(bird_offset.x, bird_offset.y);
  birds.run(); birds.draw(); popMatrix();

  fill(255, 200);
  ellipse(mouseX, mouseY, 50, 50);

  pushMatrix(); translate(offset.x, offset.y);
  tint(255,64); image(layout, 0, 0);
  shelves.draw(); popMatrix();

  if (bSendToHouses) {
    mapper.sample(artnet);
    pushMatrix(); translate(offset.x, offset.y);
    mapper.draw(); popMatrix();
  }

  if (bUseBlinkyTape)
    lightBlinkyBirds();

  if (bMotor && machine.isOn()) {
    fill(255); stroke(255); textSize(32);
    text("Motor ON", 110, 290);
    machine.run();
  }
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
  if (bMotor && floor == 3)
    machine.onKeyPress();
}

void onReleased(Ball b) {
  int floor = b.getFloor();
  if (floor >= 0 ) {
      int startBird = birds.getStartBird(floor);
      if (!birds.flewAway(startBird)) {
        if (!balls.touchingFloor(floor))
          birds.setBirdCharge(startBird, false);

        float touchedInterval = b.getLastTouchedInterval();

        Cascade c = new Cascade(startBird, birds.getNumBirds(), touchedInterval);
        birds.addCascade(c);
      }
  }
  if (floor == 4 && m_fg.time() > fly_across_time) {
    m_fg.stop();
    m_fg.play();
  }
  shelves.onKeyRelease(b.id);
  if (bMotor && floor == 3)
    machine.onKeyRelease();
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
}

void keyPressed() {

  String keyString = Character.toString(key);
  Ball touchedBall = balls.onKeyPress(keyString);
  if (touchedBall != null)
    onPressed(touchedBall);
  else if (key == 'h') {
    controlSurface.setVisible(false);
  }
   else if (key == 's') {
     controlSurface.setVisible(true);
   }
}

void keyReleased() {
  String keyString = Character.toString(key);
  Ball touchedBall = balls.onKeyRelease(keyString);
  if (touchedBall != null)
    onReleased(touchedBall);
}

void movieEvent(Movie m) {
  m.read();
}

// for existing gracefully
private void prepareExitHandler() {
  Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
    public void run() {
      machine.turnMotorOff();
      birds.allBirdsOff();
      lightBlinkyBirds();
      mapper.allOff(artnet);
    
    }
  }));
}
