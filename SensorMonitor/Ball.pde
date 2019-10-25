class Ball {
  PVector position;
  int floor;
  String id;
  
  color c = color(204, 153, 0);
  color magenta = color(255, 0, 255);
  color green = color(0, 255, 0);
  color red = color(255, 0, 0);
  int diameter = 30;
  
  boolean touched = false;
  int lastTouchedTime = 0;
  int lastTouchedInterval = 0;
  
  boolean active = false;
  
  int currentTime = 0;
  int lastActivityCheckpt = 0;
  int activityWindow = 1000;
  int maxActivity = 4;
  int activityCount = 0;
  
  Ball(float x, float y, String letter, int floor) {
    position = new PVector(x, y);
    this.floor = floor;
    id = letter;
  }
  
  String getId() { return id; }
  int getFloor() { return floor; }
  int getLastTouchedInterval() { return lastTouchedInterval; }
  boolean isTouched() { return touched; }
  
  boolean onKeyPress(String key) {
    if (key.equals(id)) {
      if (!touched) {
        touched = true;
        lastTouchedTime = millis();
        activityCount++;
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
        activityCount++;
        return true;
      }
    }
    return false;
  }  
  
  void draw() {
    currentTime = millis();
    if (currentTime - lastActivityCheckpt > activityWindow) {
       activityCount = 0; 
       lastActivityCheckpt = currentTime;
    }
    if (activityCount > maxActivity) {
      stroke(color(255, 0, 0));
      strokeWeight(5); noFill();
      ellipse(position.x, position.y, diameter+10, diameter+10);
    }
    
    fill(c);
    strokeWeight(touched ? 4 : 1);
    stroke(touched ? magenta : c);
    ellipse(position.x, position.y, diameter, diameter);
    
    fill(255);
    text(id, position.x, position.y);
    
    stroke(active ? green : red); strokeWeight(3); noFill();
    ellipse(position.x, position.y, diameter+6, diameter+6);
  }
}
