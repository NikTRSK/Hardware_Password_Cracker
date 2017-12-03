//``` https://github.com/secworks/sha1
/* 
  Ex on using functions: https://www.nandland.com/verilog/examples/example-function-verilog.html
                         http://www.asic-world.com/verilog/task_func1.html
                         http://rise.cse.iitm.ac.in/people/faculty/kama/prof/TasksnFunctions.pdf

  Strings:              http://www.dilloneng.com/strings-in-verilog.html#/
  Arrays:				http://www.verilogpro.com/verilog-arrays-plain-simple/
 */

// `timescale 1ns/10ps

module password_cracker(clk, rst, password_to_crack, from, to, found, done);

  /* Brute force function */
  input clk;
  input rst;

  input [4*8:0] password_to_crack;
  input [5:0] from;
  input [5:0] to;

  output found;
  output done;

  reg [5:0] arr [3:0];
  reg [5:0] temp_res [3:0];
  // output reg [39:0] hashedPermutation;
  //reg [4*8:0] password_to_crack;
  reg [5:0] pwd_cmp [3:0];
  reg [7:0] res;
  reg found;
  reg done;

  reg [511 : 0] converted_try;

//   sha1_main sha1(
//       .input_pwd(converted_try)
//   );

always @(posedge clk, posedge rst)
  begin
// f = $fopen("output2.txt", "w");
    // found = 1'b0;
    if(rst)
    begin
        done <= 1'b0;
	    found <= 1'b0;
        pwd_cmp[3] <= password_to_crack[7:0] - 48;
        pwd_cmp[2] <= password_to_crack[15:8] - 48;
        pwd_cmp[1] <= password_to_crack[23:16] - 48;
        pwd_cmp[0] <= password_to_crack[31:24] - 48;

        arr[3] <= 6'd0;
        arr[1] <= 6'd0;
        arr[2] <= 6'd0;
        arr[0] <= from;

        converted_try <= 512'h00000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018;
    end
    else
    begin
        if (arr[0] <= to && !found)
        begin
            // arr[3] <= arr[3] + 1;
            // if (arr[3] == 35)
            // begin
                // arr[3] <= 0;
                arr[2] <= arr[2] + 1;
                if (arr[2] == 35)
                begin
                    arr[2] <= 0;
                    arr[1] <= arr[1] + 1;
                    if (arr[1] == 35)
                    begin
                        arr[1] <= 0;
                        arr[0] <= arr[0] + 1;
                    end
                // end
             end
            // $display("%d, %d, %,d, %d", arr[0], arr[1], arr[2], arr[3]);
            // Convert arr to char
            // Compare to input
            // Return true if found
            //$display("Arr: %d, %d, %d, %d", arr[0], arr[1], arr[2], arr[3]);
	    //$display("pw: %d, %d, %d, %d", pwd_cmp[0], pwd_cmp[1], pwd_cmp[2], pwd_cmp[3]);
    //$display("PWD in block: %s\n", password_to_crack);
            // $fwrite(f, "f: %d t: %d | %d, %d, %d, %d | pwd: %d, %d, %d, %d\n", from, to, arr[0], arr[1], arr[2], arr[3], pwd_cmp[0], pwd_cmp[1], pwd_cmp[2], pwd_cmp[3]);
            
            converted_try[511 : 504] = arr[0];
            converted_try[503 : 496] = arr[1];
            converted_try[495 : 488] = arr[2];
            // converted_try[487 : 480] = arr[3];

            $display("array: 0: %d, 1: %d, 2: %d, 3: %d", arr[0], arr[1], arr[2], arr[3]);
            $display("CONVERTED: %h", converted_try);

            // Change this function to check agains hashed password
            if (arr[0] == pwd_cmp[0]
            && arr[1] == pwd_cmp[1]
            && arr[2] == pwd_cmp[2]
            && arr[3] == pwd_cmp[3])
            begin
                    found <= 1'b1;
                    $display("Found");
            end
        end
	else
	begin
		    done <= 1'b1;
	end
    end
//    done = 1'b1;
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
    sha1_main sha1(
      .input_pwd(converted_try)
  );
endmodule