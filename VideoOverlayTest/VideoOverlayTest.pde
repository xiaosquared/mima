/*
VIDEO OVERLAY TEST
Created 7.3.19.

Test for overlaying two videos using the blending mode LIGHTEST
Both videos have a black background. Only the lightest pixel show through.
Prints the framerate in the cornder

*/

import processing.video.*;

Movie m_fg;
Movie m_bg;

PGraphics mask_left, mask_right, left, right;
int overlap = 384;

void setup() {
  size(3840, 1080, P2D);
  blendMode(LIGHTEST);
  noSmooth();
  
  m_fg = new Movie(this, "Oct11_foreground.mp4");
  m_fg.loop();
  m_fg.play();
  
  m_bg = new Movie(this, "Oct11_background.mp4");
  m_bg.loop();
  m_bg.play();
  
  textSize(30);
  
  mask_left = createGraphics(1920, 1080);
  mask_left.beginDraw();
  mask_left.noStroke();
  mask_left.fill(255);
  mask_left.rect(0, 0, 1920, 1080);
  setGradient(mask_left, 1920-overlap, 0, overlap, 1080, color(255), color(0));
  mask_left.endDraw();
  
  mask_right = createGraphics(1920, 1080);
  mask_right.beginDraw();
  mask_right.noStroke();
  mask_right.fill(255);
  mask_right.rect(0, 0, 1920, 1080);
  setGradient(mask_right, 0, 0, overlap, 1080, color(0), color(255));
  mask_left.endDraw();
  
  left = createGraphics(1920, 1080, P2D);
  left.beginDraw();
  left.noSmooth();
  left.blendMode(LIGHTEST);
  left.endDraw();
    
  right = createGraphics(1920, 1080, P2D);
  right.beginDraw();
  right.noSmooth();
  right.blendMode(LIGHTEST);
  right.endDraw();
}

void draw() {
  if(frameCount==1) surface.setLocation(0,0);
  background(0);
  
  drawMovie(left, mask_left, m_bg, m_fg, 0, 0, 1920, 1080);
  drawMovie(right, mask_right, m_bg, m_fg, 1920-overlap, 0, 3840-overlap, 1080); 
  
  image(left, 0, 0, 1920, 1080);
  image(right, 1920, 0, 1920, 1080);
  
  text(frameRate, 10, 50); 
  text(frameRate, 3700, 50);
}

void movieEvent(Movie m) {
  m.read();
}

void setGradient(PGraphics g, int x, int y, float w, float h, color c1, color c2) {
  g.noFill();
  for (int i = x; i <= x+w; i++) {
    float inter = map(i, x, x+w, 0, 1);
    color c = lerpColor(c1, c2, inter);
    g.stroke(c);
    g.line(i, y, i, y+h);
  }
}

void drawMovie(PGraphics g, PGraphics mask, Movie bg, Movie fg, int sx, int sy, int sw, int sh) {
  g.beginDraw();
  g.background(0);
  g.image(bg, 0, 0, 1920, 1080, sx, sy, sw, sh);
  g.image(fg, 0, 0, 1920, 1080, sx, sy, sw, sh);
  g.endDraw();
  g.mask(mask);
}
