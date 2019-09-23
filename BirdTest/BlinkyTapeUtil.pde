// Filter out some ports we don't care about
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

void connectBlinkyTape() {
  println("Connect");
  String[] serialPorts = listPorts();
  for (String p : serialPorts) {
    println(p);
  }
  
  if(serialPorts.length > 0) {
    blinkyTape = new BlinkyTape(this, serialPorts[serialPorts.length-1], OUTPUT_COUNT);
  }
}
