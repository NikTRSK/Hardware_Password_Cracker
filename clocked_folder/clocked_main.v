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
  reg found;
  reg done;

  wire done1;
  wire done2;
  wire done3;
  wire done4;
  wire done5;
  wire done6;
  wire done7;
  wire done8;
  wire done9;

  wire found1;
  wire found2;
  wire found3;
  wire found4;
  wire found5;
  wire found6;
  wire found7;
  wire found8;
  wire found9;

  //reg temp_found;
  // assign found = 1'b0;
  // initial
  // begin
  //   assign found = 1'b0;
  // end

  password_cracker pc_execute1 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd0),
    .to(6'd3),
    .found(found1),
    .done(done1)	
  );

  password_cracker pc_execute2 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd4),
    .to(6'd7),
    .found(found2),
    .done(done2)	
  );

  password_cracker pc_execute3 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd8),
    .to(6'd11),
    .found(found3),
    .done(done3)	
  );

  password_cracker pc_execute4 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd12),
    .to(6'd15),
    .found(found4),
    .done(done4)	
  );

  password_cracker pc_execute5 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd16),
    .to(6'd19),
    .found(found5),
    .done(done5)	
  );

  password_cracker pc_execute6 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd20),
    .to(6'd23),
    .found(found6),
    .done(done6)	
  );

  password_cracker pc_execute7 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd24),
    .to(6'd27),
    .found(found7),
    .done(done7)	
  );

  password_cracker pc_execute8 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd28),
    .to(6'd31),
    .found(found8),
    .done(done8)	
  );

  password_cracker pc_execute9 (
    .clk(clk),
    .rst(rst),
    .password_to_crack(password_to_crack),
    .from(6'd32),
    .to(6'd35),
    .found(found9),
    .done(done9)	
  );

  // initial
  // begin
  //   found = 1'b0;
  // end

  always@(posedge clk, posedge rst)
  begin
    if(rst)
    begin
       found <= 1'b0;
       done <= 1'b0;
       /* done1 <= 1'b0;
        done2 <= 1'b0;
        done3 <= 1'b0;
        done4 <= 1'b0;
        done5 <= 1'b0;
        done6 <= 1'b0;
        done7 <= 1'b0;
        done8 <= 1'b0;
        done9 <= 1'b0;*/
    end
    //$display("PWD in main: %s\n", password_to_crack);
    // $display("F: %d", found);
    //$display("D: %d | %d, %d, %d, %d, %d, %d, %d, %d, %d", done, done1, done2, done3, done4, done5, done6, done7, done8, done9);
$display("F: %d | %d, %d, %d, %d, %d, %d, %d, %d, %d", found, found1, found2, found3, found4, found5, found6, found7, found8, found9);
    done <= done1 && done2 && done3 && done4 && done5 && done6 && done7 && done8 && done9;
    found <= found1 || found2 || found3 || found4 || found5 || found6 || found7 || found8 || found9;
  end

endmodule

