/* 2025 Levi D. Smith */
#include <stdio.h>
#include <string.h>
#define MAX_LINE_SIZE 65536

int main(void) {
  FILE *f;
  f = fopen("../input01.txt", "r");
  char strLine[MAX_LINE_SIZE];
  while ( fgets(strLine, MAX_LINE_SIZE, f) ) {
/*    printf("%s", strLine); */

    int i;
    int iValue = 0;
    for (i = 0; i < strlen(strLine); i++) {
/*      printf("%c", strLine[i]); */
      switch(strLine[i]) {
        case '(':
          iValue++;
	  break;
	case ')':
	  iValue--;
	  break; 
      }
    }
    printf("%d\n", iValue);
  }
  fclose(f);
  return 0;
}
