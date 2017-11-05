//``` https://github.com/secworks/sha1
/* 
  Ex on using functions: https://www.nandland.com/verilog/examples/example-function-verilog.html
                         http://www.asic-world.com/verilog/task_func1.html
                         http://rise.cse.iitm.ac.in/people/faculty/kama/prof/TasksnFunctions.pdf

  Strings:              http://www.dilloneng.com/strings-in-verilog.html#/
  Arrays:				http://www.verilogpro.com/verilog-arrays-plain-simple/
 */

module password_cracker(clk, rst, password_to_crack, from, to, found, done);

  /* Brute force function */
  input clk;
  input rst;

  input password_to_crack;
  input [5:0] from;
  input [5:0] to;

  output found;
  output done;

  reg [5:0] arr [3:0];
  reg [5:0] temp_res [3:0];
  // output reg [39:0] hashedPermutation;
  wire [4*8:0] password_to_crack;
  reg [5:0] pwd_cmp [3:0];
  reg [7:0] res;
  reg found;
  reg done;

// integer f;

always @(posedge clk, posedge rst)
  begin
// f = $fopen("output2.txt", "w");
    // found = 1'b0;
    if(rst)
    begin
        done <= 1'b0;
        pwd_cmp[0] <= password_to_crack[7:0] - 48;
        pwd_cmp[1] <= password_to_crack[15:8] - 48;
        pwd_cmp[2] <= password_to_crack[23:16] - 48;
        pwd_cmp[3] <= password_to_crack[31:24] - 48;

        arr[0] <= 6'd0;
        arr[1] <= 6'd0;
        arr[2] <= 6'd0;
        arr[3] <= from;
    end
    else
    begin
        if (arr[3] <= to && !found)
        begin
            arr[0] <= arr[0] + 1;
            if (arr[0] == 35)
            begin
                arr[0] <= 0;
                arr[1] <= arr[1] + 1;
                if (arr[1] == 35)
                begin
                    arr[1] <= 0;
                    arr[2] <= arr[2] + 1;
                    if (arr[2] == 35)
                    begin
                        arr[2] <= 0;
                        arr[3] <= arr[3] + 1;
                    end
                end
             end
            // $display("%d, %d, %,d, %d", arr[0], arr[1], arr[2], arr[3]);
            // Convert arr to char
            // Compare to input
            // Return true if found
            //$display("%d, %d, %d, %d", arr[0], arr[1], arr[2], arr[3]);
            // $fwrite(f, "f: %d t: %d | %d, %d, %d, %d | pwd: %d, %d, %d, %d\n", from, to, arr[0], arr[1], arr[2], arr[3], pwd_cmp[0], pwd_cmp[1], pwd_cmp[2], pwd_cmp[3]);
            if (arr[0] == pwd_cmp[0]
            && arr[1] == pwd_cmp[1]
            && arr[2] == pwd_cmp[2]
            && arr[3] == pwd_cmp[3])
            begin
                    found = 1'b1;
                    //$display("Found");
            end
        end
    end
    done = 1'b1;
  end
  // brute_force_in_range = 0;
  // endfunction
  /* End Brute force function */

  // Return false if not found
    // end

  // function [7:0] convertToChar;
  //   input d1, d2, d3, d4;
  //   reg [4*8:0] chars;
  //   assign chars[7:0] = "a";
  //   begin
  //     convertToChar = chars[7:0];
  //   end 
  // endfunction
  // assign res = convertToChar(temp_res[0], temp_res[1], temp_res[2], temp_res[3]);
endmodule