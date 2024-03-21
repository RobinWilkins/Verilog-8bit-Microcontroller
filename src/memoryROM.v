module memoryROM
	(
		clk,
		programMemoryOutput,
		address
	);

	input clk; 
	
	output programMemoryOutput;
	reg [7:0] programMemoryOutput;
	
	input [7:0] address;

	reg [7:0] memorySpace [0:255];

initial begin

				//test program 1
//	memorySpace[0] = 8'h01; //load a rom
//	memorySpace[1] = 8'h05; //value 5 for load
//	
//	memorySpace[2] = 8'h0B; //inc a
//	memorySpace[3] = 8'h0B; //inc a
//	memorySpace[4] = 8'h0B; //inc a
//	memorySpace[5] = 8'h0B; //inc a
//	memorySpace[6] = 8'h0B; //inc a
//	memorySpace[7] = 8'h0B; //inc a
//	
//	memorySpace[8] = 8'h05; //store a to ram
//	memorySpace[9] = 8'h05; //ram address 5
//	
//	memorySpace[10] = 8'h05; //store a to ram
//	memorySpace[11] = 8'h06; //ram address 6
//	
//	memorySpace[12] = 8'h05; //store a to ram
//	memorySpace[13] = 8'h07; //ram address 7
//	
//	memorySpace[14] = 8'h05; //store a to ram
//	memorySpace[15] = 8'h08; //ram address 8
//	
//	memorySpace[16] = 8'h05; //store a to ram
//	memorySpace[17] = 8'h09; //ram address 9
//	
//	memorySpace[18] = 8'h05; //store a to ram
//	memorySpace[19] = 8'h0A; //ram address 10
//	
//	memorySpace[20] = 8'h04; //load b from ram
//	memorySpace[21] = 8'h09; //ram address 9


				//test program 2
//	memorySpace[0] = 8'h01;				//load a from rom
//	memorySpace[1] = 8'b01111100;		//value to load into a
//	
//	memorySpace[2] = 8'h0B;				//increment a
//	
//	memorySpace[3] = 8'h14;				//branch if not negative
//	memorySpace[4] = 8'h02;				//address to branch to
//	
//	memorySpace[5] = 8'h02;				//load b from rom
//	memorySpace[6] = 8'b00000001;		//value to load into b
//	

				//test program 3
	memorySpace[0] = 8'h01;				//load a from rom
	memorySpace[1] = 8'b10101010;		//value to load into a
	memorySpace[2] = 8'h18;				//display contents of A on data output
	
	memorySpace[3] = 8'h0B;				//increment a
	memorySpace[4] = 8'h0B;				//increment a
	memorySpace[5] = 8'h0B;				//increment a
	
	memorySpace[6] = 8'h18; 			//display contents of A on data output
	
	memorySpace[7] = 8'h02;				//load b from rom
	memorySpace[8] = 8'b00001111;		//value to load into b
	
	memorySpace[9] = 8'h19;				//display contents of B on data output
	
	memorySpace[10] = 8'h0C;			//increment b
	memorySpace[11] = 8'h0C;			//increment b
	memorySpace[12] = 8'h0C;			//increment b
	
	memorySpace[13] = 8'h19;			//display contents of B on data output
	
	memorySpace[14] = 8'h1A;			//clear data output register
	
	memorySpace[15] = 8'h18;			//display contents of A on data output
	memorySpace[16] = 8'h19;			//display contents of B on data output
	
end
	
always@(posedge clk)
begin
	programMemoryOutput <= memorySpace[address];
end
	
endmodule