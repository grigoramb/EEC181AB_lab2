#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdint.h>

int main(){
  
	//volatile uint32_t * reg = (uint32_t *) 0xFF200028; // reg base addr
	volatile int * reg = (int *) 0xFF200028; // reg base addr

	printf("Greetings and salutations\n");

	char buffer[16];
	int i;
	int valid = 1; // valid flag
	unsigned long long int num;
	while(1){
		printf("Please enter a 32 bit integer (q to quit):");
		scanf("%s", buffer);
		//gets(buffer);
		
		if(buffer[0] == 'q')
			break;	// exit on q

		for(i = 0; i < strlen(buffer); i++)
			if(!isdigit(buffer[i]))
			{
				valid = 0;
				break;
			}	// check each digit

		if(valid == 0)
			printf("Invalid character. Try again\n");
		else	// convert to int
		{	
			num = atoll(buffer);
			if(num <= 4294967295) // largest 32 bit int
				*(reg) = num;
			else
				printf("Number too big\n");
		}
		valid = 1;
		}
	return 0;
}
