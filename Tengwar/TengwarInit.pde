// Alas can only have 8 characters at a time.

//int teng_a = 0;
int teng_e = 1;
//int teng_i = 2;
int teng_o = 3;
//int teng_u = 4;
int teng_f = 0;
int teng_m = 5;
int teng_r = 7;
int teng_y = 6;

void createTengware(LiquidCrystal l) {
//  l.createChar(teng_a,teng_a_def);
  l.createChar(teng_e,teng_e_def);
//  l.createChar(teng_i,teng_i_def);
  l.createChar(teng_o,teng_o_def);
//  l.createChar(teng_u,teng_u_def);
  
  l.createChar(teng_f,teng_f_def);
  l.createChar(teng_m,teng_m_def);
  l.createChar(teng_r,teng_r_def);
  l.createChar(teng_y,teng_y_def);
}

void printTengwarChar(LiquidCrystal l, char c) {
  switch (c) {
//    case 'a': l.write(teng_a); break;
    case 'e': l.write(teng_e); break;
//    case 'i': l.write(teng_i); break;
    case 'o': l.write(teng_o); break;
//    case 'u': l.write(teng_u); break;

    case 'f': l.write(teng_f); break;
    case 'm': l.write(teng_m); break;
    case 'r': l.write(teng_r); break;
    case 'y': l.write(teng_y); break;
  }
}

