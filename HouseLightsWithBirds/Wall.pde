class Wall {
  ArrayList<Row> rows;
  Ball ballLeft;
  Ball ballRight;
  int startIndex = 0;
  int i = 0;
  
  float xMin;
  float xMax;
  float xTrans = 0;
  
  float initActivateTime = 0;
  float lastActivateTime = 0;
  float ACTIVATE_NEXT_TIME = 1000*PI;
  float sync_time = 10000;
  float time_diff = 0;
  
  Wall(float xMin, float xMax, float xTrans, Ball bl, Ball br) {
    this.xMin = xMin;
    this.xMax = xMax;
    this.xTrans = xTrans;
    
    ballLeft = bl;
    ballRight = br;
    
    rows = new ArrayList<Row>();
  }
  
  float getXMin() { return xMin; }
  float getWidth() { return xMax - xMin; }
  float getLastActivateTime() { return lastActivateTime; }
  float getInitActivateTime() { return initActivateTime; }
  
  void addRow(Row r) {
    rows.add(r);
  }
  
  ArrayList<House> getHousesByRow(int i) {
    if (i <= rows.size()-1)
      return rows.get(i).getHouses();
    return null;
  }
  
  // by default the y of the house is the baseline of the row it's added to
  void addHouse(int index, float x, HouseType type) {
    if (rows.isEmpty() || index >= rows.size())
      return;
    Row r = rows.get(index);
    r.addHouse(x, type);
  }
  
  // but we can also have a house who's y is different
  void addHouse(int index, float x, float y, HouseType type) {
    if (rows.isEmpty() || index >= rows.size())
      return;
    Row r = rows.get(index);
    r.addHouse(x, y, type); 
  }
  
  
  void setFirstActiveRow (int i) {
    startIndex = i;
  }
  
  Row getFirstActiveRow() {
    return rows.get(startIndex);
  }
  
  void deactivateLights() {
    initActivateTime = 0;
    time_diff = 0;
    for (Row r : rows)
      r.deactivateLights();
  }
  
  boolean isActive() {
      return rows.get(startIndex).isActive();
  }
  
  void onKeyPress(boolean bLeft_newPress, boolean bRight_newPress, float adjLastActivateTime) {
    if (isActive())
      return;
    
    float currentTime = millis();
    
    if (bLeft_newPress && ballRight.isTouched()) {
      if (adjLastActivateTime > 0) {
        time_diff = (currentTime - adjLastActivateTime) % (PI*500);
      } 
      getFirstActiveRow().activateLights(false, time_diff);
      initActivateTime = currentTime;
      lastActivateTime = currentTime;
    }
    
    else if (bRight_newPress && ballLeft.isTouched()) {
      if (adjLastActivateTime > 0) {
        time_diff = (currentTime - adjLastActivateTime) % (PI*500);
      }
      getFirstActiveRow().activateLights(true, time_diff);
      initActivateTime = currentTime;
      lastActivateTime = currentTime;
    }
  }
  
  
  void onKeyRelease(boolean bLeft_newRelease, boolean bRight_newRelease) {
    if (bLeft_newRelease || bRight_newRelease) {
      deactivateLights();
      i = 0;
    }
  }
  
  void allHousesOff() {
    for (Row r : rows) {
      for (House h : r.getHouses()) {
        h.light = 0;
      }
    }
  }
  
  void draw() {
    pushMatrix();
    translate(xTrans, 0);
    
    float currentTime = millis();
    if (startIndex - i > 0) {
      Row currentRow = rows.get(startIndex-i); 
      if (currentRow.isActive() && currentTime - lastActivateTime > ACTIVATE_NEXT_TIME) {
        boolean currentDirection = currentRow.isLeftToRight();
        i++;
        
        rows.get(startIndex - i).activateLights(!currentDirection, time_diff);
        if (startIndex + i < rows.size()) {
          rows.get(startIndex + i).activateLights(!currentDirection, time_diff);
        }
        lastActivateTime = currentTime;
        currentDirection = !currentDirection;
      }
    }
       
    for (Row r : rows) {
      r.draw(currentTime, sync_time);
    }
    popMatrix();
  
  }
}
