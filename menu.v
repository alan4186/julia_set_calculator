module menu (clk, rst, select, data, rC, iC, doneFlag,S);

input[15:0] data;
input clk, rst, select; 
output [31:0] rC, iC;
output doneFlag; 
output [2:0] S;
reg [31:0] rC, iC;
reg [2:0] NS, S;
reg doneFlag;

parameter 
		msbrC = 3'b000,
		Wait1 = 3'b001,
		lsbrC = 3'b010, 
		Wait2 = 3'b011, 
		msbiC = 3'b100, 
		Wait3 = 3'b101, 
		lsbiC = 3'b110, 
		done = 3'b111;

always @(posedge clk or negedge rst)
begin 

if (rst == 1'b0) 
	NS <= msbrC;
else

case(S)
			Wait1: begin
						if (select == 1'b0)
							NS <= Wait1;
						else
							NS <= lsbrC;
					end 
			Wait2: begin
						if (select == 1'b0)
							NS <= Wait2;
						else 
							NS <= msbiC;
					end		
			Wait3: begin 
						if (select == 1'b0)
							NS <= Wait3;
						else 
							NS <= lsbiC;
					end		
			msbrC: begin
						if (select == 1'b0)
							NS <= Wait1;
						else 
							NS <= msbrC;
					end
			lsbrC: begin
						if (select == 1'b0)
							NS <= Wait2;
						else 
							NS <= lsbrC;
					end
			msbiC: begin
						if (select == 1'b0)
							NS <= Wait3;
						else 
							NS <= msbiC;
					end
			lsbiC: begin
						if (select == 1'b0)
							NS <= done;
						else 
							NS <= lsbiC;
					end
			done: begin
						NS <= done;
					end
	endcase		
end

always @(posedge clk or negedge rst)
begin 
if (rst == 1'b0)
	begin
		rC <= 32'b0;
		iC <= 32'b0;
		doneFlag <= 1'b0;
	end
else 
	case(S)
			Wait1: begin 
					end 
			Wait2: begin 
					end		
			Wait3: begin 
					end		
			msbrC: begin
						rC [31:16] <= data;
					end
			lsbrC: begin
						rC [15:0] <= data;
					end
			msbiC: begin
						iC [31:16] <= data;
					end
			lsbiC: begin
						iC [15:0] <= data;
					end
			done: begin
						doneFlag <= 1'b1;
					end
	endcase		
end				
always @ (posedge clk or negedge rst)

begin 

	if (rst == 1'b0)
		S <= msbrC;
	else 
		S <= NS;
end 	

endmodule