//``` https://github.com/secworks/sha1
/* 
  Ex on using functions: https://www.nandland.com/verilog/examples/example-function-verilog.html
                         http://www.asic-world.com/verilog/task_func1.html
                         http://rise.cse.iitm.ac.in/people/faculty/kama/prof/TasksnFunctions.pdf

  Strings:              http://www.dilloneng.com/strings-in-verilog.html#/
  Arrays:				http://www.verilogpro.com/verilog-arrays-plain-simple/
 */

module password_cracker(clk, rst, password_to_crack, from, to);

  /* Brute force function */
  input clk;
  input rst;

  input password_to_crack;//[4*8:0];
  input [5:0] from;
  input [5:0] to;
  //reg [5:0] from;
  reg [5:0] arr [3:0];
  //reg [5:0] to;
  reg [5:0] temp_res [3:0];
  // output reg [39:0] hashedPermutation;
  reg [7:0] res;
initial
begin
  temp_res[0] = 6'd0;
  temp_res[1] = 6'd0;
  temp_res[2] = 6'd0;
  temp_res[3] = 6'd0;
end

always @(*)
  begin
    arr[0] = 6'd0;
    arr[1] = 6'd0;
    arr[2] = 6'd0;
    arr[3] = 6'd0;
    // arr[0] <= from;
    // while (arr[0] <= to)
    while (arr[0] <= to)
    begin
      arr[3] = arr[3] + 1;
      if (arr[3] > 35)
      begin
        arr[3] = 0;
        arr[2] = arr[2] + 1;
        if (arr[2] > 35)
        begin
          arr[2] = 0;
          arr[1] = arr[1] + 1;
          if (arr[1] > 35)
          begin
            arr[1] = 0;
            arr[0] = arr[0] + 1;
          end
        end
      end
      // $display("%d, %d, %,d, %d", arr[0], arr[1], arr[2], arr[3]);
      // Convert arr to char
      // Compare to input
      // Return true if found
      temp_res[0] = arr[0];
      temp_res[1] = arr[1];
      temp_res[2] = arr[2];
      temp_res[3] = arr[3];
    end
/*    else
    begin
      temp_res[0] = arr[0];
      temp_res[1] = arr[1];
      temp_res[2] = arr[2];
      temp_res[3] = arr[3];
    end */
  end
  // brute_force_in_range = 0;
  // endfunction
  /* End Brute force function */

  // Return false if not found
// end

  function [7:0] convertToChar;
    input d1, d2, d3, d4;
    reg [4*8:0] chars;
    assign chars[7:0] = "a";
    begin
      convertToChar = chars[7:0];
    end 
  endfunction
  // assign res = convertToChar(temp_res[0], temp_res[1], temp_res[2], temp_res[3]);
endmodule