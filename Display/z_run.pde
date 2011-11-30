LiquidCrystal lcd(22, 23, 24, 25, 26, 27);

String buff = "";
boolean err = false;

void setup() {
  Serial.begin(9600);
  lcd.begin(8, 2);
  Serial.println("Ready.");
}

void loop() {
  while (Serial.available() > 0) {
    char datum = Serial.read();
    if (datum == '\n') {
      String msg = buff.substring(0, 16);
      int length = msg.length();
      Serial.println("msg=" + msg);
      
      lcd.clear();
      lcd.print(msg.substring(0, length < 8 ? length : 8));
      if (length > 8) {
        lcd.setCursor(0,1);
        lcd.print(msg.substring(8, length < 16 ? length : 16));
      }
      
      err = false;
      buff = "";
    }
    else if (buff.length() < 16) {
      buff += datum;
    }
    else if (!err) {
      Serial.println("Data too long.");
      err = true;
    }
  }
}

