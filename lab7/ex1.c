#include <stdio.h>

int AA[100];  		// linearized version of A[10][10]
int BB[100];  		// linearized version of B[10][10]
int CC[100];  		// linearized version of C[10][10]
int m;       		// actual size of the above matrices is mxm, where m is at most 10



void recursiveSolve();
int x, y, z;
int size;

int main() {
	// code here

int i;

scanf("%d", &size);
for (i = 0; i < size*size; i++){
	scanf("%d", &AA[i]);
}

for (i = 0; i < size*size; i++){
        scanf("%d", &BB[i]);
}

x = 0; y = 0; z = 0;
recursiveSolve();

int j = 0;
for (i = 0; i < size; i++){
	for (j = 0; j < size; j++){
        	printf("%d ", CC[i*size + j]);
	}
	printf("\n");
}
}

void recursiveSolve(){
// all square matrix
// if 2*2 * 2*2
// 0 1    0 1
// 2 3    2 3
// = 00+12    01+13
//   20+32    21+33
// x = roll of A; y = col of B; z = colOfA and rolOfB

    if (x >= size) return;

     if (y < size){
      if (z < size){
         CC[x*size+y] += AA[x*size+z] * BB[z*size+y];
         z++;
         recursiveSolve();
      }
      z = 0;
      y++;
      recursiveSolve();
}

    y = 0;
    x++;
    recursiveSolve();
}

