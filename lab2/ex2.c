#include <stdio.h>

int main(){
	double x;
	printf("Enter 10 floating-point numbers:\n");
	
	scanf("%lf", &x);
	double sum = x;
	double product = x;
	double min = x;
	double max = x;

	for (int i = 0; i < 9; i++){
		double temp;
		scanf("%lf", &temp);
		sum = sum + temp;
		product = product * temp;
		if(temp > max){
			max = temp;
		}
		if(temp < min){
			min = temp;
		}
	}
	printf("Sum is %0.5lf\n", sum);
	printf("Min is %0.5lf\n", min);
	printf("Max is %0.5lf\n", max);
	printf("Product is %0.5lf\n", product);
}
