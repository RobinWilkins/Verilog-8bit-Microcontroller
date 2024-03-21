module ALUmodule
	( 
		input wire [7:0] operand1,
		input wire [7:0] operand2,
		output reg [7:0] aluResult,
		input wire [2:0] operationSelect,
		output reg [3:0] NZVCflags
	); 
	
	reg carryFlag;
	
	reg negativeFlag;
	
	reg zeroFlag;
	
	reg overflowFlag;
		
	always@(operand1, operand2, operationSelect)
	begin
		case(operationSelect)
			3'b000: {carryFlag, aluResult} = operand1 + operand2;
			3'b001: {carryFlag, aluResult} = operand1 - operand2;
			3'b010: aluResult = operand1 & operand2; 						//logical AND
			3'b011: aluResult = operand1 | operand2; 						//logical OR
			3'b100: {carryFlag, aluResult} = operand1 + 1'b1;				//increment op1
			3'b101: {carryFlag, aluResult} = operand2 + 1'b1;				//increment op2
			3'b110: {carryFlag, aluResult} = operand1 - 1'b1;				//decrement op1
			3'b111: {carryFlag, aluResult} = operand2 - 1'b1;				//decrement op2
			default: aluResult = 8'b11111111;
		endcase
		
	end
	
	always@(*)
	begin
		if (aluResult == 8'b0000000)
			zeroFlag <= 1'b1;
		else
			zeroFlag <= 1'b0;
			
		if (((operand1[7] == 1'b1) && (operand2[7] == 1'b1) && (aluResult[7] == 1'b0)) || ((operand1[7] == 1'b0) && (operand2[7] == 1'b0) && (aluResult[7] == 1'b1)))
			overflowFlag <= 1'b1;
		else
			overflowFlag <= 1'b0;
			
		negativeFlag <= aluResult[7];
		NZVCflags <= {negativeFlag, zeroFlag, overflowFlag, carryFlag};
		
		
	end
	
endmodule