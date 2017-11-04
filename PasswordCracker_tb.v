module pc_tb;
  reg clk, rst;
  reg [4*8:0] password_to_crack;
  reg [5:0] from;
  reg [5:0] to;
  wire found;
  wire done;

    // Generate the clock signal
    initial
    begin
        clk = 0;
	rst = 1'b0;
	password_to_crack = "ABCD";
	from = 6'd0;
	to = 6'd35;
	//found = 0;
	//$display("%d, %d, $s", from, to, password_to_crack);
        forever begin
            #100;
            clk = ~clk;
        end
    end

    always@(posedge clk)
    begin
     if (found)
	$display("We found: %s", password_to_crack);
     else if(done)
        $display("Password couldn't be cracked!");
    end

  password_cracker pc (
	.clk(clk),
	.rst(rst),
	.password_to_crack(password_to_crack),
	.from(from),
	.to(to),
	.found(found),
	.done(done)	
  );
endmodule