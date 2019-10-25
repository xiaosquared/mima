import websockets.*;

WebsocketClient wsc;
int interval_min = 15;
int interval;
int time = 0;
int count = 0;


void setup() {
  size(200, 200);
  wsc = new WebsocketClient(this, "ws://192.168.0.101:3333");
  interval= interval_min*60000;
  time = millis();
}

void draw() {
  if (millis() > time + interval) {
    count++;
    int minutes = count * interval_min;
    int hours = minutes / 60;
    minutes = minutes % 60;
    
    println("ELAPSED TIME: " + hours + " hours, " + minutes + " minutes");
    time = millis();
  }
}

void webSocketEvent(String msg) {
  if (msg.charAt(8) != 'h') {
    //String id = msg.substring(26, 27);
    println(msg);
  }
}
