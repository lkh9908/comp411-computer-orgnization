#include <stdio.h>

int A[10][10];
int B[10][10];
int C[10][10];

void recursiveSolve();
int x, y, z;
int size;

int main() {
	// code here

int i, j;

scanf("%d", &size);
for (i = 0; i < size; i++){
	for (j = 0; j < size; j++){
		scanf("%d", &A[i][j]);
	}
}

for (i = 0; i < size; i++){
        for (j = 0; j < size; j++){
                scanf("%d", &B[i][j]);
        }
}

x = 0; y = 0; z = 0;
recursiveSolve(A, B, size);

for (i = 0; i < size; i++){
        for (j = 0; j < size; j++){
                printf("%6d", C[i][j]);
        }
	printf("\n"); 
}
}

void recursiveSolve(){ 

// all square matrix
// if 2*2 * 2*2
// 00 01    00 01
// 10 11    10 11
// = 00*00+01*10    00*01+01*11
//   10*00+11*10    10*01+11*11
// x = roll of A; y = col of B; z = colOfA and rolOfB
    if (x >= size) return;

    if (y < size){
      if (z < size){
         C[x][y] += A[x][z] * B[z][y];
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
