//ledPin differes for different boards
int ledPin = 13;    //For Uno and Nano

void setup() {
  pinMode(ledPin , OUTPUT);
}

void loop() {
  digitalWrite(ledPin , 1);
  delay(1000);
  digitalWrite(ledPin , 0);
  delay(1000);
}
