#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>

int main(){
  
	volatile int * reg = (int *) 0xFF200028; // reg base addr stores the delay between shifts

	// initialize to a medium delay
	*(reg) = 8000000;
	
	printf("Greetings and salutations\n");
	char c[80];
	int i;
	
	while(1){
		printf("Please enter a speed (1-9):");
		scanf("%s", c);
		fflush(stdin);

		i = c[0]-'0';
		// convert char to int

		if(strlen(c) > 1 || !isdigit(c[0]) || i < 1 || i > 9){
			printf("Try again idiot!\n");
			continue;
		} // make sure it is one char between 1 and 9
	        	
		switch(i){ // set a predefined speed on a scale from 1 to 9; 
			case 0: *reg = 0; break;
			case 1: *reg = 24000000;break;
			case 2: *reg = 16000000;break;
			case 3: *reg = 10000000;break;
			case 4: *reg = 8000000;break;
			case 5: *reg = 6000000;break;
			case 6: *reg = 4000000;break;
			case 7: *reg = 2500000;break;
			case 8: *reg = 1000000;break;
			case 9: *reg = 500000;break;
		}
	}
	return 0;
}
