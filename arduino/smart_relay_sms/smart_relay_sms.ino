#include <gprs.h>
#include <softwareserial.h>
 
#define TIMEOUT    5000
#define LED_PIN    13
#define ON 1
#define OFF 0

const int RLY1 = 3;
const int RLY2 = 4;
const int RLY3 = 5;
const int RLY4 = 6;
 
int StatusRLY1;
int StatusRLY2;
int StatusRLY3;
int StatusRLY4;
GPRS gprs;
 
void setup() {
  pinMode (RLY1 , OUTPUT);
  pinMode (RLY2 , OUTPUT);
  pinMode (RLY3 , OUTPUT);
  pinMode (RLY4 , OUTPUT);
  Serial.begin(9600);
  while(!Serial);
 
  Serial.println("Starting SIM800 Auto Read SMS");
  gprs.preInit();
  delay(1000);
 
  while(0 != gprs.init()) {
      delay(1000);
      Serial.print("init error\r\n");
  } 
 
  //Set SMS mode to ASCII
  if(0 != gprs.sendCmdAndWaitForResp("AT+CMGF=1\r\n", "OK", TIMEOUT)) {
    ERROR("ERROR:CNGF");
    return;
  }
   
  //Start listening to New SMS Message Indications
  if(0 != gprs.sendCmdAndWaitForResp("AT+CNMI=1,2,0,0,0\r\n", "OK", TIMEOUT)) {
    ERROR("ERROR:CNMI");
    return;
  }
 
  Serial.println("Init success");

  //SMS Konfirmasi Power ON
  gprs.sendSMS("085882444182","Saklar SMS Aktif");
}
 
//Variable to hold last line of serial output from SIM800
char currentLine[500] = "";
int currentLineIndex = 0;
 
//Boolean to be set to true if message notificaion was found and next
//line of serial output is the actual SMS message content
bool nextLineIsMessage = false;
 
void loop() {
  //Write current status to LED pin
  digitalWrite(RLY1, StatusRLY1);
  digitalWrite(RLY2, StatusRLY2);
  digitalWrite(RLY3, StatusRLY3);
  digitalWrite(RLY4, StatusRLY4);
   
  //If there is serial output from SIM800
  if(gprs.serialSIM800.available()){
    char lastCharRead = gprs.serialSIM800.read();
    //Read each character from serial output until \r or \n is reached (which denotes end of line)
    if(lastCharRead == '\r' || lastCharRead == '\n'){
        String lastLine = String(currentLine);
         
        //If last line read +CMT, New SMS Message Indications was received.
        //Hence, next line is the message content.
        if(lastLine.startsWith("+CMT:")){
           
          Serial.println(lastLine);
          nextLineIsMessage = true;
           
        } else if (lastLine.length() > 0) {
           
          if(nextLineIsMessage) {
            Serial.println(lastLine);
             

// ########## MEMBACA KONTEN SMS DAN MENCARI+MENGARTIKAN KONTEN SMS KE PROGRAM #########
            //Kendali Relay 1
            if(lastLine.indexOf("SAKLAR1 OFF") >= 0){
              StatusRLY1 = 1;
              gprs.sendSMS("085882444182","Saklar 1 Dimatikan");
              Serial.println("Relay1/Saklar1 DIMATIKAN");} 
              else if(lastLine.indexOf("SAKLAR1 ON") >= 0) {
              StatusRLY1 = 0;
              gprs.sendSMS("085882444182","Saklar 1 Dinyalakan");
              Serial.println("Relay1/Saklar1 DINYALAKAN");}
            //Kendali Relay 2
            if(lastLine.indexOf("SAKLAR2 OFF") >= 0){
              StatusRLY2 = 1;
              gprs.sendSMS("085882444182","Saklar 2 Dimatikan");
              Serial.println("Relay2/Saklar2 DIMATIKAN");} 
              else if(lastLine.indexOf("SAKLAR2 ON") >= 0) {
              StatusRLY2 = 0;
              gprs.sendSMS("085882444182","Saklar 2 Dinyalakan");
              Serial.println("Relay2/Saklar2 DINYALAKAN");}
            //Kendali Relay 3
            if(lastLine.indexOf("SAKLAR3 OFF") >= 0){
              StatusRLY3 = 1;
              gprs.sendSMS("085882444182","Saklar 3 Dimatikan");
              Serial.println("Relay3/Saklar3 DIMATIKAN");} 
              else if(lastLine.indexOf("SAKLAR3 ON") >= 0) {
              StatusRLY3 = 0;
              gprs.sendSMS("085882444182","Saklar 3 Dinyalakan");
              Serial.println("Relay3/Saklar3 DINYALAKAN");}
            //Kendali Relay 4
            if(lastLine.indexOf("SAKLAR4 OFF") >= 0){
              StatusRLY4 = 1;
              gprs.sendSMS("085882444182","Saklar 4 Dimatikan");
              Serial.println("Relay4/Saklar4 DIMATIKAN");} 
              else if(lastLine.indexOf("SAKLAR4 ON") >= 0) {
              StatusRLY4 = 0;
              gprs.sendSMS("085882444182","Saklar 4 Dinyalakan");
              Serial.println("Relay4/Saklar4 DINYALAKAN");}
            //Kendali Semua LED
            if(lastLine.indexOf("ALL OFF") >= 0){
              StatusRLY1 = 1;
              StatusRLY2 = 1;
              StatusRLY3 = 1;
              StatusRLY4 = 1;
              gprs.sendSMS("085882444182","Semua Saklar Dimatikan");
              Serial.println("Semua Relay/Saklar DIMATIKAN");} 
              else if(lastLine.indexOf("ALL ON") >= 0) {
              StatusRLY1 = 0;
              StatusRLY2 = 0;
              StatusRLY3 = 0;
              StatusRLY4 = 0;
              gprs.sendSMS("085882444182","Semua Saklar Dinyalakan");
              Serial.println("Semua Relay/Saklar DINYALAKAN");}
             
            nextLineIsMessage = false;
          }
           
        }
         
        //Clear char array for next line of read
        for( int i = 0; i < sizeof(currentLine);  ++i ) {
         currentLine[i] = (char)0;
        }
        currentLineIndex = 0;
    } else {
      currentLine[currentLineIndex++] = lastCharRead;
    }
  }
}
