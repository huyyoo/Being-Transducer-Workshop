int plantPin = 8;
int data = 0;

void setup() {
  Serial.begin(115200);
  pinMode(plantPin, INPUT);    
}

void loop() {
  data = digitalRead(plantPin);
  Serial.println(data);
  delay(100);
}
