#include<stdio.h>

int NchooseK(int n, int k);

int main() {

  int n, k, result;

    // Do the following inside a loop
    // ...
  while(n != 0){

    scanf("%d", &n);
    if(n == 0){
	break;
    }
    // ...
    scanf("%d", &k);
    result = NchooseK(n, k);
    printf("%d\n", result);

    //  ...
  }
}



int NchooseK(int n, int k) {
    // recursive implementation
    //  ...
    //  ...
if (n != 0) {
        if (k == 0){
                return 1;
        } else if (n == k){
                return 1;
        } else {
                return NchooseK(n-1, k-1) + NchooseK(n-1, k);
        }
  }
  return 0;
}
