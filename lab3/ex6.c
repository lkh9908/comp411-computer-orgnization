/* Exercise 6 */

#include <stdio.h>
#include <string.h>


int NchooseK(int n, int k){
  if (n != 0) {
  	if (k == 0){
        	return 1;
  	} else if (n == k){
        	return 1;
  	} else {
        	return NchooseK(n-1, k-1) + NchooseK(n-1, k);
  	}
  }
  return 1;
}

int main () {
  int n = 1;
  int k = 1;
  while (n != 0 || k != 0){
	printf("Enter two integers (for n and k) separated by space:\n");
	scanf("%d", &n);
	scanf("%d", &k);
	int solution = NchooseK(n, k);
	printf("%d\n", solution);
  }
  return 0;
}



