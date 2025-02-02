const int ledPin = 13;

void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
}

void loop() {
  digitalWrite(ledPin, HIGH);
  Serial.println("LED is ON");
  delay(1000);
  digitalWrite(ledPin, LOW);
  Serial.println("LED is OFF");
  delay(1000);
}
