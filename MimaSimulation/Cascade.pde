class Cascade {
  int start;
  int end;
  int current;
  
  int currentTime = 0;
  int lastBirdTime = 0;
  int betweenBirdTime = 100;
  
  float MAX_TOUCH_INTERVAL = 4000;
  
  Cascade(int start, int totalBirds, float touchInterval) {
    this.start = start;
    
    float maxTouch = (totalBirds - start)/(float)totalBirds * MAX_TOUCH_INTERVAL; 
    
    if (touchInterval > maxTouch)
      end = totalBirds - 1;
    else {
      int remaining = totalBirds - start - 1;
      end = (int) (start + touchInterval/maxTouch * remaining);
    }
    
    current = start;
  }
  
  boolean run(ArrayList<Bird> birds, int numBirds) {
    if (current <= end && current < numBirds) {
      
      currentTime = millis();
      
      if (currentTime - lastBirdTime > betweenBirdTime) {
        if (current == start)
          birds.get(current).lightIn(0.1);    // the first one fades in faster
        else 
          birds.get(current).lightIn();
        current++;
        lastBirdTime = currentTime;
      }
      return true;
    }
    return false;
  }
}
