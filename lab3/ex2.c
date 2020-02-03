/* Exercise 2 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>

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
  
  /* Analyse contents of text[]: reverse it and look for potential palindrome */
  /* Include case, spaces, and punctuation */

  bool palin = true;
  for (i = 0; i < length/2; i++){
	if (text[i] != text[length - 1 - i]){
		palin = false;
	}
	c = text[i];
	text[i] = text[length - 1 -  i];
	text[length - 1 - i] = c;
  }
  printf("Your input in reverse is:\n");
  printf("%s", text);

  if(palin == true){
	printf("Found a palindrome!\n");
  }
}
