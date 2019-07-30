class BallManager {
  ArrayList<Ball> balls;
  HashMap<String, Ball> ballsById;
  
  int f1_index = 0;
  int f2_index = 10;
  int f3_index = 16;
 
  BallManager() {
    balls = new ArrayList<Ball>();
    balls.add(new Ball(260, 836, "1", 1));
    balls.add(new Ball(260, 780, "2", 1));
    balls.add(new Ball(14, 723, "3", 2));
    balls.add(new Ball(14, 626, "4", 2));
    balls.add(new Ball(260, 627, "5", 2));
    balls.add(new Ball(260, 489, "6", 2));
    balls.add(new Ball(14, 324, "7", 3));
    balls.add(new Ball(14, 259, "8", 3));
    balls.add(new Ball(260, 272, "9", 3));
    balls.add(new Ball(260, 215, "0", 3));
    balls.add(new Ball(14, 107, "-", 4));
    balls.add(new Ball(14, 50, "=", 4));
    
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
  
  Ball onKeyPress(String id) {
    for (Ball b : balls) {
      if (b.onKeyPress(id))
        return b;
    }
    return null;
  }
  
  Ball onKeyRelease(String id) {
    for (Ball b : balls) {
      if(b.onKeyRelease(id))
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
