const int ledPin = 2;    //Depends on the board , for Uno and Nano it is pin 13

void setup() {
  //This function will run only once when the board boots up 
  pinMode(ledPin , OUTPUT);  //Setting the ledPin as OUTPUT
}

void loop() {
  //This function runs infinitely until it is stopped
  digitalWrite(ledPin , HIGH);   //Turn ON the LED
  delay(1000);     //1 second delay
  digitalWrite(ledPin , LOW) ;  //Turn OFF the LED 
  delay(1000);     //1 second delay
}
