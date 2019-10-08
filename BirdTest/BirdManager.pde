import java.util.Iterator;

class BirdManager {
  ArrayList<Bird> birds;
  int numBirds;
  int[] birdIndex; 
  
  BirdManager() {
    birds = new ArrayList<Bird>();
    birds.add(new Bird(166, 937));
    birds.add(new Bird(168, 923));
    birds.add(new Bird(182, 912));
    birds.add(new Bird(197, 895));
    birds.add(new Bird(218, 870));
    birds.add(new Bird(246, 852));
    birds.add(new Bird(260, 839));    
    birds.add(new Bird(231, 823));
    birds.add(new Bird(194, 792));
    birds.add(new Bird(161, 760));
    
    birds.add(new Bird(187, 698)); //10
    birds.add(new Bird(224, 670));
    birds.add(new Bird(256, 641));
    birds.add(new Bird(229, 620));
    birds.add(new Bird(194, 591));
    birds.add(new Bird(217, 549));
    
    birds.add(new Bird(272, 379)); //16
    birds.add(new Bird(257, 392));
    birds.add(new Bird(240, 410)); 
    
    birds.add(new Bird(203, 341));
    birds.add(new Bird(188, 319));
    birds.add(new Bird(178, 296));
  
    numBirds = birds.size();
    
    birdIndex = new int[OUTPUT_COUNT];
    birdIndex[0] = 16;
    birdIndex[1] = 17;
    birdIndex[2] = 18;
    birdIndex[3] = 19;
    birdIndex[4] = 20;
    birdIndex[5] = 21;
    birdIndex[6] = -1;
    birdIndex[7] = -1;
    birdIndex[8] = 10;
    birdIndex[9] = 11;
    birdIndex[10] = 12;
    birdIndex[11] = 13;
    birdIndex[12] = 14;
    birdIndex[13] = 15;
    birdIndex[14] = -1;
    birdIndex[15] = -1;
    birdIndex[16] = 0;
    birdIndex[17] = 1;
    birdIndex[18] = 2;
    birdIndex[19] = 3;
    birdIndex[20] = 4;
    birdIndex[21] = 5;
    birdIndex[22] = 6;
    birdIndex[23] = 7;
    birdIndex[24] = 8;
    birdIndex[25] = 9;
  }
  
  void setBirdLight(int x, int y) {
    for (Bird b : birds) {
      if (b.inBird(x, y))
        b.light = 1;
      else
        b.light = 0;
    }
  }
  
  void setBirdCharge(int id, boolean charge) {
    birds.get(id).setCharge(charge);
  }
  
  int getBrightnessForLightIndex(int i) {
    int bIndex = birdIndex[i];
    if (bIndex < 0)
      return 0;
    else if (bIndex > 50)
      return 200;
    else return birds.get(bIndex).getBrightness();
  }
  
  ArrayList<Bird> getBirds() {return birds; }
  int getNumBirds() { return numBirds; } 
  
  int getStartBird(int floor) {
    if (floor == 1) {
      return 0;
    } else if (floor == 2) {
      return 9;
    } else if (floor == 3) {
      return 16;
    } else if (floor == 4) {
      return 19;
    }
    return 0;
  }
  
  void run() {}
  
  void draw() {
    for (Bird b : birds) {
      b.draw(); 
    }
  }
}
