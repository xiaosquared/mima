import java.util.Iterator;

class BirdManager {
  ArrayList<Bird> birds;
  int numBirds;
  
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
