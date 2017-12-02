// module pc_tb;
//   reg clk, rst;
//   reg [4*8:0] password_to_crack;
//   reg [5:0] from;
//   reg [5:0] to;
//   wire found;
//   wire done;

//     // Generate the clock signal
//     initial
//     begin
//         clk = 0;
// 	rst = 1'b0;
// 	password_to_crack = "ABCD";
// 	from = 6'd0;
// 	to = 6'd35;
// 	//found = 0;
// 	//$display("%d, %d, $s", from, to, password_to_crack);
//         forever begin
//             #100;
//             clk = ~clk;
//         end
//     end

//     always@(posedge clk)
//     begin
//      if (found)
// 	$display("We found: %s", password_to_crack);
//      else if(done)
//         $display("Password couldn't be cracked!");
//     end

//   password_cracker pc (
// 	.clk(clk),
// 	.rst(rst),
// 	.password_to_crack(password_to_crack),
// 	.from(from),
// 	.to(to),
// 	.found(found),
// 	.done(done)	
//   );
// endmodule

module pc_tb;
  reg clk, rst;
  reg [4*8:0] password_to_crack;
  // reg [5:0] from;
  // reg [5:0] to;
  wire found;
  wire done;
  reg [20:0] overall_clocks;
    // Generate the clock signal
  initial
  begin
    overall_clocks <= 0;
	  password_to_crack = "gggg";
    clk = 0;
	  rst = 1'b0;
	  #100
	  rst = 1'b1;
	  #100
	  rst = 1'b0;
	  // from = 6'd0;
	  // to = 6'd35;
	  //found = 0;
	  //$display("%d, %d, $s", from, to, password_to_crack);
    $display("PWD in TB: %s", password_to_crack);
	  forever begin
      #100;
      clk = ~clk;
    end
  end

  always@(posedge clk)
    begin
      overall_clocks <= overall_clocks + 1;
      if (found)
      begin
      $display("The cracker has found it's result: %d\nStatistics:\nNumber of processing elements: 9\nClocks to generate result:%d", password_to_crack, overall_clocks);
      $stop;
    end
    else if(done && !found)
      $display("Password couldn't be cracked!");
      $stop;
    end

  password_cracker_main pc (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    // .from(from),
    // .to(to),
    .found(found),
    .done(done)
  );
endmodule

	// 	BruteForceInRange(mPasswordsToBruteForce, 0, 3);
	// 	BruteForceInRange(mPasswordsToBruteForce, 4, 7);
	// 	BruteForceInRange(mPasswordsToBruteForce, 8, 11);
	// 	BruteForceInRange(mPasswordsToBruteForce, 12, 15);
	// 	BruteForceInRange(mPasswordsToBruteForce, 16, 19);
	// 	BruteForceInRange(mPasswordsToBruteForce, 20, 23);
	// 	BruteForceInRange(mPasswordsToBruteForce, 24, 27);
	// 	BruteForceInRange(mPasswordsToBruteForce, 28, 31);
	// 	BruteForceInRange(mPasswordsToBruteForce, 32, 35);