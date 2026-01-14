// regfile_8x8.sv
// 8 registers x 8-bit
// - 2 combinational read ports
// - 1 synchronous write port (posedge clk)
// - async active-low reset clears all registers
// - No bypass: read-during-write may return old/undefined within same cycle; stable after clock edge.

module regfile_8x8 (
    input  logic       clk,
    input  logic       rst_n,

    input  logic [2:0] ra,
    input  logic [2:0] rb,

    input  logic       we,
    input  logic [2:0] wa,
    input  logic [7:0] wd,

    output logic [7:0] rd_a,
    output logic [7:0] rd_b
);

    logic [7:0] R [0:7];

    always_comb begin
        rd_a = R[ra];
        rd_b = R[rb];
    end

    integer i;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 8; i = i + 1) begin
                R[i] <= 8'h00;
            end
        end else begin
            if (we) begin
                R[wa] <= wd;
            end
        end
    end

endmodule
