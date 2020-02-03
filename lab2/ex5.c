// exercise 5//
#include <stdio.h>
#include <stdbool.h>

int main(){
bool flag = true;

while (flag == true){
	printf("Please enter width and height:\n");
	int width;
	int height;
	scanf("%d", &width);
	if (width == 0){
		flag = false;
		continue;
	}
	scanf("%d", &height);
	if (height == 0){
		flag = false;
		continue;
	}
	
	if (width > 1){
		printf("+");
	}
	for (int i = 0; i < width - 2; i++){
		printf("-");
	}
	printf("+\n");
	for (int j = 0; j < height - 2; j++){
		if (width > 1){
			printf("|");
		}
		for (int i = 0; i < width - 2; i++){
			printf("~");
		}
		printf("|\n");
	}
	if (height > 1){
		if (width > 1){
			printf("+");
		}
		for (int k = 0; k < width - 2; k++){
			printf("-");
		}
		printf("+\n");
	}
}
printf("End\n");
return 0;
}
