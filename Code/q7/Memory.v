module Memory (
    input clk,
    input [8:0] mem_addr,
    input [511:0] data_in,
    input write_enable,
    output reg [511:0] data_out
); //#(parameter addr_width = 9, width = 32, count = 16), localparam depth = 2**addr_width;

    // Memory array: 512 x 32 bits
    reg [31:0] memory [0:511];
    integer i;

    always @(posedge clk) begin
        if (write_enable) begin
            // Write 16 consecutive 32-bit words
            for (i = 0; i < 16; i = i + 1) begin
                memory[mem_addr + i] <= data_in[32*i +: 32];
            end
        end
    end

    // Asynchronous read
    always @(*) begin
        // Read 16 consecutive 32-bit words
        for (i = 0; i < 16; i = i + 1) begin
            data_out[32*i +: 32] = memory[mem_addr + i];
        end
    end
endmodule
