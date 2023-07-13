`timescale 1ns / 1ps
//to perform random ALU R5= (R4=((R1=10)+(R2=20))+R3=25)
module test_mips32;

	// Inputs
	reg clk1;
	reg clk2;
	integer k;

	// Instantiate the Unit Under Test (UUT)
	pipe_MIPS32 mips (
		.clk1(clk1), 
		.clk2(clk2)
	);

	initial begin
		// Initialize Inputs
		clk1 = 0;
		clk2 = 0;

		// Wait 100 ns for global reset to finish
		
		//#100;
		
       // Add stimulus here 
		repeat (20)
		   begin
			   #5 clk1 = 1; #5 clk1 = 0; // generating two phase clock
				#5 clk2 = 1; #5 clk2 = 0;
		   end

	end
	
	initial begin
	   for (k=0; k<31; k=k+1)
		  mips.Reg[k] = k; //initialize registers as R0=0,R1=1,R2=2...
		  
		  mips.Mem[0] = 32'h2801000a;  // ADD R1, R0, 10
        mips.Mem[1] = 32'h28020014;  // ADD R2, R0, 20	
        mips.Mem[2] = 32'h28030019;  // ADD R3, R0, 25
        mips.Mem[3] = 32'h0ce77800;  // OR R7, R7, R7--dummy instruction
        mips.Mem[4] = 32'h0ce77800;  // OR R7, R7, R7--dummy instruction		  
        mips.Mem[5] = 32'h00222000;  // ADD R4, R1, R2
		  mips.Mem[6] = 32'h0ce77800;  // OR R7, R7, R7--dummy instruction
		  mips.Mem[7] = 32'h00832800;  // ADD R5, R4, R3
		  mips.Mem[8] = 32'hfc000000;  // halt
		  
		  mips.HALTED = 0;
		  mips.pc = 0;
		  mips.TAKEN_BRANCH = 0;
		  #280
		  
		  for (k=0; k<6; k=k+1)
		  $display ("R%d - %2d", k, mips.Reg[k]);
		  end
		  
	initial 
	begin
	#300 $finish;
   $dumpfile("mips.vcd");
	$dumpvars(0, test_mips32);
	end
    
endmodule


