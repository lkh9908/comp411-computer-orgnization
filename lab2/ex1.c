/* exercise 1 */

#include <stdio.h>

int main()
{
	int x;
	printf("Enter a number from 1 to 20:\n");
	scanf("%d", &x);
	
	if (x > 20 || x < 1){ 
		printf("Number is not in the range from 1 to 20\n");
	}else{
		printf("Here are the first %d ordinal numbers:\n", x);
		for (int i = 0; i < x; i++){
			if(i == 0){
				printf("1st\n");
			}else if(i == 1){
				printf("2nd\n");
			}else if(i == 2){
				printf("3rd\n");
			}else{
				int num = i+1;
				printf("%dth\n", num);
			}
		}
	}
}
