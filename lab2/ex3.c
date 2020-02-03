// exercise 3 //
#include <stdio.h>

int main(){
printf("Enter six integers:\n");

int values[6];
for (int i = 0; i < 6; i++){
	int val;
	scanf("%i", &val);
	values[i] = val;
}

printf("1234567890bb1234567890\n");
for (int i = 0; i < 6; i++){
	printf("%10d", values[i]);
	printf("%12d\n", values[i + 1]);
	i = i+1;
}	
return 0;
}
