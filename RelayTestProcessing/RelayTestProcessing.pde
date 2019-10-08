import processing.serial.*; 

Serial arduinoPort;
boolean on = false;

void setup() {
  size(200, 200);
  String[] serialPorts = listPorts();
  String portName = serialPorts[serialPorts.length-1];
  arduinoPort = new Serial(this, portName, 9600);
}

void draw() {
  background(0);  
  if (on)
    ellipse(width/2, height/2, 100, 100);
}

void keyPressed() {
  arduinoPort.write("1");
  on = true;
}

void keyReleased() {
  arduinoPort.write("0");
  on = false;
}

String[] listPorts() {
   ArrayList<String> ports = new ArrayList<String>();
   String OS = System.getProperty("os.name");
   
   if(OS.startsWith("Mac OS X")) {
     for(String s : Serial.list()) {
       // Mask unlikely ports on OS/X
       if(s.startsWith("/dev/tty")
        | s.contains("Bluetooth-PDA-Sync")
        | s.contains("Bluetooth-Modem")
        | s.contains("Bluetooth-Incoming-Port")) {
         continue;
       }
       
       ports.add(s);
     }
   }
   else if(OS.startsWith("Linux")) {
     for(String s : Serial.list()) {
       // Mask unlikely ports on Linux
       if(s.startsWith("/dev/ttyACM")) {
        ports.add(s);
       }
     }
   }
   else {
     // Other OS
     for(String s : Serial.list()) {        
       ports.add(s);
     }
   }

   return ports.toArray(new String[0]);
 }
