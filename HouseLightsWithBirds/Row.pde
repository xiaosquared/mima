class Row {
  float xMin;
  float xMax;
  float width;
  float baseline;
  
  ArrayList<House> houses;
  
  boolean fadeLights = false;
  boolean runLights = false;
  boolean leftToRight = false;
  float lightStartTime = 0;
  float lightStopTime = 0;
  
  float FADE_TIME = PI*500;
  float time_diff;
  
  Row(float xMin, float y, float width) {
    this.xMin = xMin;
    this.xMax = xMin + width; 
    this.baseline = y;
    this.width = width;
    houses = new ArrayList<House>();
  }
  
  float getBaseline() { return baseline; }
  float getWidth() { return width; }
  boolean isLeftToRight() { return leftToRight; }
  boolean isActive() { return runLights && !fadeLights; }
  
  // x is bottom left
  void addHouse(float x, HouseType type) {
    addHouse(x, baseline, type);
  }
  
  void addHouse(float x, float y, HouseType type) {
    House h = new House(x, y, type);
    houses.add(h);
  }
  
  ArrayList<House> getHouses() {
    return houses;
  }
  
  void activateLights(boolean leftFirst, float td) {
    this.leftToRight = leftFirst;
    runLights = true;
    fadeLights = false;
    lightStartTime = millis()-td;
    offsetPhase(leftFirst);
  }
  
  void deactivateLights() {
    fadeLights = true;
    lightStopTime = millis();
  }
  
  void offsetPhase(boolean leftToRight) {
    int numHouse = houses.size();
    for (int i = 0; i < numHouse;i++) {
      float phase;
      if (leftToRight) {
         phase = PI/2 * ( width - houses.get(i).getX()) / width;
      }
      else {
         phase = PI/2 * houses.get(i).getX()/width;
      }
      houses.get(i).setLightPhase(phase);
    }
  }
  
  void draw(float currentTime, float SYNC_TIME) {
    stroke(100);
    strokeWeight(2);
        
    float t = currentTime - lightStartTime;
    float phase_mod = min(t/SYNC_TIME, 1);
    phase_mod = 1-phase_mod;
    
    float amp_mod = 1.0;
    if (fadeLights) {
      if (runLights && currentTime - lightStopTime > FADE_TIME) {
        runLights = false;
        fadeLights = false;
      }
      else if (currentTime - lightStopTime < FADE_TIME) {
        amp_mod = (currentTime - lightStopTime)/FADE_TIME;
        amp_mod = 1-amp_mod;
      }
    }
    
    for (House h : houses) {
      h.draw(runLights, t, phase_mod, amp_mod, time_diff);
    }
    
    //line(xMin, baseline, xMax, baseline); 
      
  }
}
