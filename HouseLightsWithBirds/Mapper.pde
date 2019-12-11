import java.util.*; 

class Mapper
{
  class Point
  {
    public float x;
    public float y;
    
    Point(float x, float y) {
      this.x = x;
      this.y = y;
    }
  }

  private Map<Integer, ArrayList<Point> > universes;
  private String ipAddress;
  private PVector offset;
  
  Mapper(String filename, String targetIp, PVector offset) {
    this.offset = offset;
    universes = new HashMap<Integer, ArrayList<Point> >();
    
    ipAddress = targetIp;
    
    Table table = loadTable(filename, "header");
    for (TableRow row : table.rows()) {
      final Integer universe = int(row.getString("Universe"));
      final float x = float(row.getString("X"));
      final float y = float(row.getString("Y"));
      
      if(!universes.containsKey(universe)) {
        universes.put(universe, new ArrayList());
      }
      
      universes.get(universe).add(new Point(x,y));
    }
    
    Set< HashMap.Entry<Integer, ArrayList<Point> > > st = universes.entrySet();
    for (HashMap.Entry<Integer, ArrayList<Point> > me : st)
    {
      ArrayList<Point> points = me.getValue(); // TODO: Does this copy the arraylist?
      Integer universe = me.getKey();
      
      println("Universe: " + universe + " lights:" + points.size() + " bytes:" + (points.size()*6));
    }
  }
  
  void sample(ArtNetClient client) {
    loadPixels();
    
    Set< HashMap.Entry<Integer, ArrayList<Point> > > st = universes.entrySet();
    for (HashMap.Entry<Integer, ArrayList<Point> > me : st)
    {
      ArrayList<Point> points = me.getValue(); // TODO: Does this copy the arraylist?
      
      Integer universe = me.getKey();
      Integer dataLength = points.size()*6; // 3 16-bit values per point
      
      byte[] data = new byte[dataLength];
      
      // Sample the pixels for this universe
      int i = 0;
      for (Point p : points) {
        byte val = byte(brightness(get(int(p.x+offset.x), int(p.y+offset.y))));
        // Note: MBI6120 controllers accept data in reverse order, however the SuperSweet
        // controller does not correct this automatically. Reverse the data first, then
        // send it to the SuperSweet.
        final int offset = dataLength - (i+1)*6;
        
        data[offset    ] = val;
        data[offset + 1] = 0;
        data[offset + 2] = val;
        data[offset + 3] = 0;
        data[offset + 4] = val;
        data[offset + 5] = 0;
        
        i+= 1;
      }
      
      client.unicastDmx(ipAddress, 0, universe, data);
    }
    
    updatePixels();
  }
  
    void allOff(ArtNetClient client) {
    loadPixels();
    
    Set< HashMap.Entry<Integer, ArrayList<Point> > > st = universes.entrySet();
    for (HashMap.Entry<Integer, ArrayList<Point> > me : st)
    {
      ArrayList<Point> points = me.getValue(); // TODO: Does this copy the arraylist?
      
      Integer universe = me.getKey();
      Integer dataLength = points.size()*6; // 3 16-bit values per point
      
      byte[] data = new byte[dataLength];
      
      // Sample the pixels for this universe
      int i = 0;
      for (Point p : points) {
        byte val = 0;//byte(brightness(get(int(p.x+offset.x), int(p.y+offset.y))));
        // Note: MBI6120 controllers accept data in reverse order, however the SuperSweet
        // controller does not correct this automatically. Reverse the data first, then
        // send it to the SuperSweet.
        final int offset = dataLength - (i+1)*6;
        
        data[offset    ] = val;
        data[offset + 1] = 0;
        data[offset + 2] = val;
        data[offset + 3] = 0;
        data[offset + 4] = val;
        data[offset + 5] = 0;
        
        i+= 1;
      }
      
      client.unicastDmx(ipAddress, 0, universe, data);
    }
    
    updatePixels();
  }
    
   
  void draw() {    
    colorMode(HSB, 100);
    
    Set< HashMap.Entry<Integer, ArrayList<Point> > > st = universes.entrySet();
    for (HashMap.Entry<Integer, ArrayList<Point> > me : st)
    {
      final int universe = me.getKey();
      
      stroke(universe*10,100,100);
      strokeWeight(1);
      noFill();
      
      Point lastPoint = null;
      Boolean drawlabel = false;
      for (Point p : me.getValue()) {
        //p.x = p.x + offset.x;
        //p.y = p.y + offset.y;
        // Draw a rectangle around the point that this mapping entry samples
        rect(p.x-3, p.y-3,6,6);
  
        if(drawlabel) {
          drawlabel = false;
          
          final int offsetX = (p.x == lastPoint.x) ? 0 : ((p.x > lastPoint.x) ? 15 : -15);
          final int offsetY = (p.y == lastPoint.y) ? 0 : ((p.y > lastPoint.y) ? 15 : -15);
          
          text(universe, lastPoint.x - offsetX, lastPoint.y - offsetY);
        }
  
        // Draw a connection line to show the wiring diagram
        if(lastPoint == null) {
          drawlabel = true;
        } else {
          line(p.x, p.y, lastPoint.x,lastPoint.y);
        }
        lastPoint = p;
      }
    }
    
    colorMode(RGB, 255);
  }
}
