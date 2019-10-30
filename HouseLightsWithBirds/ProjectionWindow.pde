class ProjectionWindow extends PApplet {

  int gridHeight = 50;
  int gridWidth = 100;
  int mx = 0; int my = 0;
  int last_mx = 0; int last_my = 0;
  int diff_mx = 0; int diff_my = 0;
  int x_right_offset = 96;

  HouseLightsWithBirds parent;

  public ProjectionWindow(HouseLightsWithBirds parent) {
    super();
    PApplet.runSketch(new String[]{this.getClass().getSimpleName()}, this);
    this.parent = parent;
  }

  public void settings() {
    fullScreen(P2D);
    //size(3840, 1080, P2D);
    noSmooth();
  }

  public void setup() {
    surface.setSize(3840, 1080);
    //surface.setTitle("second sketch");
    blendMode(LIGHTEST);
  }

  public void draw() {
    if(frameCount==1) { 
      surface.setLocation(0,0); 
      noCursor();
    }
    background(0);
    if (m_bg != null && m_fg != null) {
      image(m_bg, 0, 0, 1920, 1080, 0, 0, 1920, 1080);
      image(m_bg, 1920+x_right_offset, 0, 1920, 1080, 1920, 0, 3840, 1080);

      image(m_fg, 0, 0, 1920, 1080, 0, 0, 1920, 1080);
      image(m_fg, 1920+x_right_offset, 0, 1920, 1080, 1920, 0, 3840, 1080);
    }

    // Debugging stuff
    //textSize(20);
    //text(frameRate, 10, 50);
    //text(frameRate, 3700, 50);
    
    //textSize(30);
    //text("Current Mouse Click: " + mx + ", " + my, 300, 200);
    //text("Last Mouse Click: " + last_mx + ", " + last_my, 300, 250);
    //text("Diff: " + diff_mx + ", " + diff_my, 300, 300);

    //stroke(255);
    //for(int i = 1; i < height/gridHeight; i++) {
    //  line(0, gridHeight*i, width, gridHeight*i);
    //}
    //for(int i = 1; i< width/gridWidth; i++) {
    //  line(gridWidth*i, 0, gridWidth*i, height);
    //}
  }

  void keyPressed() {
    parent.key = key;
    parent.keyPressed();
    if (key == 'h') {
      controlSurface.setVisible(false);
    }
    if (key == 's') {
      controlSurface.setVisible(true);
    }
    if (key == 'p') {
      println("p");
      m_fg.jump(0);
      m_fg.play();
    }
    if (key == 'o') {
      m_fg.stop();
    }
  }

  void keyReleased() {
    parent.key = key;
    parent.keyReleased();
  }
  
  void mousePressed() {
    last_mx = mx; last_my = my;
    mx = mouseX; //- offset.x;
    my = mouseY; //- offset.y;
    diff_mx = mx - last_mx;
    diff_my = my - last_my;
  }
}
