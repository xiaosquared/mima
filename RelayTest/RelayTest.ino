
int relayPin = 2;
char val;


void setup() {
  pinMode(relayPin, OUTPUT);
  Serial.begin(9600);
  digitalWrite(relayPin, LOW);
}

void loop() {
  if (Serial.available()) {
    val = Serial.read();
  }
  if (val == '1') {
    digitalWrite(relayPin, LOW);      
  } else {
    digitalWrite(relayPin, HIGH);
  }
  delay(10);
}
