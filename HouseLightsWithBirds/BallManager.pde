public enum MsgType { 
  TOUCH, UNTOUCH, OTHER;
  
  public static MsgType getType(String msg) {
    switch (msg.charAt(8)) {
      case 't':
        return MsgType.TOUCH;
      case 'x':
        return MsgType.UNTOUCH;
      default:
        return MsgType.OTHER; 
    }
  }
}


class BallManager {
  ArrayList<Ball> balls;
  HashMap<String, Ball> ballsById;
  
  int f1_index = 0;
  int f2_index = 10;
  int f3_index = 16;
 
  BallManager() {
    balls = new ArrayList<Ball>();
    balls.add(new Ball(230, 801, "1", 1));
    balls.add(new Ball(230, 734, "2", 1));
    balls.add(new Ball(14, 593, "3", 2));
    balls.add(new Ball(14, 544, "4", 2));
    balls.add(new Ball(230, 541, "5", 2));
    balls.add(new Ball(230, 489, "6", 2));
    balls.add(new Ball(14, 407, "7", 3));
    balls.add(new Ball(14, 347, "8", 3));
    balls.add(new Ball(230, 347, "9", 3));
    balls.add(new Ball(230, 278, "0", 3));
    balls.add(new Ball(14, 181, "-", 4));
    balls.add(new Ball(14, 118, "=", 4));
    
    ballsById = new HashMap<String, Ball>();
    for (Ball b : balls) {
      ballsById.put(b.getId(), b);
    }
  }
  
  void draw() {
    for (Ball b : balls) {
      b.draw();
    }
  }
  
  ArrayList<Ball> getBalls() { return balls; }
  
  int getStartIndex(int floor) {
      if (floor == 2)
        return f2_index;
      if (floor == 3)
        return f3_index;
      return f1_index;
  }
  
  String getBallId(String msg) {
    return msg.substring(26, 27);  
  }

  void update() {
    int currentTime = millis();
    for (Ball b : balls) {
      if (b.touchState == TouchState.TOUCH_INIT && (currentTime - b.touchInitTime) > DEBOUNCE_TIME) {
        b.touchState = TouchState.TOUCHED;
        b.lastTouchedTime = currentTime;
        onPressed(b);
      }
      
      else if (b.touchState == TouchState.RELEASE_INIT && (currentTime - b.releaseInitTime) > DEBOUNCE_TIME) {
        b.touchState = TouchState.RELEASED;
        b.lastTouchedInterval = currentTime - b.lastTouchedTime;
        onReleased(b);
      }
    }
  }

  Ball onKeyPress(String id) {
    for (Ball b : balls) {
      if (b.onPress(id))
        return b;
    }
    return null;
  }
  
  Ball onKeyRelease(String id) {
    for (Ball b : balls) {
      if(b.onRelease(id))
        return b;
    }
    return null;
  }
  
  int getTouchedFloor(String id) {
    Ball touchedBall = ballsById.get(id);
    if (touchedBall == null)
      return -1;
    else 
      return touchedBall.getFloor();
  }

  boolean touchingFloor(int floor) {
    for (Ball b : balls) {
      if (b.isTouched() && b.getFloor() == floor)
        return true;
    }
    return false;
  }
  
  boolean isActive(int floor) {
    for (Ball b : balls) {
      if (b.isTouched() && b.getFloor() == floor)
        return true;
    }
    return false;
  }
}
