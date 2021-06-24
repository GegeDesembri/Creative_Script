#include <DHT.h>  //Memasukan Library DHT ke Program

#define DHTPIN 2  //menggunakan pin 2 untuk pemasangan sensornya
#define DHTTYPE DHT11 //memilih tipe DHT11, bisa diubah menjadi DHT22, DHT21

DHT dht(DHTPIN, DHTTYPE);  //setting pin yang dipilih dan tipe DHT

void setup() {
Serial.begin(9600);  //komunikasi Serial dengan komputer
dht.begin(); //Komunikasi DHT dengan Arduino
}

void loop() {

float kelembaban = dht.readHumidity(); //menyimpan nilai Humidity pada variabel kelembaban
float suhu = dht.readTemperature(); //menyimpan nilai Temperature pada variabel suhu

Serial.print(" Kelembaban: "); //menampilkan tulisan Kelembaban di Serial Monitor
Serial.print(kelembaban); //menampilkan nilai kelembaban
Serial.print(" Suhu: "); //menampilkan tulisan suhu
Serial.println(suhu); //menampilkan nilai suhu

delay(500); //memberi jeda waktu baca selama 500 mili detik
}
