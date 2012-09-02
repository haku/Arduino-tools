String inBuffer = "";

const int DISP_COUNT = 2;

const int MODE_RAIN = 0;
const int MODE_DATA = 1;
int mode = MODE_RAIN;

const int DATA_COUNT = 16 * DISP_COUNT;
char data_key[DATA_COUNT];
int data_value[DATA_COUNT];

void setup () {
  Serial.begin(9600);

  HT1632.begin(11, 12, 10, 9); // HT1632.begin(pinCS1 [, pinCS2 [, pinCS3 [, pinCS4]]], pinWR, pinDATA); // Nano
  
  HT1632.drawTarget(BUFFER_BOARD(1));
  HT1632.setBrightness(2);
  HT1632.drawTarget(BUFFER_BOARD(2));
  HT1632.setBrightness(1);
}

void loop () {
  switch (mode) {
    case 0:
      mode = doScroll();
      break;
    case 1:
      mode = doData();
      break;
  }
}

void serialEvent () {
  while (Serial.available()) {
    char inChar = (char)Serial.read();
    inBuffer += inChar;
    if (inChar == '\n') {
      procIn();
      inBuffer = "";
    }
  }
}

void procIn () {
  if (inBuffer.length() >= 2) {
    char key = inBuffer.charAt(0);
    int x = indexOfOrAdd(data_key, key);
    if (x >= 0) {
      data_value[x] = inBuffer.charAt(1) - '0';
      printData();
    }
  }
}

int doData () {
  if (data_key[0] != 0) { // FIXME hack.
    HT1632.drawTarget(BUFFER_BOARD(2));
    HT1632.clear();
    HT1632.drawTarget(BUFFER_BOARD(1));
    HT1632.clear();
    int current_board = 1;
    for (int i = 0; i < DATA_COUNT; i++) {
      if (data_key[i] != NULL) {
        int x = i * 2;
        if (x > 31) { // FIXME dirty hack.
          if (current_board < 2) HT1632.drawTarget(BUFFER_BOARD(2));
          x -= 32;
        }
        if (data_value[i] > 0) {
          for (int y = 0; y < data_value[i]; y++) {
            HT1632.setPixel(x, y, 1);
          }
        }
        else {
          HT1632.setPixel(x, 7, 1);
        }
      }
    }
    HT1632.render();
    delay(1000); // No point spinning faster than this.
    return MODE_DATA;
  }
  else {
    return MODE_RAIN;
  }
}

void printData() {
  Serial.print("data:");
  for (int i = 0; i < DATA_COUNT; i++) {
    if (data_key[i] != NULL) {
      Serial.print(" ");
      Serial.print(data_key[i]);
      Serial.print("=");
      Serial.print(data_value[i]);
    }
  }
  Serial.println();
}

int phase = 0;
int disp = 0;
int scroll_x = 0;
int doScroll () {
  HT1632.drawTarget(BUFFER_BOARD(DISP_COUNT - disp));
  int offset = (phase / 2);
  bool state = !(phase % 2);
  HT1632.setPixel(32 - scroll_x, 0 + offset, state);
  HT1632.setPixel(32 - scroll_x, 7 - offset, state);
  HT1632.render();
  
  scroll_x += 1;
  if (scroll_x > 32) {
    scroll_x = 0;
    disp += 1;
    if (disp > (DISP_COUNT - 1)) {
      disp = 0;
      phase += 1;
      if (phase > 7) {
        phase = 0;
        return MODE_DATA;
      }
    }
  }
  return MODE_RAIN;
}

int indexOfOrAdd (char arr[], char x) {
  for (int i = 0; i < DATA_COUNT; i++) {
    if (arr[i] == x) {
      return i;
    }
    else if (arr[i] == NULL) {
      arr[i] = x;
      return i;
    }
  }
  return -1;
}

/*
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
*/

