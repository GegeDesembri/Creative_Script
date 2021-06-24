#define ON HIGH
#define OFF LOW
#define LED1 2
#define LED2 3
#define START A0
#define STOP A1

int ledd;

void setup()
{
  pinMode(START, INPUT);
  pinMode(STOP, INPUT);

  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);

}

void loop() {
  if(digitalRead(START)==HIGH)
  {
    ledd=ledd+1;
  }
  if(digitalRead(STOP)==HIGH)
  {
    ledd=0;
  }
  
  if(ledd>=1)
  {
    digitalWrite(LED1, ON);
    delay(250);
    digitalWrite(LED1, OFF);
    digitalWrite(LED2, ON);
    delay(250);
    digitalWrite(LED2, OFF);
  }

  if(ledd==0)
  {
    digitalWrite(LED1, OFF);
    digitalWrite(LED2, OFF);
  }
}
