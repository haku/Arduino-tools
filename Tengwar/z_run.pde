LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup() {
  createTengware(lcd);
  lcd.begin(8, 2);
  
  lcd.write(162);
  printTengwarChar(lcd, 'm');
  printTengwarChar(lcd, 'e');
  printTengwarChar(lcd, 'm');
  printTengwarChar(lcd, 'o');
  printTengwarChar(lcd, 'r');
  printTengwarChar(lcd, 'y');
  printTengwarChar(lcd, 'f');
  lcd.setCursor(0,1);
  printTengwarChar(lcd, 'r');
  printTengwarChar(lcd, 'e');
  printTengwarChar(lcd, 'e');
  lcd.write(163);
}

void loop() {
  String n = String(millis()/1000);
  lcd.setCursor(8 - n.length(),1);
  lcd.print(n);
}

