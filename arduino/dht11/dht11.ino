#include <DHT.h> //Library DHT

#define DHTPIN A2 //PIN yang terhubung pada pinout DHT11
#define DHTTYPE DHT11 //Tipe DHT => DHT11

DHT dht(DHTPIN, DHTTYPE); //Konfigurari DHT11

int t; //Variabel Suhu
int h; //Variabel Kelembaban

void setup() {
  Serial.begin(115200); //Memulai koneksi Serial antara Arduino dengan PC
  dht.begin(); //Memulai koneksi antara Arduino dengan DHT11
}

void loop() 
{ 
  t = dht.readTemperature(); //Membaca data suhu
  h = dht.readHumidity(); //Membaca data kelembaban
  delay(2000); //Delay 2 detik (Membacaan di lakukan setiap 2 detik sekali

  //Menampilkan ke dalam Serial Monitor
  Serial.print("Suhu = ");
  Serial.print(t);
  Serial.print("*C");
  Serial.print("     ");
  Serial.print("Kelembaban = ");
  Serial.print(h);
  Serial.println("H");
}
