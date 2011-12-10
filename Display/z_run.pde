LiquidCrystal lcd(22, 23, 24, 25, 26, 27);

int index = 0;
boolean err = false;

void setup() {
  Serial.begin(9600);
  lcd.begin(8, 2);
  
  index = 0;
  lcd.clear();
  lcd.write(B10100010);
  lcd.print("  Ready");
  lcd.setCursor(0,1);
  lcd.print("  ");
  lcd.write(B11000011);
  lcd.write(B11011110);
  lcd.write(B10111101);
  lcd.print("  ");
  lcd.write(B10100011);
  
  Serial.println();
  Serial.print("msg=");
}

void loop() {
  while (Serial.available() > 0) {
    char datum = Serial.read();
    if (datum == '\n') {
      index = 0;
      err = false;
      Serial.println();
      Serial.print("msg=");
    }
    else if (index < 16) {
      if (index == 0) {
        lcd.clear();
      }
      else if (index == 8) {
        lcd.setCursor(0,1);
      }
      lcd.print(datum);
      index++;
      Serial.print(datum);
    }
    else if (!err) {
      Serial.println();
      Serial.println("Data too long.");
      err = true;
    }
  }
}

