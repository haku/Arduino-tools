void setup () {
  HT1632.begin(12, 11, 10, 9); // HT1632.begin(pinCS1 [, pinCS2 [, pinCS3 [, pinCS4]]], pinWR, pinDATA); // Mega
//  HT1632.begin(11, 10, 9); // HT1632.begin(pinCS1 [, pinCS2 [, pinCS3 [, pinCS4]]], pinWR, pinDATA); // Nano
  
  HT1632.drawTarget(BUFFER_BOARD(1));
  HT1632.setBrightness(1);
  HT1632.drawTarget(BUFFER_BOARD(2));
  HT1632.setBrightness(2);
}

void loop () {
//  clock();
  scroll();
}

int phase = 1;
int disp = 0;
int scroll_x = 0;
char bug[] = {'>'};
void scroll () {
  HT1632.drawTarget(BUFFER_BOARD(disp + 1));
  HT1632.setPixel(scroll_x, 0, phase);
  HT1632.setPixel(scroll_x, 7, phase);
//  HT1632.drawText(bug, scroll_x, 2, FONT_5X4, FONT_5X4_WIDTH, FONT_5X4_HEIGHT, FONT_5X4_STEP_GLYPH);
  HT1632.render();
  
  scroll_x += 1;
  if (scroll_x > 32) {
    scroll_x = 0;
    disp += 1;
    if (disp > 1) {
      disp = 0;
      phase += 1;
      if (phase > 1) {
        phase = 0;
      }
    }
  }
  delay(10);
}

void clock () {
  String s = String(millis() / 100, DEC);
  char a[10];
  s.toCharArray(a, 10);
  int w = HT1632.getTextWidth(a, FONT_5X4_WIDTH, FONT_5X4_HEIGHT);
  int x = 32 - w;
  
  HT1632.drawTarget(BUFFER_BOARD(1));
  HT1632.clear();
  HT1632.drawText(a, x, 3, FONT_5X4, FONT_5X4_WIDTH, FONT_5X4_HEIGHT, FONT_5X4_STEP_GLYPH);
  HT1632.render();

  HT1632.drawTarget(BUFFER_BOARD(2));
  HT1632.clear();
  HT1632.drawText(a, 0, 0, FONT_5X4, FONT_5X4_WIDTH, FONT_5X4_HEIGHT, FONT_5X4_STEP_GLYPH);
  HT1632.render();

  delay(100);
}

