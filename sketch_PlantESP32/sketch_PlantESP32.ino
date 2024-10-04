#include <WiFi.h>
#include <WiFiUdp.h>
#include <OSCMessage.h>

char ssid[] = "huyyoo";         
char pass[] = "32013201";    

WiFiUDP Udp;                               
const IPAddress outIp(192,168,0,113);       
const unsigned int outPort = 9999;     
const unsigned int localPort = 8888;   

const int touchPin =  34; 
int touchState = 0;
int preState = 0;

void setup() {
  Serial.begin(115200);  
  pinMode(touchPin, INPUT);

  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, pass);

  while (WiFi.status() != WL_CONNECTED) {
      delay(500);
      Serial.print(".");
  }
  Serial.println("");

  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  Serial.println("Starting UDP");
  Udp.begin(localPort);
  Serial.print("Local port: ");
  Serial.println(localPort);
}

void loop() {
   touchState = digitalRead(touchPin);
  
  if(preState == 0 && touchState == 1){
    OSCMessage msg("/touch");
    msg.add(1);
    Udp.beginPacket(outIp, outPort);
    msg.send(Udp);
    Udp.endPacket();
    msg.empty();
    Serial.println("detect touch!");
  }else if(preState == 1 && touchState == 0){
    OSCMessage msg("/touch");
    msg.add(0);
    Udp.beginPacket(outIp, outPort);
    msg.send(Udp);
    Udp.endPacket();
    msg.empty();
    Serial.println("detect release!");
  }
  preState = touchState;
}
