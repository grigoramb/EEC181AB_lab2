// Simple test program 
int main(void)
{
	volatile int * led = (int *) 0xFF200040; // red LED address

	volatile int * switchptr = (int *) 0xFF200030; // switch address

	volatile int * keyptr = (int *) 0xFF200000; // KEY address

	volatile int * hex3hex0 = (int *) 0xFF200020; // HEX3_HEX0

	volatile int * hex5hex4 = (int *) 0xFF200010; // HEX5_HEX4

	int switch_value;
	int key_value;

	int H = 0x76;
	int E = 0x79;
	int L = 0x38;
	int O = 0x3f;
	int U = 0x3e;
	int R = 0x50;
	int D = 0x5e;

	int delayamt = 1000;
 	int i, j, c, d;
	int pattern = 0; //start with hello
	int speed = 20000;
	int helloworld[22] = {0,0,0,0,0,H,E,L,L,O,0,U,U,O,R,L,D,0, 0,0,0,0};

	i = 0;

	while (1)
	{
		if(!pattern){

		*(hex5hex4) = (helloworld[i]<<8)+helloworld[i+1];
		*(hex3hex0) = (helloworld[i+2]<<24) + (helloworld[i+3]<<16) + (helloworld[i+4]<<8) + helloworld[i+5];

		for ( c = 1 ; c <= speed ; c++ )
       	for ( d = 1 ; d <= speed ; d++ )
       	{ } //for loops

       	i = (i+1)%17;

		key_value = *(keyptr);
		
		switch(key_value){

			case(1):
				pattern = 1; //change pattern
				for (j = 0; j < 499999; j++){}
				break;
			case(2):
				speed = speed -10000;
				for (j = 0; j < 499999; j++){}
break;
			case(3):
				speed = speed +10000;
				for (j = 0; j < 499999; j++){}
				break;

			//case(4): //pause
				

		}	

		


	} //if
		

		//pattern so use switches
		*(hex5hex4) = 0;
		*(hex3hex0)= 0;
		switch_value = *(switchptr);
		*(hex3hex0) = switch_value;
	}

}
