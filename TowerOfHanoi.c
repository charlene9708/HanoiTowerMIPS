#include<stdio.h>

void TOH(int n, int start, int destination, int extra ){
	if (n != 0){
		TOH(n-1, start, extra, destination);
		printf("Moved disk %d from peg %d to peg %d \n", n, start, destination);
		TOH(n-1, extra, destination, start);	
	}

int main(){
	int n;
	printf("Please enter the number of disks: \n");
	scanf ("%d", &n);
	TOH(n, 1, 2, 3);
	return 0;
}

