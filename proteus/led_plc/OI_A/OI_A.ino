#define ON HIGH
#define OFF LOW
#define LED1 2
#define LED2 3
#define START A0
#define STOP A1

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
    digitalWrite(LED1, ON);
  }
  if(digitalRead(STOP)==LOW)
  {
    digitalWrite(LED1, OFF);
  }

}
