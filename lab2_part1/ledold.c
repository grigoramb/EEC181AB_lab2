
// Simple test program 
int main(void)
{
	volatile int * led = (int *) 0xFF200040;
	// red LED address
	volatile int * switchptr = (int *) 0xFF200030;
	// SW slider switch address
	volatile int * keyptr = (int *) 0xFF200000;
	// KEY address
	volatile int * hex3hex0 = (int *) 0xFF200020;
	// HEX3_HEX0
	volatile int * hex5hex4 = (int *) 0xFF200010;
	// HEX5_HEX4
	int switch_value;
	int key_value;
	char H = 0x76;
	char E = 0x79;
	char L = 0x38;
	char O = 0x3f;
	char U = 0x3e;
	char R = 0x50;
	char D = 0x5e;

	int delayamt = 1000;
 
	

	char HELLO_UUORLD[13] = {H,E,L,L,O,0x00,U,U,O,R,L,D,'\0'};

	while (1)
	{
		switch_value = *(switchptr);
		*(hex3hex0) = switch_value;
//		*(led) = switch_value;
		key_value = *(keyptr);
		if(key_value  == 1)
		{
			if(delayamt == 0)
				delayamt = 1000;
			else
				delayamt = 0;
		}
		if(key_value == 2)
			delayamt += 100;
		if(key_value == 4)
			delayamt -= 100;
		if(key_value == 8)
			// switch patterns

		*(led) = key_value;
		//*(hex5hex4) = 0xFF;
		//*(hex3hex0) = 0xFFFF; 
		*(hex5hex4+1) = H;
		//*(hex5hex4) = E;
		//*(hex3hex0+3) = L;
		//*(hex3hex0+2) = L;
		//*(hex3hex0+1) = O;
	}
}

