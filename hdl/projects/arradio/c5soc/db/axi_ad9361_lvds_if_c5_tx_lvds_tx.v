//altlvds_tx CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" COMMON_RX_TX_PLL="ON" CORECLOCK_DIVIDE_BY=1 DATA_RATE="500.0 Mbps" DESERIALIZATION_FACTOR=4 DEVICE_FAMILY="Cyclone V" DIFFERENTIAL_DRIVE=0 ENABLE_CLK_LATENCY="OFF" IMPLEMENT_IN_LES="OFF" INCLOCK_BOOST=0 INCLOCK_DATA_ALIGNMENT="EDGE_ALIGNED" INCLOCK_PERIOD=4000 INCLOCK_PHASE_SHIFT=0 MULTI_CLOCK="OFF" NUMBER_OF_CHANNELS=7 OUTCLOCK_ALIGNMENT="EDGE_ALIGNED" OUTCLOCK_DIVIDE_BY=2 OUTCLOCK_DUTY_CYCLE=50 OUTCLOCK_MULTIPLY_BY=1 OUTCLOCK_PHASE_SHIFT=0 OUTCLOCK_RESOURCE="Global Clock" OUTPUT_DATA_RATE=500 PLL_COMPENSATION_MODE="AUTO" PLL_SELF_RESET_ON_LOSS_LOCK="OFF" PREEMPHASIS_SETTING=0 REFCLK_FREQUENCY="250.000000 MHz" REGISTERED_INPUT="TX_CORECLK" USE_EXTERNAL_PLL="OFF" USE_NO_PHASE_SHIFT="ON" VOD_SETTING=0 pll_areset tx_coreclock tx_in tx_inclock tx_locked tx_out tx_outclock CARRY_CHAIN="MANUAL" CARRY_CHAIN_LENGTH=48
//VERSION_BEGIN 21.1 cbx_altaccumulate 2021:10:21:11:02:24:SJ cbx_altclkbuf 2021:10:21:11:02:24:SJ cbx_altddio_in 2021:10:21:11:02:24:SJ cbx_altddio_out 2021:10:21:11:02:24:SJ cbx_altera_syncram_nd_impl 2021:10:21:11:02:24:SJ cbx_altiobuf_bidir 2021:10:21:11:02:24:SJ cbx_altiobuf_in 2021:10:21:11:02:24:SJ cbx_altiobuf_out 2021:10:21:11:02:24:SJ cbx_altlvds_tx 2021:10:21:11:02:24:SJ cbx_altpll 2021:10:21:11:02:24:SJ cbx_altsyncram 2021:10:21:11:02:24:SJ cbx_arriav 2021:10:21:11:02:24:SJ cbx_cyclone 2021:10:21:11:02:24:SJ cbx_cycloneii 2021:10:21:11:02:24:SJ cbx_lpm_add_sub 2021:10:21:11:02:24:SJ cbx_lpm_compare 2021:10:21:11:02:24:SJ cbx_lpm_counter 2021:10:21:11:02:24:SJ cbx_lpm_decode 2021:10:21:11:02:24:SJ cbx_lpm_mux 2021:10:21:11:02:24:SJ cbx_lpm_shiftreg 2021:10:21:11:02:24:SJ cbx_maxii 2021:10:21:11:02:24:SJ cbx_mgl 2021:10:21:11:11:47:SJ cbx_nadder 2021:10:21:11:02:24:SJ cbx_stratix 2021:10:21:11:02:24:SJ cbx_stratixii 2021:10:21:11:02:24:SJ cbx_stratixiii 2021:10:21:11:02:24:SJ cbx_stratixv 2021:10:21:11:02:24:SJ cbx_util_mgl 2021:10:21:11:02:24:SJ  VERSION_END
//CBXI_INSTANCE_NAME="system_top_system_bd_i_system_bd_axi_ad9361_axi_ad9361_axi_ad9361_lvds_if_i_dev_if_axi_ad9361_lvds_if_c5_i_axi_ad9361_lvds_if_c5_altlvds_tx_i_altlvds_tx"
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2021  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and any partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details, at
//  https://fpgasoftware.intel.com/eula.




