
// You are given a toUpperCase(int c) function that works.
//
// You are given an integer between 0-255 that corresponds to a random letter that is upper case or lower case.
//
// So 0 could be lower case a. 102 could be upper case A.
//
// Write a function toLowerCase(int c) that returns the integer corresponding to the lower case letter of c.
//
// You have 10 minutes

int toLowerCase(int c) {
  if(toUpperCase(c) != c) {
    return c;
  }
  int i;
  for(i = 0; i <= 255; i++) {
    if(toUpperCase(i) == c && i!=c) {
      return i;
    }
  }
}
