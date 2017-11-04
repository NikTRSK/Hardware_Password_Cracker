module pc_tb;
  reg clk, rst;
  reg [4*8:0] password_to_crack;
  reg [5:0] from;
  reg [5:0] to;
    // Generate the clock signal
    initial
    begin
        clk = 0;
	rst = 1'b0;
	password_to_crack = "0001";
	from = 6'd0;
	to = 6'd35;
	$display("%d, %d", from, to);
  $display("%s", password_to_crack);
//$display("%d", password_to_crack[7:0]);
//  $display("0: $d, 1: %d, 2: %d, 3: %d", password_to_crack[0], password_to_crack[1], password_to_crack[2], password_to_crack[3]);
        forever begin
            #100;
            clk = ~clk;
        end
    end

  password_cracker pc (
	.clk(clk),
	.rst(rst),
	.password_to_crack(password_to_crack),
	.from(from),
	.to(to)	
  );
endmodule