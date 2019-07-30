enum HouseType { SINGLE, DOUBLE, TOWNHOUSE}

class House {
  PVector bl;
  float width = 36;
  float height = 18;
  
  HouseType type;
  
  float phase = 0;
  float light = 0;
  
  House(float x, float y, HouseType type) {
    bl = new PVector(x, y);
    if (type == HouseType.SINGLE) 
      width = 18;
    else if (type == HouseType.TOWNHOUSE) {
      height = 36;
      width = 18;
    }
  }
  
  float getX() { return bl.x; }
  
  void lightIn() {
    Ani.to(this, 0.5, "light", 1, Ani.SINE_IN, "onEnd:lightOut");
  }
  
  void lightOut() {
    Ani.to(this, 0.5, "light", 0);
  }
  
  void setLightPhase(float phase) {
    this.phase = phase;
  }
  
  float getBrightness(float t, float phase_mod, float time_diff) {
    return 255 * abs(sin((t - time_diff*(1-phase_mod))/500 + phase*phase_mod));
  }
  
  void draw(boolean runLight, float t, float phase_mod, float amp_mod, float time_diff) {
    stroke(170);
    strokeWeight(1);
    if (runLight) {
      fill(255, min(255, (255-getBrightness(t, phase_mod, time_diff))*amp_mod + 255*light));
    }
    else {
      fill(255, 255*light);
    }
    rect(bl.x+3, bl.y-height+5, width, height);
  }
}
 
