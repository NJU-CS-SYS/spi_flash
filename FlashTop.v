module FlashTop(
    input clk,
    input reset, // high active
    /*
    input flash_en,
	input flash_write,
	input [23:0] flash_addr,
	input [31:0] flash_data_in,
	output state_to_cpu,
	output flash_data_out,
    */
    output [6:0] seg_out,
    output [7:0] seg_ctrl,

	inout [3:0] flash_dq,
    output flash_sck,
    output flash_cs
);

reg flash_en;
reg flash_write;
reg [23:0] flash_addr;
reg [31:0] flash_data_in;
reg [15:0] counter;

wire [11:0] state_to_cpu;
wire [31:0] flash_data_out;

wire SI;
wire tri_si;
wire [3:0] quad_io;
wire [31:0] buffer_val;

always @ (posedge clk) begin
    if(reset) begin
        flash_en <= 0;
        flash_write <= 0;
        flash_addr <= 0;
        flash_data_in <= 0;
        counter <= 0;
    end
    else begin
        counter <= counter + 1;
        if (counter == 16'd0) begin
            flash_en <= 1;
            flash_write <= 1;
            flash_addr <= 24'h00eebb;
            flash_data_in <= 32'h8cef8cef;
        end
        if (counter == 16'h8000) begin
            flash_en <= 1;
            flash_write <= 0;
            flash_addr <= 24'h00eebb;
        end
    end
end

SPIFlashModule SPIFlashModule(
    .clk(clk),
    .reset(reset),
    .io_flash_en(flash_en),
    .io_flash_write(flash_write),
    .io_quad_io(quad_io),
    .io_flash_addr(flash_addr),
    .io_flash_data_in(flash_data_in),
    .io_flash_data_out(flash_data_out),
    .io_state_to_cpu(state_to_cpu),
    .io_buffer_to_cpu(buffer_val),
    .io_SI(SI),
    .io_tri_si(tri_si),
    .io_cs(cs)
);

assign flash_dq[3:0] = tri_si ? 4'bzzzz : {3'd0, SI};
assign quad_io[3:0] = tri_si ? flash_dq[3:0] : 4'bzzzz;
assign flash_sck = ~clk;

seg_ctrl sc(
    .clk(clk),
    .hex1(buffer_val[0*4+3 : 0*4+0]),
    .hex2(buffer_val[1*4+3 : 1*4+0]),
    .hex3(buffer_val[2*4+3 : 2*4+0]),
    .hex4(buffer_val[3*4+3 : 3*4+0]),
    .hex5(buffer_val[4*4+3 : 4*4+0]),
    .hex6(buffer_val[5*4+3 : 5*4+0]),
    .hex7(buffer_val[6*4+3 : 6*4+0]),
    .hex8(buffer_val[7*4+3 : 7*4+0]),
    .seg_out(seg_out),
    .seg_ctrl(seg_ctrl)
);

endmodule
