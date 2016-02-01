#define HELLO 0
#define CUSTOM 1

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

	int delayamt = 16000;
 	int i, j, c, d;
	

	int helloworld[22] = {0,0,0,0,0,H,E,L,L,O,0,U,U,O,R,L,D,0,0,0,0,0};
	int pause = 0;
	i = 0;
	int mode = HELLO;
	int custom[10] = {0,0,0,0,0,0,0,0,0,0,0};
        int i1 = 0;	
	while (1)
	{
          switch_value = *(switchptr);
	  *(led) = switch_value; // show switch status on LEDs
	  key_value = *(keyptr);
	  if(key_value == 1) // KEY0
	  { 
	    mode = !mode;
	    custom[5] = 0x7F & switch_value; 
	    custom[4] = 0x7 & (switch_value>>7);
	  }
	  if(key_value == 2) // KEY1
	    delayamt += 1000;
	  if(key_value == 4) // KEY2
	    delayamt -= 1000;
	  if(key_value == 8) // KEY3
	    pause = !pause;
	  if(key_value)
	    for ( c = 1; c <= 20000; c++ );

	  
	  if(mode == HELLO){
		*(hex5hex4) = (helloworld[i]<<8)+helloworld[i+1];
		*(hex3hex0) = (helloworld[i+2]<<24) + (helloworld[i+3]<<16) + (helloworld[i+4]<<8) + helloworld[i+5];
       		i = (i+ !pause)%17;
	   }
	  else{ // CUSTOM
		*(hex5hex4) = (custom[i]<<8)+custom[i+1];
		*(hex3hex0) = (custom[i+2]<<24) + (custom[i+3]<<16) + (custom[i+4]<<8) + custom[i+5];
       		i = (i+ !pause)%7;
	   }
		for ( c = 1 ; c <= delayamt ; c++ )
		for ( d = 1 ; d <= delayamt ; d++ )
		{}

		

	}
}
