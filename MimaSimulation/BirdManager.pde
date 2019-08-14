import java.util.Iterator;

class BirdManager {
  ArrayList<Bird> birds;
  int numBirds;
  
  ArrayList<Cascade> cascades;
  
  BirdManager() {
    birds = new ArrayList<Bird>();
    birds.add(new Bird(166, 935));
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
    
    cascades = new ArrayList<Cascade>();
  }
  
  void addCascade(Cascade c) {
    cascades.add(c);
  }
  
  void setBirdCharge(int id, boolean charge) {
    birds.get(id).setCharge(charge);
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
