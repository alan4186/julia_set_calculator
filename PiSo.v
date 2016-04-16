module PiSo (clk, rst, shift,Data_in, out);
input clk, rst;
input shift;
input [15:0] Data_in;

output out;

reg out;
reg [15:0] shiftreg;

always@(posedge clk or negedge rst)
begin 
	if(rst ==1'b0)
		begin
			shiftreg<=16'd0;
		end
	else
		if (shift==1'b0)
			begin
				shiftreg<=Data_in;
			end
		else 
			begin
			out<=shiftreg[0];
			shiftreg<={1'b0, shiftreg[15:1]};
			end
			
end

endmodule
