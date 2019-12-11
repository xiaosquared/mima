class Shelves {
  Ball b1, b2, b3, b4, b1_dup;
  Wall wallSouth;
  Wall wallEast;
  Wall wallNorth;
  Wall wallWest;
  
  float initActivateTime = 0;
  
  Shelves() {
    b1 = new Ball(60, 413, "3", 1);
    b2 = new Ball(293, 305, "4", 1);
    b3 = new Ball(602, 305, "5", 1);
    b4 = new Ball(834, 158, "6", 1); 
    b1_dup = new Ball(1143, 413, "3", 1);
   
    wallSouth = new Wall(61, 293, 0, b1, b2);
    float southWidth = wallSouth.getWidth();
    for (int i = 0; i <= 7; i++) {
      Row r = new Row(wallSouth.getXMin()-3, i*48 + 52, southWidth);
      wallSouth.addRow(r);
    }
    // shelf 9
    wallSouth.addHouse(0, 161, 58, HouseType.DOUBLE);
    wallSouth.addHouse(0, 241, 58, HouseType.SINGLE);
    // shelf 8
    wallSouth.addHouse(1, 71, 103, HouseType.DOUBLE);
    wallSouth.addHouse(1, 126, 103, HouseType.DOUBLE);
    wallSouth.addHouse(1, 186, 103, HouseType.SINGLE);
    wallSouth.addHouse(1, 241, 103, HouseType.TOWNHOUSE);
    // shelf 7
    wallSouth.addHouse(2, 92, 153, HouseType.SINGLE);
    wallSouth.addHouse(2, 150, 153, HouseType.TOWNHOUSE);
    wallSouth.addHouse(2, 188, 153, HouseType.DOUBLE);
    wallSouth.addHouse(2, 240, 153, HouseType.DOUBLE);
    // shelf 6
    wallSouth.addHouse(3, 102, 198, HouseType.SINGLE);
    wallSouth.addHouse(3, 157, 198, HouseType.DOUBLE);
    wallSouth.addHouse(3, 240, 198, HouseType.DOUBLE);
    // shelf 5
    wallSouth.addHouse(4, 70, 247, HouseType.DOUBLE);
    wallSouth.addHouse(4, 134, 247, HouseType.SINGLE);
    wallSouth.addHouse(4, 184, 247, HouseType.DOUBLE);
    wallSouth.addHouse(4, 231, 247, HouseType.SINGLE);
    // shelf 4
    wallSouth.addHouse(5, 109, 294, HouseType.TOWNHOUSE);
    wallSouth.addHouse(5, 161, 294, HouseType.DOUBLE);
    wallSouth.addHouse(5, 247, 294, HouseType.TOWNHOUSE);
    // shelf 3
    wallSouth.addHouse(5, 69, 345, HouseType.DOUBLE);
    // shelf 2
    wallSouth.addHouse(5, 66, 390, HouseType.SINGLE);
    
    wallSouth.setFirstActiveRow(5);
    
    wallEast = new Wall(294, 602, 0, b2, b3);
    float eastWidth = wallEast.getWidth();
    for (int i = 0; i <=8; i ++) {
      Row r = new Row(wallEast.getXMin()-3, i*48 + 52, eastWidth);
      wallEast.addRow(r);
    }
    // shelf 9
    wallEast.addHouse(0, 309, 58, HouseType.SINGLE); 
    wallEast.addHouse(0, 354, 58, HouseType.DOUBLE);
    wallEast.addHouse(0, 418, 58, HouseType.TOWNHOUSE);
    wallEast.addHouse(0, 486, 58, HouseType.TOWNHOUSE);
    wallEast.addHouse(0, 567, 58, HouseType.SINGLE);
    // shelf 8 
    wallEast.addHouse(1, 309, 103, HouseType.DOUBLE);
    wallEast.addHouse(1, 384, 103, HouseType.DOUBLE);
    wallEast.addHouse(1, 467, 103, HouseType.TOWNHOUSE);
    wallEast.addHouse(1, 504, 103, HouseType.DOUBLE);
    wallEast.addHouse(1, 548, 103, HouseType.SINGLE);
    // shelf 7
    wallEast.addHouse(2, 339, 153, HouseType.DOUBLE);
    wallEast.addHouse(2, 422, 153, HouseType.SINGLE);
    wallEast.addHouse(2, 465, 153, HouseType.SINGLE);
    wallEast.addHouse(2, 532, 153, HouseType.DOUBLE);
    // shelf 6
    wallEast.addHouse(3, 322, 198, HouseType.SINGLE);
    wallEast.addHouse(3, 374, 198, HouseType.DOUBLE);
    wallEast.addHouse(3, 480, 198, HouseType.TOWNHOUSE);
    wallEast.addHouse(3, 506, 198, HouseType.SINGLE);
    // shelf 5
    wallEast.addHouse(4, 349, 247, HouseType.DOUBLE);
    wallEast.addHouse(4, 452, 247, HouseType.DOUBLE);
    wallEast.addHouse(4, 542, 247, HouseType.SINGLE);
    // shelf 4
    wallEast.addHouse(5, 314, 294, HouseType.DOUBLE);
    wallEast.addHouse(5, 390, 294, HouseType.TOWNHOUSE);
    wallEast.addHouse(5, 434, 294, HouseType.SINGLE);
    wallEast.addHouse(5, 494, 294, HouseType.TOWNHOUSE);
    // shelf 3
    wallEast.addHouse(6, 331, 345, HouseType.DOUBLE);
    wallEast.addHouse(6, 390, 345, HouseType.SINGLE);
    wallEast.addHouse(6, 504, 345, HouseType.DOUBLE);
    wallEast.addHouse(6, 569, 345, HouseType.TOWNHOUSE);
    // shelf 2 
    wallEast.addHouse(7, 311, 398, HouseType.TOWNHOUSE);
    wallEast.addHouse(7, 358, 398, HouseType.DOUBLE);
    wallEast.addHouse(7, 459, 398, HouseType.DOUBLE);
    wallEast.addHouse(7, 522, 398, HouseType.SINGLE);
    // shelf 1
    wallEast.addHouse(8, 310, 449, HouseType.DOUBLE);
    wallEast.addHouse(8, 393, 449, HouseType.TOWNHOUSE);
    wallEast.addHouse(8, 503, 449, HouseType.SINGLE);
    
    wallEast.setFirstActiveRow(5);
    
    wallNorth = new Wall(601, 834, 0, b3, b4);
    float northWidth = wallNorth.getWidth();
    for (int i = 0; i <= 5; i++) {
      Row r = new Row(wallNorth.getXMin()-3, i*48 + 52, northWidth);
      wallNorth.addRow(r);
    }
    // shelf 9
    wallNorth.addHouse(1, 645, 58, HouseType.DOUBLE);
    wallNorth.addHouse(1, 741, 58, HouseType.SINGLE);
    wallNorth.addHouse(1, 792, 58, HouseType.TOWNHOUSE);
    // shelf 8
    wallNorth.addHouse(1, 610, 103, HouseType.DOUBLE);
    wallNorth.addHouse(2, 698, 103, HouseType.TOWNHOUSE);
    wallNorth.addHouse(2, 748, 103, HouseType.DOUBLE);
    wallNorth.addHouse(2, 804, 103, HouseType.SINGLE);
    // shelf 7
    wallNorth.addHouse(2, 627, 153, HouseType.SINGLE);
    wallNorth.addHouse(2, 654, 153, HouseType.DOUBLE);
    wallNorth.addHouse(3, 734, 153, HouseType.SINGLE);
    wallNorth.addHouse(3, 788, 153, HouseType.TOWNHOUSE);
    // shelf 6
    wallNorth.addHouse(3, 632, 198, HouseType.DOUBLE);
    wallNorth.addHouse(3, 693, 198, HouseType.SINGLE);
    wallNorth.addHouse(4, 750, 198, HouseType.DOUBLE);
    wallNorth.addHouse(4, 807, 198, HouseType.SINGLE);
    // shelf 5
    wallNorth.addHouse(4, 666, 247, HouseType.DOUBLE);
    wallNorth.addHouse(4, 726, 247, HouseType.SINGLE);
    // shelf 4
    wallNorth.addHouse(4, 620, 294, HouseType.TOWNHOUSE);
    wallNorth.addHouse(4, 684, 294, HouseType.DOUBLE);
    
    wallNorth.setFirstActiveRow(4);
    
    wallWest = new Wall(834, 1143, 0, b4, b1);
    float westWidth = wallWest.getWidth();
    for (int i = 0; i <= 8; i++) {
      Row r = new Row(wallWest.getXMin()-3, i*48 + 52, westWidth);
      wallWest.addRow(r);
    }
    // shelf 9
    wallWest.addHouse(1, 860, 58, HouseType.DOUBLE); // shelf 9 (universe 0)
    wallWest.addHouse(1, 930, 58, HouseType.DOUBLE);
    wallWest.addHouse(1, 1002, 58, HouseType.SINGLE);
    // shelf 8
    wallWest.addHouse(2, 848, 103, HouseType.SINGLE);
    wallWest.addHouse(2, 904, 103, HouseType.TOWNHOUSE);
    // shelf 7
    wallWest.addHouse(4, 862, 153, HouseType.SINGLE);
    // shelf 6
    wallWest.addHouse(2, 1072, 205, HouseType.SINGLE);
    // shelf 5
    wallWest.addHouse(3, 1037, 250, HouseType.DOUBLE);
    // shelf 4
    wallWest.addHouse(4, 968, 295, HouseType.DOUBLE);
    wallWest.addHouse(3, 1049, 295, HouseType.SINGLE);
    // shelf 3
    wallWest.addHouse(3, 939, 343, HouseType.SINGLE);
    wallWest.addHouse(4, 1025, 343, HouseType.DOUBLE);
    wallWest.addHouse(3, 1095, 343, HouseType.SINGLE);
    // shelf 2
    wallWest.addHouse(1, 921, 390, HouseType.SINGLE);
    wallWest.addHouse(3, 969, 390, HouseType.TOWNHOUSE);
    wallWest.addHouse(3, 1008, 390, HouseType.SINGLE);
    wallWest.addHouse(4, 1092, 390, HouseType.DOUBLE);
    // shelf 1
    wallWest.addHouse(1, 862, 439, HouseType.SINGLE);
    wallWest.addHouse(1, 892, 439, HouseType.DOUBLE);
    wallWest.addHouse(2, 959, 439, HouseType.TOWNHOUSE);
    wallWest.addHouse(2, 1009, 439, HouseType.DOUBLE);
    wallWest.addHouse(3, 1090, 439, HouseType.TOWNHOUSE);
    
    wallWest.setFirstActiveRow(4);
  }
  
  ArrayList<House> getHousesByRow(int i) {
    ArrayList<House> houses = new ArrayList<House>();
    ArrayList<House> hEast = wallEast.getHousesByRow(i);
    if (hEast != null)
      houses.addAll(hEast);
    ArrayList<House> hSouth = wallSouth.getHousesByRow(i);
    if (hSouth != null)
      houses.addAll(hSouth);
    ArrayList<House> hWest = wallWest.getHousesByRow(i);
    if (hWest != null)
      houses.addAll(hWest);  
    ArrayList<House> hNorth = wallNorth.getHousesByRow(i);
    if (hNorth != null)
      houses.addAll(hNorth);      
    return houses;
  }
  
  void draw() {
    b1.draw();
    b2.draw();
    b3.draw();
    b4.draw();
    b1_dup.draw();
    
    wallSouth.draw();
    wallEast.draw();
    wallNorth.draw();
    wallWest.draw();
  }
  
  void onKeyPress(String keyString) {
    boolean b1_new = b1.onKeyPress(keyString);
    boolean b2_new = b2.onKeyPress(keyString);
    boolean b3_new = b3.onKeyPress(keyString);
    boolean b4_new = b4.onKeyPress(keyString);
    b1_dup.onKeyPress(keyString); 
    
    wallSouth.onKeyPress(b1_new, b2_new, initActivateTime);
    wallEast.onKeyPress(b2_new, b3_new, initActivateTime);
    wallNorth.onKeyPress(b3_new, b4_new, initActivateTime);
    wallWest.onKeyPress(b4_new, b1_new, initActivateTime);
    
    if (initActivateTime == 0) {
      if (wallSouth.isActive()) {
        initActivateTime = wallSouth.getInitActivateTime();  
      } else if (wallEast.isActive()) {
        initActivateTime = wallEast.getInitActivateTime();
      } else if (wallWest.isActive()) {
        initActivateTime = wallWest.getInitActivateTime();
      } else if (wallNorth.isActive()) {
        initActivateTime = wallNorth.getInitActivateTime();
      }
    }
  }
  
  void onKeyRelease(String keyString) {
    boolean b1_new = b1.onKeyRelease(keyString);
    boolean b2_new = b2.onKeyRelease(keyString);
    boolean b3_new = b3.onKeyRelease(keyString);
    boolean b4_new = b4.onKeyRelease(keyString);
    b1_dup.onKeyRelease(keyString);
    
    wallSouth.onKeyRelease(b1_new, b2_new);
    wallEast.onKeyRelease(b2_new, b3_new);
    wallNorth.onKeyRelease(b3_new, b4_new);
    wallWest.onKeyRelease(b4_new, b1_new);
    
    if (!wallSouth.isActive() && !wallEast.isActive() && !wallNorth.isActive() && !wallWest.isActive())
      initActivateTime = 0;
  }
  
  void allHousesOff() {
    wallEast.allHousesOff();
    wallSouth.allHousesOff();
    wallNorth.allHousesOff();
    wallWest.allHousesOff();
  }
  
}
