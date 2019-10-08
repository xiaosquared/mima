import java.util.Iterator;

class BirdManager {
  ArrayList<Bird> birds;
  int numBirds;
  int[] birdIndex;
  
  ArrayList<Cascade> cascades;
  
  BirdManager() {
    int y = 200;
    birds = new ArrayList<Bird>();
    birds.add(new Bird(166, 935-y));
    birds.add(new Bird(168, 923-y));
    birds.add(new Bird(182, 912-y));
    birds.add(new Bird(197, 895-y));
    birds.add(new Bird(218, 870-y));
    birds.add(new Bird(246, 852-y));
    birds.add(new Bird(260, 839-y));    
    birds.add(new Bird(231, 823-y));
    birds.add(new Bird(194, 792-y));
    
    int y2 = 0; 
    birds.add(new Bird(165, 541-y2));
    birds.add(new Bird(212, 464-y2)); //10
    birds.add(new Bird(264, 406-y2));
    birds.add(new Bird(300, 347-y2));
    birds.add(new Bird(265, 307-y2));
    birds.add(new Bird(227, 265-y2));
    birds.add(new Bird(241, 215-y2));
    
    birds.add(new Bird(330, 117)); //16
    birds.add(new Bird(305, 142));
    birds.add(new Bird(274, 171)); 
    
    birds.add(new Bird(192, 111));
    birds.add(new Bird(162, 82));
    birds.add(new Bird(129, 49));
  
    numBirds = birds.size();
    
    cascades = new ArrayList<Cascade>();
    
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
  
  void addCascade(Cascade c) {
    cascades.add(c);
  }
  
  void setBirdCharge(int id, boolean charge) {
    birds.get(id).setCharge(charge);
  }
  
  int getBrightnessForLightIndex(int i) {
    int bIndex = birdIndex[i];
    if (bIndex < 0)
      return 0;
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
  
  
  void run() {
    Iterator<Cascade> c_it = cascades.iterator();
    while (c_it.hasNext()) {

      Cascade c = c_it.next();
      boolean status = c.run(birds, numBirds);
      if (!status) {
        c_it.remove();
      }
    }
    
  }
  
  void draw() {
    for (Bird b : birds) {
      b.draw(); 
    }
  }
}
