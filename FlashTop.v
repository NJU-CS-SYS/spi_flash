module FlashTop(
    input clk,
    input reset, // high active
    /*
    input flash_en,
	input flash_write,
	input [23:0] flash_addr,
	output state_to_cpu,
	output flash_data_out,
    */

	input [14:0] flash_data_in,
    output [6:0] seg_out,
    output [7:0] seg_ctrl,

	inout [3:0] flash_dq,
    output flash_cs
);

reg flash_en;
reg flash_write;
reg [23:0] flash_addr;
// reg [31:0] flash_data_in;
reg [22:0] counter;

wire [11:0] state_to_cpu;
// wire [31:0] flash_data_out;

wire SI;
wire tri_si;
wire [3:0] quad_io;
wire [31:0] buffer_val;

always @ (posedge clk_50MHz) begin
    if(reset) begin
        flash_en <= 0;
        flash_write <= 0;
        flash_addr <= 0;
        // flash_data_in <= 0;
        counter <= 0;
    end
    else begin
        flash_en <= 1;
        if (flash_ready) begin
            counter <= counter + 1;
        end
        flash_addr <= {counter[21:0], 2'd0};
        if (counter[22] == 1'b0) begin
            flash_write <= 1;
        end
        if (counter[22] == 1'b1) begin
            flash_write <= 0;
        end
    end
end

clk_wiz_0 cw(
    .clk_in1(clk),
    .clk_out1(clk_50MHz)
);

SPIFlashModule SPIFlashModule(
	.clk(clk_50MHz),
	.reset(reset),
	.io_flash_en(flash_en),
	.io_flash_write(flash_write),
	.io_quad_io(quad_io),
	.io_flash_addr(flash_addr),
	.io_flash_data_in( {flash_data_in, 17'd0} ),
	.io_flash_data_out(buffer_val),
	.io_state_to_cpu(state_to_cpu),
	.io_SI(SI),
	.io_tri_si(tri_si),
	.io_cs(flash_cs),
	.io_ready(flash_ready)
);

assign flash_dq[3:0] = tri_si ? 4'bzzzz : {3'd0, SI};
assign quad_io[3:0] = tri_si ? flash_dq[3:0] : 4'bzzzz;

seg_ctrl sc(
	.clk(clk_50MHz),
	.hex1(state_to_cpu[0*4+3 : 0*4+0]),
	.hex2(state_to_cpu[1*4+3 : 1*4+0]),
    .hex3({1'b0, state_to_cpu[2*4+2 : 2*4+0]}),
	.hex4(buffer_val[3*4+3 : 3*4+0]),
	.hex5(buffer_val[4*4+3 : 4*4+0]),
	.hex6(buffer_val[5*4+3 : 5*4+0]),
	.hex7(buffer_val[6*4+3 : 6*4+0]),
	.hex8(buffer_val[7*4+3 : 7*4+0]),
	.seg_out(seg_out),
	.seg_ctrl(seg_ctrl)
);

STARTUPE2 #(
	.PROG_USR("FALSE"),  // Activate program event security feature. Requires encrypted bitstreams.
	.SIM_CCLK_FREQ(10.0)  // Set the Configuration Clock Frequency(ns) for simulation.
)
STARTUPE2_inst (
	.CFGCLK(CFGCLK),              // 1-bit output: Configuration main clock output
	.CFGMCLK(CFGMCLK),             // 1-bit output: Configuration internal oscillator clock output
	.EOS(EOS),              // 1-bit output: Active high output signal indicating the End Of Startup.
	.PREQ(PREQ),                // 1-bit output: PROGRAM request to fabric output
	.CLK(1'b0),             // 1-bit input: User start-up clock input
	.GSR(1'b0),             // 1-bit input: Global Set/Reset input (GSR cannot be used for the port name)
	.GTS(1'b0),             // 1-bit input: Global 3-state input (GTS cannot be used for the port name)
	.KEYCLEARB(1'b0),       // 1-bit input: Clear AES Decrypter Key input from Battery-Backed RAM (BBRAM)
	.PACK(1'b0),             // 1-bit input: PROGRAM acknowledge input
	.USRCCLKO(~clk_50MHz),   // 1-bit input: User CCLK input
	.USRCCLKTS(1'b0), // 1-bit input: User CCLK 3-state enable input
	.USRDONEO(1'b1),   // 1-bit input: User DONE pin output control
	.USRDONETS(1'b0)  // 1-bit input: User DONE 3-state enable output
);

endmodule
