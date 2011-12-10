#include <font_5x4.h>
#include <HT1632.h>
#include <images.h>

void setup () {
  HT1632.begin(12, 10, 9); // HT1632.begin(pinCS1 [, pinCS2 [, pinCS3 [, pinCS4]]], pinWR, pinDATA);
  HT1632.drawTarget(BUFFER_BOARD(1));
  HT1632.setBrightness(5);
}  

void loop () {
  String s = String(millis() / 1000, DEC);
  char a[10];
  s.toCharArray(a, 10);
  int w = HT1632.getTextWidth(a, FONT_5X4_WIDTH, FONT_5X4_HEIGHT);
  int x = 32 - w;
  
  HT1632.clear();
  HT1632.drawText(a, x, 3, FONT_5X4, FONT_5X4_WIDTH, FONT_5X4_HEIGHT, FONT_5X4_STEP_GLYPH);
  HT1632.render();

  delay(1000);
}
