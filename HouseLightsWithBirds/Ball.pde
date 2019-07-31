enum TouchState {
   TOUCHED, RELEASED, TOUCH_INIT, RELEASE_INIT;
}

class Ball {
  PVector position;
  int floor;
  String id;
  
  color c = color(204, 153, 0);
  color white = color(255);
  int diameter = 30;
  
  TouchState touchState = TouchState.RELEASED;
  int touchInitTime = -100;
  int releaseInitTime = -100;
  
  boolean touched = false;
  int lastTouchedTime = 0;
  int lastTouchedInterval = 0;
  
  Ball(float x, float y, String letter, int floor) {
    position = new PVector(x, y);
    this.floor = floor;
    id = letter;
  }
  
  String getId() { return id; }
  int getFloor() { return floor; }
  boolean isTouched() { 
    return (touchState == TouchState.TOUCHED) || (touchState == TouchState.RELEASE_INIT) || touched;
  }
  int getLastTouchedInterval() { return lastTouchedInterval; }
  PVector getPosition() {return position; } 

  boolean onPress(String key) {
    if (key.equals(id)) {
      int currentTime = millis();
      
      switch(touchState) {
        case RELEASED:
          touchState = TouchState.TOUCH_INIT;
          touchInitTime = currentTime;
          releaseInitTime = currentTime + 10000;
          break;
        case RELEASE_INIT:
          touchState = TouchState.TOUCHED;
          break;
        case TOUCH_INIT:
        case TOUCHED:
        break;
      }
    }
    return false;
  }
  
  boolean onKeyPress(String key) {
    if (key.equals(id)) {
      if (!touched) {
        touched = true;
        return true;
      }
    }
    return false;
  }
  
  
  
  boolean onRelease(String key) {
    if (key.equals(id)) {
      
      int currentTime = millis();
      if (touchState == TouchState.TOUCHED) {
        touchState = TouchState.RELEASE_INIT;
        releaseInitTime = currentTime;
        touchInitTime = currentTime + 10000;
      }
      
      else if (touchState == TouchState.TOUCH_INIT) {
        touchState = TouchState.RELEASED;
      }
    }
    return false;
  }
  
  boolean onKeyRelease(String key) {
    if (key.equals(id)) {
      if (touched) {
          touched = false;
          lastTouchedInterval = millis() - lastTouchedTime;
          return true;
        }
    }
    return false;
  }
  
  void draw() {
    fill(c);
    
    boolean touching = isTouched(); 
    
    strokeWeight(touching ? 3 : 1);
    stroke(touching ? white : c);
    ellipse(position.x, position.y, diameter, diameter);
    
    fill(255);
    text(id, position.x, position.y);
  }
}