//altclkctrl CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" CLOCK_TYPE="Global Clock" DEVICE_FAMILY="Cyclone V" inclk outclk
//VERSION_BEGIN 21.1 cbx_altclkbuf 2021:10:21:11:02:24:SJ cbx_cycloneii 2021:10:21:11:02:24:SJ cbx_lpm_add_sub 2021:10:21:11:02:24:SJ cbx_lpm_compare 2021:10:21:11:02:24:SJ cbx_lpm_decode 2021:10:21:11:02:24:SJ cbx_lpm_mux 2021:10:21:11:02:24:SJ cbx_mgl 2021:10:21:11:11:47:SJ cbx_nadder 2021:10:21:11:02:24:SJ cbx_stratix 2021:10:21:11:02:24:SJ cbx_stratixii 2021:10:21:11:02:24:SJ cbx_stratixiii 2021:10:21:11:02:24:SJ cbx_stratixv 2021:10:21:11:02:24:SJ  VERSION_END

//synthesis_resources = cyclonev_clkena 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  axi_ad9361_lvds_if_c5_tx_altclkctrl
	( 
	inclk,
	outclk) /* synthesis synthesis_clearbox=1 */;
	input   [3:0]  inclk;
	output   outclk;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   [3:0]  inclk;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  wire_sd10_outclk;
	wire [1:0]  clkselect;
	wire ena;

	cyclonev_clkena   sd10
	( 
	.ena(ena),
	.enaout(),
	.inclk(inclk[0]),
	.outclk(wire_sd10_outclk));
	defparam
		sd10.clock_type = "Global Clock",
		sd10.ena_register_mode = "always enabled",
		sd10.lpm_type = "cyclonev_clkena";
	assign
		clkselect = {2{1'b0}},
		ena = 1'b1,
		outclk = wire_sd10_outclk;
endmodule //axi_ad9361_lvds_if_c5_tx_altclkctrl

//synthesis_resources = cyclonev_clkena 1 cyclonev_ir_fifo_userdes 8 generic_pll 3 reg 28 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
(* ALTERA_ATTRIBUTE = {"{-to pll_fclk} PLL_COMPENSATION_MODE=LVDS;-name MULTICYCLE 3 -from txreg* -to lvds_tx_fifo*;-name MULTICYCLE_HOLD 4 -from txreg* -to lvds_tx_fifo*"} *)
module  axi_ad9361_lvds_if_c5_tx_lvds_tx
	( 
	pll_areset,
	tx_coreclock,
	tx_in,
	tx_inclock,
	tx_locked,
	tx_out,
	tx_outclock) /* synthesis synthesis_clearbox=1 */;
	input   pll_areset;
	output   tx_coreclock;
	input   [27:0]  tx_in;
	input   tx_inclock;
	output   tx_locked;
	output   [6:0]  tx_out;
	output   tx_outclock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   pll_areset;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  wire_coreclk_buf_outclk;
	wire  wire_lvds_outclk_tx_serialiser_txout;
	wire  wire_sd1_txout;
	wire  wire_sd2_txout;
	wire  wire_sd3_txout;
	wire  wire_sd4_txout;
	wire  wire_sd5_txout;
	wire  wire_sd6_txout;
	wire  wire_sd7_txout;
	(* ALTERA_ATTRIBUTE = {"PRESERVE_REGISTER=ON"} *)
	reg	[27:0]	txreg;
	wire  wire_pll_ena_outclk;
	wire  wire_pll_fclk_fboutclk;
	wire  wire_pll_fclk_locked;
	wire  wire_pll_fclk_outclk;
	wire  wire_pll_sclk_outclk;

	axi_ad9361_lvds_if_c5_tx_altclkctrl   coreclk_buf
	( 
	.inclk({{3{1'b0}}, wire_pll_sclk_outclk}),
	.outclk(wire_coreclk_buf_outclk));
	cyclonev_ir_fifo_userdes   lvds_outclk_tx_serialiser
	( 
	.bslipmax(),
	.bslipout(),
	.dout(),
	.loaden(wire_pll_ena_outclk),
	.lvdsmodeen(),
	.lvdstxsel(),
	.rstn(pll_areset),
	.rxout(),
	.scanout(),
	.txin(10'b0000001010),
	.txout(wire_lvds_outclk_tx_serialiser_txout),
	.writeclk(wire_pll_fclk_outclk)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.bslipctl(1'b0),
	.bslipin(1'b0),
	.dinfiforx({2{1'b0}}),
	.dynfifomode({3{1'b0}}),
	.readclk(1'b0),
	.readenable(1'b0),
	.regscan(1'b0),
	.regscanovrd(1'b0),
	.scanin(1'b0),
	.tstclk(1'b0),
	.writeenable(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.observablefout1(),
	.observablefout2(),
	.observablefout3(),
	.observablefout4(),
	.observableout(),
	.observablewaddrcnt()
	// synopsys translate_on
	);
	defparam
		lvds_outclk_tx_serialiser.a_rb_bypass_serializer = "false",
		lvds_outclk_tx_serialiser.a_rb_data_width = 4,
		lvds_outclk_tx_serialiser.a_rb_fifo_mode = "serializer_mode",
		lvds_outclk_tx_serialiser.a_rb_tx_outclk = "true",
		lvds_outclk_tx_serialiser.lpm_type = "cyclonev_ir_fifo_userdes";
	cyclonev_ir_fifo_userdes   sd1
	( 
	.bslipmax(),
	.bslipout(),
	.dout(),
	.loaden(wire_pll_ena_outclk),
	.lvdsmodeen(),
	.lvdstxsel(),
	.rstn(pll_areset),
	.rxout(),
	.scanout(),
	.txin({{6{1'b0}}, txreg[3:0]}),
	.txout(wire_sd1_txout),
	.writeclk(wire_pll_fclk_outclk)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.bslipctl(1'b0),
	.bslipin(1'b0),
	.dinfiforx({2{1'b0}}),
	.dynfifomode({3{1'b0}}),
	.readclk(1'b0),
	.readenable(1'b0),
	.regscan(1'b0),
	.regscanovrd(1'b0),
	.scanin(1'b0),
	.tstclk(1'b0),
	.writeenable(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.observablefout1(),
	.observablefout2(),
	.observablefout3(),
	.observablefout4(),
	.observableout(),
	.observablewaddrcnt()
	// synopsys translate_on
	);
	defparam
		sd1.a_rb_data_width = 4,
		sd1.a_rb_fifo_mode = "serializer_mode",
		sd1.lpm_type = "cyclonev_ir_fifo_userdes";
	cyclonev_ir_fifo_userdes   sd2
	( 
	.bslipmax(),
	.bslipout(),
	.dout(),
	.loaden(wire_pll_ena_outclk),
	.lvdsmodeen(),
	.lvdstxsel(),
	.rstn(pll_areset),
	.rxout(),
	.scanout(),
	.txin({{6{1'b0}}, txreg[7:4]}),
	.txout(wire_sd2_txout),
	.writeclk(wire_pll_fclk_outclk)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.bslipctl(1'b0),
	.bslipin(1'b0),
	.dinfiforx({2{1'b0}}),
	.dynfifomode({3{1'b0}}),
	.readclk(1'b0),
	.readenable(1'b0),
	.regscan(1'b0),
	.regscanovrd(1'b0),
	.scanin(1'b0),
	.tstclk(1'b0),
	.writeenable(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.observablefout1(),
	.observablefout2(),
	.observablefout3(),
	.observablefout4(),
	.observableout(),
	.observablewaddrcnt()
	// synopsys translate_on
	);
	defparam
		sd2.a_rb_data_width = 4,
		sd2.a_rb_fifo_mode = "serializer_mode",
		sd2.lpm_type = "cyclonev_ir_fifo_userdes";
	cyclonev_ir_fifo_userdes   sd3
	( 
	.bslipmax(),
	.bslipout(),
	.dout(),
	.loaden(wire_pll_ena_outclk),
	.lvdsmodeen(),
	.lvdstxsel(),
	.rstn(pll_areset),
	.rxout(),
	.scanout(),
	.txin({{6{1'b0}}, txreg[11:8]}),
	.txout(wire_sd3_txout),
	.writeclk(wire_pll_fclk_outclk)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.bslipctl(1'b0),
	.bslipin(1'b0),
	.dinfiforx({2{1'b0}}),
	.dynfifomode({3{1'b0}}),
	.readclk(1'b0),
	.readenable(1'b0),
	.regscan(1'b0),
	.regscanovrd(1'b0),
	.scanin(1'b0),
	.tstclk(1'b0),
	.writeenable(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.observablefout1(),
	.observablefout2(),
	.observablefout3(),
	.observablefout4(),
	.observableout(),
	.observablewaddrcnt()
	// synopsys translate_on
	);
	defparam
		sd3.a_rb_data_width = 4,
		sd3.a_rb_fifo_mode = "serializer_mode",
		sd3.lpm_type = "cyclonev_ir_fifo_userdes";
	cyclonev_ir_fifo_userdes   sd4
	( 
	.bslipmax(),
	.bslipout(),
	.dout(),
	.loaden(wire_pll_ena_outclk),
	.lvdsmodeen(),
	.lvdstxsel(),
	.rstn(pll_areset),
	.rxout(),
	.scanout(),
	.txin({{6{1'b0}}, txreg[15:12]}),
	.txout(wire_sd4_txout),
	.writeclk(wire_pll_fclk_outclk)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.bslipctl(1'b0),
	.bslipin(1'b0),
	.dinfiforx({2{1'b0}}),
	.dynfifomode({3{1'b0}}),
	.readclk(1'b0),
	.readenable(1'b0),
	.regscan(1'b0),
	.regscanovrd(1'b0),
	.scanin(1'b0),
	.tstclk(1'b0),
	.writeenable(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.observablefout1(),
	.observablefout2(),
	.observablefout3(),
	.observablefout4(),
	.observableout(),
	.observablewaddrcnt()
	// synopsys translate_on
	);
	defparam
		sd4.a_rb_data_width = 4,
		sd4.a_rb_fifo_mode = "serializer_mode",
		sd4.lpm_type = "cyclonev_ir_fifo_userdes";
	cyclonev_ir_fifo_userdes   sd5
	( 
	.bslipmax(),
	.bslipout(),
	.dout(),
	.loaden(wire_pll_ena_outclk),
	.lvdsmodeen(),
	.lvdstxsel(),
	.rstn(pll_areset),
	.rxout(),
	.scanout(),
	.txin({{6{1'b0}}, txreg[19:16]}),
	.txout(wire_sd5_txout),
	.writeclk(wire_pll_fclk_outclk)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.bslipctl(1'b0),
	.bslipin(1'b0),
	.dinfiforx({2{1'b0}}),
	.dynfifomode({3{1'b0}}),
	.readclk(1'b0),
	.readenable(1'b0),
	.regscan(1'b0),
	.regscanovrd(1'b0),
	.scanin(1'b0),
	.tstclk(1'b0),
	.writeenable(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.observablefout1(),
	.observablefout2(),
	.observablefout3(),
	.observablefout4(),
	.observableout(),
	.observablewaddrcnt()
	// synopsys translate_on
	);
	defparam
		sd5.a_rb_data_width = 4,
		sd5.a_rb_fifo_mode = "serializer_mode",
		sd5.lpm_type = "cyclonev_ir_fifo_userdes";
	cyclonev_ir_fifo_userdes   sd6
	( 
	.bslipmax(),
	.bslipout(),
	.dout(),
	.loaden(wire_pll_ena_outclk),
	.lvdsmodeen(),
	.lvdstxsel(),
	.rstn(pll_areset),
	.rxout(),
	.scanout(),
	.txin({{6{1'b0}}, txreg[23:20]}),
	.txout(wire_sd6_txout),
	.writeclk(wire_pll_fclk_outclk)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.bslipctl(1'b0),
	.bslipin(1'b0),
	.dinfiforx({2{1'b0}}),
	.dynfifomode({3{1'b0}}),
	.readclk(1'b0),
	.readenable(1'b0),
	.regscan(1'b0),
	.regscanovrd(1'b0),
	.scanin(1'b0),
	.tstclk(1'b0),
	.writeenable(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.observablefout1(),
	.observablefout2(),
	.observablefout3(),
	.observablefout4(),
	.observableout(),
	.observablewaddrcnt()
	// synopsys translate_on
	);
	defparam
		sd6.a_rb_data_width = 4,
		sd6.a_rb_fifo_mode = "serializer_mode",
		sd6.lpm_type = "cyclonev_ir_fifo_userdes";
	cyclonev_ir_fifo_userdes   sd7
	( 
	.bslipmax(),
	.bslipout(),
	.dout(),
	.loaden(wire_pll_ena_outclk),
	.lvdsmodeen(),
	.lvdstxsel(),
	.rstn(pll_areset),
	.rxout(),
	.scanout(),
	.txin({{6{1'b0}}, txreg[27:24]}),
	.txout(wire_sd7_txout),
	.writeclk(wire_pll_fclk_outclk)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.bslipctl(1'b0),
	.bslipin(1'b0),
	.dinfiforx({2{1'b0}}),
	.dynfifomode({3{1'b0}}),
	.readclk(1'b0),
	.readenable(1'b0),
	.regscan(1'b0),
	.regscanovrd(1'b0),
	.scanin(1'b0),
	.tstclk(1'b0),
	.writeenable(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.observablefout1(),
	.observablefout2(),
	.observablefout3(),
	.observablefout4(),
	.observableout(),
	.observablewaddrcnt()
	// synopsys translate_on
	);
	defparam
		sd7.a_rb_data_width = 4,
		sd7.a_rb_fifo_mode = "serializer_mode",
		sd7.lpm_type = "cyclonev_ir_fifo_userdes";
	// synopsys translate_off
	initial
		txreg = 0;
	// synopsys translate_on
	always @ ( posedge wire_coreclk_buf_outclk)
		  txreg <= tx_in;
	generic_pll   pll_ena
	( 
	.fbclk(wire_pll_fclk_fboutclk),
	.fboutclk(),
	.locked(),
	.outclk(wire_pll_ena_outclk),
	.refclk(tx_inclock),
	.rst(pll_areset));
	defparam
		pll_ena.duty_cycle = 25,
		pll_ena.output_clock_frequency = "125.000000 MHz",
		pll_ena.phase_shift = "4000 ps",
		pll_ena.reference_clock_frequency = "250.000000 MHz",
		pll_ena.lpm_type = "generic_pll";
	generic_pll   pll_fclk
	( 
	.fbclk(wire_pll_fclk_fboutclk),
	.fboutclk(wire_pll_fclk_fboutclk),
	.locked(wire_pll_fclk_locked),
	.outclk(wire_pll_fclk_outclk),
	.refclk(tx_inclock),
	.rst(pll_areset));
	defparam
		pll_fclk.output_clock_frequency = "500.000000 MHz",
		pll_fclk.phase_shift = "1000 ps",
		pll_fclk.reference_clock_frequency = "250.000000 MHz",
		pll_fclk.lpm_type = "generic_pll";
	generic_pll   pll_sclk
	( 
	.fbclk(wire_pll_fclk_fboutclk),
	.fboutclk(),
	.locked(),
	.outclk(wire_pll_sclk_outclk),
	.refclk(tx_inclock),
	.rst(pll_areset));
	defparam
		pll_sclk.output_clock_frequency = "125.000000 MHz",
		pll_sclk.phase_shift = "7000 ps",
		pll_sclk.reference_clock_frequency = "250.000000 MHz",
		pll_sclk.lpm_type = "generic_pll";
	assign
		tx_coreclock = wire_coreclk_buf_outclk,
		tx_locked = wire_pll_fclk_locked,
		tx_out = {wire_sd7_txout, wire_sd6_txout, wire_sd5_txout, wire_sd4_txout, wire_sd3_txout, wire_sd2_txout, wire_sd1_txout},
		tx_outclock = wire_lvds_outclk_tx_serialiser_txout;
endmodule //axi_ad9361_lvds_if_c5_tx_lvds_tx
//VALID FILE
