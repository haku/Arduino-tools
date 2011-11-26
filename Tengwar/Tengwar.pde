/*
 * The circuit:
 * LCD RS pin to digital pin 12
 * LCD Enable pin to digital pin 11
 * LCD D4 pin to digital pin 5
 * LCD D5 pin to digital pin 4
 * LCD D6 pin to digital pin 3
 * LCD D7 pin to digital pin 2
 * LCD R/W pin to ground
 * 10K resistor:
 * ends to +5V and ground
 * wiper to LCD VO pin (pin 3)
 * http://www.arduino.cc/en/Tutorial/LiquidCrystal
 */

#include <LiquidCrystal.h>
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

byte teng_a[8] = {
  B00000,
  B11111,
  B01001,
  B10001,
  B10011,
  B01101,
  B00000,
};
byte teng_e[8] = {
  B00000,
  B01000,
  B01100,
  B00110,
  B01011,
  B10001,
  B00000,
};
byte teng_i[8] = {
  B00000,
  B00110,
  B00100,
  B00100,
  B00100,
  B01110,
  B00000,
};
byte teng_o[8] = {
  B00000,
  B01001,
  B10001,
  B10001,
  B10011,
  B01101,
  B00000,
};
byte teng_u[8] = {
  B00000,
  B10110,
  B11001,
  B10001,
  B10010,
  B11111,
  B00000,
};
byte teng_m[8] = {
  B00000,
  B11110,
  B10101,
  B10101,
  B10101,
  B11010,
  B00000,
};
byte teng_y[8] = {
  B00000,
  B01100,
  B01100,
  B01100,
  B01100,
  B01100,
  B01000,
};
byte teng_r[8] = {
  B10010,
  B10001,
  B01011,
  B01110,
  B11000,
  B10000,
  B01100,
};
byte teng_f[8] = {
  B10000,
  B10000,
  B10110,
  B11001,
  B10001,
  B10010,
  B11111,
};
void setup() {
  lcd.createChar(0,teng_a);
  lcd.createChar(1,teng_e);
  lcd.createChar(2,teng_i);
  lcd.createChar(3,teng_o);
  lcd.createChar(4,teng_u);
  lcd.createChar(5,teng_m);
  lcd.createChar(6,teng_y);
  lcd.createChar(7,teng_r);
  lcd.createChar(8,teng_f);
  
  lcd.begin(8, 2);
  
  lcd.write(5);
  lcd.write(1);
  lcd.write(5);
  lcd.write(3);
  lcd.write(7);
  lcd.write(6);
  lcd.write(' ');
  lcd.write(8);
  lcd.setCursor(0,1);
  lcd.write(7);
  lcd.write(1);
  lcd.write(1);
  
}

void loop() {
  String n = String(millis()/1000);
  lcd.setCursor(8 - n.length(),1);
  lcd.print(n);
}

