module convertToChar(clk, rst, a, b, c, d, out);
input clk;
input rst;
input arr;
output out;
input a;
input b;
input c;
input d;
reg [5:0] a;
reg [5:0] b;
reg [5:0] c;
reg [5:0] d;
reg [4*8:0] out;

reg chars [8 * 25:0];

assign chars[0] = "a";
assign chars[8] = "b";
assign chars[16] = "c";
assign chars[24] = "d";
assign chars[32] = "e";
assign chars[40] = "f";
assign chars[48] = "g";
assign chars[56] = "h";
assign chars[64] = "i";
assign chars[72] = "j";
assign chars[80] = "k";
assign chars[88] = "l";
assign chars[96] = "m";
assign chars[104] = "n";
assign chars[112] = "o";
assign chars[120] = "p";
assign chars[128] = "q";
assign chars[136] = "r";
assign chars[144] = "s";
assign chars[152] = "t";
assign chars[160] = "u";
assign chars[168] = "v";
assign chars[176] = "w";
assign chars[184] = "x";
assign chars[192] = "y";
assign chars[200] = "z";

always@(posedge clk, posedge rst)
begin
  out[7:0] <= chars[(a - 97 + 7):(a - 97)];
//  out[8] <= chars[b - 97];
//  out[16] <= chars[c - 97];
//  out[24] <= chars[d - 97];
end
endmodule