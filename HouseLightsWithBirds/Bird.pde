class Bird {
  PVector position;
  int id = 0;
  
  float light = 0;
  float lightWidth = 15;
  
  float A = 1;
  float B = 1;
  float READY_B = 5;
  float STEADY_B = 10;
  
  
  boolean charging = false;
  float startTime = 0;
  float t = 0;
  int MAX_CHARGE_TIME = 5000;
  
  boolean flewAway = false; // when you hold it for a long time and it flies away itself
  
  
  Bird(float x, float y) {
    position = new PVector(x, y);
  }
  
  void setId(int id) {
    this.id = id;
  }
  
  void setCharge(boolean c) {
    if (!charging && c) {
      startTime = millis();
      flewAway = false;  
    }
    charging = c;
  }
  
  int getBrightness() {
    return int(map(light, 0, 1, 0, 255));
  }
  
  void lightIn() {
    if (!charging)
      Ani.to(this, 0.5, "light", 1, Ani.SINE_IN, "onEnd:lightOut");
  }
  
  void lightIn(float inTime) {
    if (!charging)
      Ani.to(this, inTime, "light", 1, Ani.SINE_IN, "onEnd:lightOutInit");
  }
  
  void lightOut() {
    if (!charging)
      Ani.to(this, 0.5, "light", 0);
  }
  
  void lightOutInit() {
    if (!charging)
      Ani.to(this, 0.7, "light", 0);
  }
  
  void flyAway() {
    Cascade c = new Cascade(id, birds.getNumBirds(), t);
    birds.addCascade(c);
    flewAway = true;    
    charging = false;
  }
  
  void draw() {
    stroke(100);
    strokeWeight(1);
    if (charging) {
      t = millis() - startTime;
      
      if (t > MAX_CHARGE_TIME) {
        flyAway();  
      }
      
      B = t/2000;
      if (B > READY_B) {
        B = STEADY_B;
      }
      //noStroke();
      light = A * abs(sin(B * t/500));
      fill (255, 255 * light);
      ellipse(position.x, position.y, lightWidth, lightWidth);
      
    } else if (light > 0) {
      //noStroke();
      fill(255, light * 255);
      ellipse(position.x, position.y, lightWidth, lightWidth);
    } else {
      noFill();
      ellipse(position.x, position.y, lightWidth, lightWidth);
    }
  }
}
