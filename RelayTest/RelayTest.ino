
int relayPin = 2;
char val;


void setup() {
  pinMode(relayPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  if (Serial.available()) {
    val = Serial.read();
  }
  if (val == '1') {
    digitalWrite(relayPin, HIGH);      
  } else {
    digitalWrite(relayPin, LOW);
  }
  delay(10);
}
