class Floor {
  
  PVector origin;
  PImage img;
  boolean isActive = false;
  int id;
  
  Floor(float x, float y, String imgPath, int id) {
    origin = new PVector(x, y);
    img = loadImage(imgPath);
    this.id = id;
  }
  
  void draw() {
     stroke(255);
     image(img,origin.x, origin.y);
     
     if (balls.isActive(id)) {
       fill(255, 100);
       rect(122 , origin.y, 179, img.height);
     }
  }
}
