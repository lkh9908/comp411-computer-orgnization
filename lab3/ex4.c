/* Exercise 4: matrices represented by 2-dimensional arrays */

#include <stdio.h>

int main()
{
  int A[3][3];    // matrix A     
  int B[3][3];    // matrix B
  int C[3][3];    // matrix to store their sum

  // add your code below
  
  printf("Please enter 9 values for matrix A:\n");
  for (int i = 0; i < 3; i++){
	for (int j = 0; j < 3; j++){
		scanf("%d", &A[i][j]);
	}
  }

  printf("Please enter 9 values for matrix B:\n");
  for (int i = 0; i < 3; i++){
        for (int j = 0; j < 3; j++){
                scanf("%d", &B[i][j]);
        }
  }

  for (int i = 0; i < 3; i++){
        for (int j = 0; j < 3; j++){
                int sum = A[i][j] + B[i][j];
		C[i][j] = sum;
        }
  }

  printf("C = B + A =\n");
  for (int i = 0; i < 3; i++){
        printf("%10d%10d%10d\n", C[i][0], C[i][1], C[i][2]);
  }

  return 0;
}

