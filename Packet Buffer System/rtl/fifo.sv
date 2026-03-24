module fifo #(parameter DEPTH=8)(
    input  logic clk,
    input  logic rst,
    input  logic wr_en,
    input  logic rd_en,
    input  logic [31:0] din,
    output logic [31:0] dout,
    output logic full,
    output logic empty
);

    logic [31:0] mem[DEPTH];
    int wr_ptr, rd_ptr, count;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0; rd_ptr <= 0; count <= 0;
        end else begin
            if (wr_en && !full) begin
                mem[wr_ptr] <= din;
                wr_ptr = (wr_ptr+1)%DEPTH;
                count++;
            end

            if (rd_en && !empty) begin
                dout <= mem[rd_ptr];
                rd_ptr = (rd_ptr+1)%DEPTH;
                count--;
            end
        end
    end

    assign full  = (count==DEPTH);
    assign empty = (count==0);

endmodule