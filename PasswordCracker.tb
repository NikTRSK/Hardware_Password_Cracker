module pc_tb;
  reg clk, rst;
  reg password_to_crack;
  reg [5:0] from;
  reg [5:0] to;
  reg [1*8:0] t;
    // Generate the clock signal
    initial
    begin
        clk = 0;
	rst = 1'b0;
	password_to_crack = 1'b0;
	from = 6'd0;
	to = 6'd35;
//	t = 35 + "a";
	t = string'(35);
	$display("%d, %d", from, to);
	$display("s: %d", t);
        forever begin
            #100;
            clk = ~clk;
        end
    end

/*  password_cracker pc (
	.clk(clk),
	.rst(rst),
	.password_to_crack(password_to_crack),
	.from(from),
	.to(to)	
  );*/
endmodule