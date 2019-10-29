class Machine {
  Serial arduinoPort;
  boolean motorOn = false;
  boolean limitTime = true;
  int startTime = 0;
  int shortRunTime = 3000;
  
  Machine() {
    arduinoPort = connectArduino(arduinoPort);
  }
  
  boolean isOn() { return motorOn; }
  
  void onKeyPress() {
    if (!motorOn) {
      turnMotorOn();
      startTime = millis();
    } else {
      limitTime = false;
    }
  }
  
  void onKeyRelease() {
    if (!limitTime)
      turnMotorOff();
  }
  
  void run() {
    if (limitTime && millis() - startTime > shortRunTime) {
      turnMotorOff();
    }
  }
  
  void turnMotorOn() {
    arduinoPort.write("1");
    motorOn = true;
  }
  
  void turnMotorOff() {
    arduinoPort.write("0");
    motorOn = false;
    limitTime = true;
  }
}
