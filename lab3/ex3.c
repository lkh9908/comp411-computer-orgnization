/* Exercise 3 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>

#define MAX 1000 /* The maximum number of characters in a line of input */

int main()
{
  char text[MAX], c;
  int i;
  int lowercase, uppercase, digits, other;
  int length;
  
  printf("Type some text (then ENTER):\n");
  
  /* Save typed characters in text[]: */
    
  fgets(text, MAX, stdin);
  length = strlen(text)-1;
  
  /* Analyse contents of text[]: reverse it */

  bool palin = true;
  for (i = 0; i < length/2; i++){
	c = text[i];
	text[i] = text[length - 1 -  i];
	text[length - 1 - i] = c;
  }
  printf("Your input in reverse is:\n");
  printf("%s", text);

  /* check for palindrome, does not include case, space, or space */

  char newText[MAX];
  int newI = 0;
  for (i = 0; i < length; i++){
	c = text[i];
	if (isspace(c)!=0||ispunct(c)!=0){
		continue;
	}
	if (isalpha(c)!=0){
		newText[newI] = tolower(c);
		newI++;
	} else {
		newText[newI] = text[i];
		newI++;
	}
  }
  newText[newI] = '\0';

  /*  printf("%s\n", newText); */

  int newLength = strlen(newText);
  for (i = 0; i < newLength/2; i++){
	 if (newText[i] != newText[newLength-1-i]){
		palin = false;
	}
  }

  if(palin == true){
	printf("Found a palindrome!\n");
  }
}
