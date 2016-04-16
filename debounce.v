module debounce(clk, noisy,clean);
input clk;
input noisy;
output clean;

reg [19:0] register;
reg clean;
always@(posedge clk)
begin
	register<={register[18:0],noisy};
	if(register==20'h00000)
		clean<=1'b0;
	else if(register<=20'hfffff)
		clean<=1'b1;
end
endmodule
