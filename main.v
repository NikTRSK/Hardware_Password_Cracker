module password_cracker_main(clk, rst, password_to_crack, found, done);

  /* Brute force function */
  input clk;
  input rst;

  input password_to_crack;
  // input [5:0] from1;
  // input [5:0] to1;

  // input [5:0] from2;
  // input [5:0] to2;

  output found;
  output done;

  // reg [5:0] arr [3:0];
  wire [4*8:0] password_to_crack;
  wire found;
  wire done;

  // wire done1;
  // wire done2;
  // wire done3;
  // wire done4;
  // wire done5;
  // wire done6;
  // wire done7;

  password_cracker pc_execute1 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd0),
    .to(6'd3),
    .found(found),
    .done(done)	
  );

  password_cracker pc_execute2 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd4),
    .to(6'd7),
    .found(found),
    .done(done)	
  );

  password_cracker pc_execute3 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd8),
    .to(6'd11),
    .found(found),
    .done(done)	
  );

  password_cracker pc_execute4 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd12),
    .to(6'd15),
    .found(found),
    .done(done)	
  );

  password_cracker pc_execute5 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd16),
    .to(6'd19),
    .found(found),
    .done(done)	
  );

  password_cracker pc_execute6 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd20),
    .to(6'd23),
    .found(found),
    .done(done)	
  );

  password_cracker pc_execute7 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd24),
    .to(6'd27),
    .found(found),
    .done(done)	
  );

  password_cracker pc_execute8 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd28),
    .to(6'd31),
    .found(found),
    .done(done)	
  );

  password_cracker pc_execute9 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd32),
    .to(6'd35),
    .found(found),
    .done(done)	
  );

  always@(*)
  begin
    
  end

endmodule

