class ProjectionWindow extends PApplet {

  public ProjectionWindow() {
    super();
    PApplet.runSketch(new String[]{this.getClass().getSimpleName()}, this);
  }

  public void settings() {
    size(3840, 1080, P2D);
    noSmooth();
  }

  public void setup() {
    surface.setTitle("second sketch");
    blendMode(LIGHTEST);
  }

  public void draw() {
    //if(frameCount==1) surface.setLocation(0,0);
    background(0);
    if (m_bg != null) {

      image(m_bg, 0, 0, 1920, 1080, 0, 0, 1920, 1080);
      image(m_bg, 1920, 0, 3840, 1080, 1920, 0, 3840, 1080);

      image(m_fg, 0, 0, 1920, 1080, 0, 0, 1920, 1080);
      image(m_fg, 1920, 0, 3840, 1080, 1920, 0, 3840, 1080);
    }
    text(frameRate, 10, 50);
    text(frameRate, 3700, 50);
  }

  void keyPressed() {
    if (key == 'h') {
      controlSurface.setVisible(false);
    }
    if (key == 's') {
      controlSurface.setVisible(true);
    }
    if (key == 'p') {
      m_fg.jump(0);
      m_fg.play();
    }
    if (key == 'o') {
      m_fg.stop();
    }
  }
}
