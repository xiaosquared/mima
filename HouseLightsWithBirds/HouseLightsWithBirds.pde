import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
import ch.bildspur.artnet.*;


PImage layout;
PVector offset = new PVector(350, 310);
PVector bird_offset = new PVector(-60, 120);
PVector balls_offset = new PVector(40, 0);
Shelves shelves;
BirdManager birds;
BallManager balls;

final String mappingFile = "mapping_coordinates.csv";
final String targetIp = "192.168.4.100";

ArtNetClient artnet;
Mapper mapper;

void setup() {
  size(1600, 900);
  textAlign(CENTER, CENTER);
  Ani.init(this);
  
  layout = loadImage("data/house_layout3.jpg");
  shelves = new Shelves();
  birds = new BirdManager();
  balls = new BallManager();
  
  artnet = new ArtNetClient(null);
  artnet.start();
  mapper = new Mapper(mappingFile, targetIp, offset);
}

void draw() {
  background(0);
  
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
  mapper.sample(artnet);
 
  pushMatrix();
  translate(offset.x, offset.y);
  mapper.draw();
  popMatrix();
}

void mousePressed() {
  float x = mouseX - offset.x;
  float y = mouseY - offset.y;
  println(x + ", " + y);
}

void keyPressed() {
  String keyString = Character.toString(key);
  Ball touchedBall = balls.onKeyPress(keyString);
  if (touchedBall != null) {
    int floor = touchedBall.getFloor();
    int myBird = birds.getStartBird(floor);
    birds.setBirdCharge(myBird, true);
  }
  shelves.onKeyPress(keyString);
}

void keyReleased() {
  String keyString = Character.toString(key);
  
  Ball touchedBall = balls.onKeyRelease(keyString);
  if (touchedBall != null) {
    int floor = touchedBall.getFloor();
    if (floor >= 0 ) {
      int startBird = birds.getStartBird(floor);
    
      if (!balls.touchingFloor(floor))
        birds.setBirdCharge(startBird, false);
    
      float touchedInterval = touchedBall.getLastTouchedInterval();
    
      Cascade c = new Cascade(startBird, birds.getNumBirds(), touchedInterval);
      birds.addCascade(c);
    }
  }
  
  shelves.onKeyRelease(keyString);
}
