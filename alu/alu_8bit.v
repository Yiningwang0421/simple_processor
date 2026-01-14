module alu_8bit (
input  a[7:0],
input  b[7:0],
input alu_op[2:0],
output reg b [7:0],
output reg z
);
typedef enum [2:0]{
ADD,
SUB,
AND,
OR,
}opcode;

always @(*) begin
    case (alu_op)
        3'b000:


end


endmodule
