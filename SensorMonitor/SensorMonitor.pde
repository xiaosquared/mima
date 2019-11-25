import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
import processing.serial.*;
import websockets.*;
//import oscP5.*;
//import netP5.*;

Floor f1;
Floor f2;
Floor f3;
Floor f4;
BallManager balls;

// for capacitive balls
boolean bUseWebsocket = true;
WebsocketClient wsc;

// for motor
boolean bUseArduino = false;
Serial arduinoPort;

// for Unity
//OscP5 oscP5;
//NetAddress myRemoteLocation;

void setup() {
  size(425,1000);
  textAlign(CENTER, CENTER);
  
  f1 = new Floor(-45, 750, "img/1F.jpg", 1);
  f2 = new Floor(-30, 750-215, "img/2F Houses.jpg", 2); 
  f3 = new Floor(-10, 322, "img/3F.jpg", 3);
  f4 = new Floor(0, 120, "img/4F.jpg", 4);
  balls = new BallManager();
  
  Ani.init(this);
  
  
  // SENSOR
  if (bUseWebsocket)
    wsc = new WebsocketClient(this, "ws://192.168.0.101:3333");
    //wsc = new WebsocketClient(this, "ws://localhost:3333");
  
  // UNITY
  //oscP5 = new OscP5(this, 7000);
}

void draw() {
  if(frameCount==1) surface.setLocation(0,0);
  background(50);
   
 
  f1.draw();
  f2.draw();
  f3.draw();
  f4.draw();
  balls.draw();
}
 
void mousePressed() {
  println(mouseX + ", " + mouseY);
}

void webSocketEvent(String msg) {
  String id = getBallId(msg);
  println(id);
  balls.setActive(id);
  
  if (isTouchEvent(msg)) {
    Ball eventBall = balls.onKeyPress(id); 
    onPressedAction(eventBall);
  } else if (isReleaseEvent(msg)) {
    Ball eventBall = balls.onKeyRelease(id);
    onReleasedAction(eventBall);
  }
}

String getBallId(String msg) {
  return msg.substring(26, 27);
}

boolean isTouchEvent(String msg) {
  return msg.charAt(8) == 't';
}

boolean isReleaseEvent(String msg) {
  return msg.charAt(8) == 'x';
}

void keyPressed() {
  String keyString = Character.toString(key);
  Ball touchedBall = balls.onKeyPress(keyString);
  onPressedAction(touchedBall);
}

void onPressedAction(Ball touchedBall) {
  if (touchedBall != null) {
    int floor = touchedBall.getFloor();
  }
}

void keyReleased() {
  String keyString = Character.toString(key);
  Ball touchedBall = balls.onKeyRelease(keyString);
  onReleasedAction(touchedBall);
}

void onReleasedAction(Ball touchedBall) {
  if (touchedBall != null) {
    int floor = touchedBall.getFloor();
    if (floor >= 0 ) {
      float touchedInterval = touchedBall.getLastTouchedInterval();
    }
  }
}
