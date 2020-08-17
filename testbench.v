
module testbench();

reg clk, reset; 
reg[31:0] D;
reg E;
wire[31:0] Q;

localparam CLK_PERIOD=20;

always @*
begin
   clk <= 1;  # (CLK_PERIOD/2);
   clk <= 0;  # (CLK_PERIOD/2);
end

Flopenr_32 myRegister(clk, reset, E, D, Q);

initial begin
reset=1;  #(CLK_PERIOD/2);  // To Falling Edge
reset=0;D=94;E=0; #(CLK_PERIOD/4); // Middle of clk=0
if (Q !== 0) begin
   $display("Error: Register changed on falling edge"); $stop;
end
#(CLK_PERIOD/2); // Middle of clk=1 
if (Q !== 0) begin
   $display("Error: Register changed when disabled"); $stop;
end
#(CLK_PERIOD/4); // To Falling Edge
E=1; #(CLK_PERIOD/4); // Middle of clk=0
if (Q !== 0) begin
   $display("Error: Register changed on falling edge"); $stop;
end
#(CLK_PERIOD/2); // Middle of clk=1 
if (Q !== D) begin
   $display("Error: Register did not change when enabled"); $stop;
end
$display("All tests passed.");
end

endmodule
