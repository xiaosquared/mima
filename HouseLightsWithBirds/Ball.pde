class Ball {
  PVector position;
  int floor;
  String id;
  
  color c = color(204, 153, 0);
  color white = color(255);
  int diameter = 30;
  
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
  boolean isTouched() { return touched; }
  int getLastTouchedInterval() { return lastTouchedInterval; }
  PVector getPosition() {return position; } 

  boolean onKeyPress(String key) {
    if (key.equals(id)) {
      if (!touched) {
        touched = true;
        lastTouchedTime = millis();
        return true;
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
    strokeWeight(touched ? 3 : 1);
    stroke(touched ? white : c);
    ellipse(position.x, position.y, diameter, diameter);
    
    fill(255);
    text(id, position.x, position.y);
  }
}
