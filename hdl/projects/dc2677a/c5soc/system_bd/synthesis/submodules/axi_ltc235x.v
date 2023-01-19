// ***************************************************************************
// ***************************************************************************
// Copyright 2014 - 2017 (c) Analog Devices, Inc. All rights reserved.
//
// In this HDL repository, there are many different and unique modules, consisting
// of various HDL (Verilog or VHDL) components. The individual modules are
// developed independently, and may be accompanied by separate and unique license
// terms.
//
// The user should read each of these license terms, and understand the
// freedoms and responsibilities that he or she has by using this source/core.
//
// This core is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
// A PARTICULAR PURPOSE.
//
// Redistribution and use of source or resulting binaries, with or without modification
// of this file, are permitted under one of the following two license terms:
//
//   1. The GNU General Public License version 2 as published by the
//      Free Software Foundation, which can be found in the top level directory
//      of this repository (LICENSE_GPL2), and also online at:
//      <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
//
// OR
//
//   2. An ADI specific BSD license, which can be found in the top level directory
//      of this repository (LICENSE_ADIBSD), and also on-line at:
//      https://github.com/analogdevicesinc/hdl/blob/master/LICENSE_ADIBSD
//      This will allow to generate bit files and not release the source code,
//      as long as it attaches to an ADI device.
//
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module axi_ltc235x #(

  parameter       ID = 0,
  parameter       FPGA_TECHNOLOGY = 0,
  parameter       FPGA_FAMILY = 0,
  parameter       SPEED_GRADE = 0,
  parameter       DEV_PACKAGE = 0,
  parameter       LVDS_CMOS_N = 0,
  parameter       LANE_0_ENABLE = "true",
  parameter       LANE_1_ENABLE = "true",
  parameter       LANE_2_ENABLE = "true",
  parameter       LANE_3_ENABLE = "true",
  parameter       LANE_4_ENABLE = "true",
  parameter       LANE_5_ENABLE = "true",
  parameter       LANE_6_ENABLE = "true",
  parameter       LANE_7_ENABLE = "true",
  parameter       NUM_CHANNELS = 8,	// 8 for 2358, 4 for 2357, 2 for 2353
  parameter       DATA_WIDTH = 18,	// 18 or 16
  parameter       SOFTSPAN_NEXT = 24'hff_ffff, // TODO: internal register for this
  parameter       EXTERNAL_CLK = 0
) (

  // physical data interface

  input                   external_clk,

  // common
  input                   busy,
  output                  lvds_cmos_n,
  output                  cs_n,
  output                  pd,

  // cmos
  output                  scki,
  input                   scko,
  output                  sdi,
  input                   sdo_0,
  input                   sdo_1,
  input                   sdo_2,
  input                   sdo_3,
  input                   sdo_4,
  input                   sdo_5,
  input                   sdo_6,
  input                   sdo_7,
  
  // lvds
  output                  scki_p,
  output                  scki_n,
  input                   scko_p,
  input                   scko_n,
  output                  sdi_p,
  output                  sdi_n,
  input                   sdo_p,
  input                   sdo_n,

  // AXI Slave Memory Map

  input                   s_axi_aclk,
  input                   s_axi_aresetn,
  input                   s_axi_awvalid,
  input       [15:0]      s_axi_awaddr,
  input       [ 2:0]      s_axi_awprot,
  output                  s_axi_awready,
  input                   s_axi_wvalid,
  input       [31:0]      s_axi_wdata,
  input       [ 3:0]      s_axi_wstrb,
  output                  s_axi_wready,
  output                  s_axi_bvalid,
  output      [ 1:0]      s_axi_bresp,
  input                   s_axi_bready,
  input                   s_axi_arvalid,
  input       [15:0]      s_axi_araddr,
  input       [ 2:0]      s_axi_arprot,
  output                  s_axi_arready,
  output                  s_axi_rvalid,
  output      [ 1:0]      s_axi_rresp,
  output      [31:0]      s_axi_rdata,
  input                   s_axi_rready,

  // Write FIFO interface

  input                   adc_dovf,
  output                  adc_valid_0,
  output                  adc_valid_1,
  output                  adc_valid_2,
  output                  adc_valid_3,
  output                  adc_valid_4,
  output                  adc_valid_5,
  output                  adc_valid_6,
  output                  adc_valid_7,
  output                  adc_enable_0,
  output                  adc_enable_1,
  output                  adc_enable_2,
  output                  adc_enable_3,
  output                  adc_enable_4,
  output                  adc_enable_5,
  output                  adc_enable_6,
  output                  adc_enable_7,
  output      [31:0]      adc_data_0,
  output      [31:0]      adc_data_1,
  output      [31:0]      adc_data_2,
  output      [31:0]      adc_data_3,
  output      [31:0]      adc_data_4,
  output      [31:0]      adc_data_5,
  output      [31:0]      adc_data_6,
  output      [31:0]      adc_data_7
);

  // localparam

  localparam  [ 7:0]     ACTIVE_LANES = {
                         LANE_7_ENABLE == 1 ? 1'b1 : 1'b0,
                         LANE_6_ENABLE == 1 ? 1'b1 : 1'b0,
                         LANE_5_ENABLE == 1 ? 1'b1 : 1'b0,
                         LANE_4_ENABLE == 1 ? 1'b1 : 1'b0,
                         LANE_3_ENABLE == 1 ? 1'b1 : 1'b0,
                         LANE_2_ENABLE == 1 ? 1'b1 : 1'b0,
                         LANE_1_ENABLE == 1 ? 1'b1 : 1'b0,
                         LANE_0_ENABLE == 1 ? 1'b1 : 1'b0};

  // internal registers

  reg                     up_wack = 1'b0;
  reg                     up_rack = 1'b0;
  reg     [31:0]          up_rdata = 32'b0;

  // internal signals

  wire                    adc_valid;

  wire                    up_clk;
  wire                    up_rstn;
  wire                    up_rreq_s;
  wire    [13:0]          up_raddr_s;
  wire                    up_wreq_s;
  wire    [13:0]          up_waddr_s;

  wire                    adc_clk_s;

  wire    [13:0]          up_addr_s;
  wire    [31:0]          up_wdata_s;
  wire    [31:0]          up_rdata_s[0:8];
  wire    [ 8:0]          up_rack_s;
  wire    [ 8:0]          up_wack_s;

  // read raw, feature
  wire                    rd_req_s;
  wire                    wr_req_s;
  wire    [15:0]          wr_data_s;
  wire    [15:0]          rd_data_s;
  wire                    rd_valid_s;

  wire                    adc_rst_s;

  wire    [ 7:0]          adc_enable;
  wire    [ 2:0]          adc_status_header[0:7];

  // defaults

  assign up_clk = s_axi_aclk;
  assign up_rstn = s_axi_aresetn;

  assign lvds_cmos_n = LVDS_CMOS_N[0];
  assign cs_n = 'b0;
  assign pd = 'b0;

  assign adc_valid_0 = adc_valid;
  assign adc_valid_1 = adc_valid;
  assign adc_valid_2 = adc_valid;
  assign adc_valid_3 = adc_valid;
  assign adc_valid_4 = adc_valid;
  assign adc_valid_5 = adc_valid;
  assign adc_valid_6 = adc_valid;
  assign adc_valid_7 = adc_valid;

  assign adc_enable_0 = adc_enable[0];
  assign adc_enable_1 = adc_enable[1];
  assign adc_enable_2 = adc_enable[2];
  assign adc_enable_3 = adc_enable[3];
  assign adc_enable_4 = adc_enable[4];
  assign adc_enable_5 = adc_enable[5];
  assign adc_enable_6 = adc_enable[6];
  assign adc_enable_7 = adc_enable[7];

  // processor read interface

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_wack <= 'd0;
      up_rack <= 'd0;
      up_rdata <= 'd0;
    end else begin
      up_wack <= |up_wack_s;
      up_rack <= |up_rack_s;
      up_rdata <= up_rdata_s[0] |
                  up_rdata_s[1] |
                  up_rdata_s[2] |
                  up_rdata_s[3] |
                  up_rdata_s[4] |
                  up_rdata_s[5] |
                  up_rdata_s[6] |
                  up_rdata_s[7] |
                  up_rdata_s[8];
    end
  end

  generate
    if (EXTERNAL_CLK == 1'b1) begin
      assign adc_clk_s = external_clk;
    end else begin
      assign adc_clk_s = up_clk;
    end

    if (LVDS_CMOS_N == 1) begin // TODO: add support for LVDS interface
      assign scki = 1'b0;
    end else begin
      assign scki_p = 1'b0;
      assign scki_n = 1'b1;
      axi_ltc235x_cmos #(
        .NUM_CHANNELS (NUM_CHANNELS),
        .DATA_WIDTH (DATA_WIDTH),
        .ACTIVE_LANE (ACTIVE_LANES),
        .SOFTSPAN_NEXT (SOFTSPAN_NEXT))
      i_ltc235x_cmos (
        .rst (adc_rst_s),
        .clk (adc_clk_s),
        .adc_enable (adc_enable),
        .scki (scki),
        .db_o (sdi),
        .scko (scko),
        .db_i ({sdo_7,
                sdo_6,
                sdo_5,
                sdo_4,
                sdo_3,
                sdo_2,
                sdo_1,
                sdo_0}),
        .busy (busy),
        .adc_ch0_id (adc_status_header[0]),
        .adc_ch1_id (adc_status_header[1]),
        .adc_ch2_id (adc_status_header[2]),
        .adc_ch3_id (adc_status_header[3]),
        .adc_ch4_id (adc_status_header[4]),
        .adc_ch5_id (adc_status_header[5]),
        .adc_ch6_id (adc_status_header[6]),
        .adc_ch7_id (adc_status_header[7]),
        .adc_data_0 (adc_data_0),
        .adc_data_1 (adc_data_1),
        .adc_data_2 (adc_data_2),
        .adc_data_3 (adc_data_3),
        .adc_data_4 (adc_data_4),
        .adc_data_5 (adc_data_5),
        .adc_data_6 (adc_data_6),
        .adc_data_7 (adc_data_7),
        .adc_valid (adc_valid));
   end
  endgenerate

  // regmap adc channels

  generate
    genvar i;
    for (i = 0; i < 8; i=i+1) begin : regmap_channels
      up_adc_channel #(
        .CHANNEL_ID(i)
      ) i_up_adc_channel (
        .adc_clk (adc_clk_s),
        .adc_rst (adc_rst_s),
        .adc_enable (adc_enable[i]),
        .adc_iqcor_enb (),
        .adc_dcfilt_enb (),
        .adc_dfmt_se (),
        .adc_dfmt_type (),
        .adc_dfmt_enable (),
        .adc_dcfilt_offset (),
        .adc_dcfilt_coeff (),
        .adc_iqcor_coeff_1 (),
        .adc_iqcor_coeff_2 (),
        .adc_pnseq_sel (),
        .adc_data_sel (),
        .adc_pn_err (1'b0),
        .adc_pn_oos (1'b0),
        .adc_or (1'b0),
        .adc_read_data (32'h0),
        .adc_status_header({5'd0, adc_status_header[i]}),
        .adc_crc_err(1'b0),
        .up_adc_pn_err (),
        .up_adc_pn_oos (),
        .up_adc_or (),
        .up_usr_datatype_be (),
        .up_usr_datatype_signed (),
        .up_usr_datatype_shift (),
        .up_usr_datatype_total_bits (),
        .up_usr_datatype_bits (),
        .up_usr_decimation_m (),
        .up_usr_decimation_n (),
        .adc_usr_datatype_be (1'b0),
        .adc_usr_datatype_signed (1'b1),
        .adc_usr_datatype_shift (8'd0),
        .adc_usr_datatype_total_bits (8'd32),
        .adc_usr_datatype_bits (8'd32),
        .adc_usr_decimation_m (16'd1),
        .adc_usr_decimation_n (16'd1),
        .up_rstn (up_rstn),
        .up_clk (up_clk),
        .up_wreq (up_wreq_s),
        .up_waddr (up_waddr_s),
        .up_wdata (up_wdata_s),
        .up_wack (up_wack_s[i]),
        .up_rreq (up_rreq_s),
        .up_raddr (up_raddr_s),
        .up_rdata (up_rdata_s[i]),
        .up_rack (up_rack_s[i]));
    end
  endgenerate

  // up adc common

  up_adc_common #(
    .ID(ID)
  ) i_up_adc_common (
    .mmcm_rst (),
    .adc_clk (adc_clk_s),
    .adc_rst (adc_rst_s),
    .adc_r1_mode (),
    .adc_ddr_edgesel (),
    .adc_pin_mode (),
    .adc_status ('h1),
    .adc_sync_status (1'b1),
    .adc_status_ovf (adc_dovf),
    .adc_clk_ratio (32'd1),
    .adc_start_code (),
    .adc_sref_sync (),
    .adc_sync (),
    .adc_ext_sync_arm(),
    .adc_ext_sync_disarm(),
    .adc_ext_sync_manual_req(),
    .adc_custom_control(),
    .adc_sdr_ddr_n(),
    .adc_symb_op(),
    .adc_symb_8_16b(),
    .adc_num_lanes(),
    .adc_crc_enable(),
    .up_pps_rcounter (32'b0),
    .up_pps_status (1'b0),
    .up_pps_irq_mask (),
    .up_adc_r1_mode(),
    .up_adc_ce (),
    .up_status_pn_err (1'b0),
    .up_status_pn_oos (1'b0),
    .up_status_or (1'b0),
    .up_drp_sel (),
    .up_drp_wr (),
    .up_drp_addr (),
    .up_drp_wdata (),
    .up_drp_rdata (32'd0),
    .up_drp_ready (1'd0),
    .up_drp_locked (1'd1),
    .adc_custom_wr (),
    .adc_write_req (),
    .adc_custom_rd (32'h0),
    .adc_read_valid (1'b0),
    .adc_read_req (),
    .up_usr_chanmax_out (),
    .up_usr_chanmax_in (8),
    .up_adc_gpio_in (32'b0),
    .up_adc_gpio_out (),
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_wreq (up_wreq_s),
    .up_waddr (up_waddr_s),
    .up_wdata (up_wdata_s),
    .up_wack (up_wack_s[8]),
    .up_rreq (up_rreq_s),
    .up_raddr (up_raddr_s),
    .up_rdata (up_rdata_s[8]),
    .up_rack (up_rack_s[8]));

  // up bus interface

  up_axi #(
    .AXI_ADDRESS_WIDTH (16)
  ) i_up_axi (
    .up_rstn (up_rstn),
    .up_clk (up_clk),
    .up_axi_awvalid (s_axi_awvalid),
    .up_axi_awaddr (s_axi_awaddr),
    .up_axi_awready (s_axi_awready),
    .up_axi_wvalid (s_axi_wvalid),
    .up_axi_wdata (s_axi_wdata),
    .up_axi_wstrb (s_axi_wstrb),
    .up_axi_wready (s_axi_wready),
    .up_axi_bvalid (s_axi_bvalid),
    .up_axi_bresp (s_axi_bresp),
    .up_axi_bready (s_axi_bready),
    .up_axi_arvalid (s_axi_arvalid),
    .up_axi_araddr (s_axi_araddr),
    .up_axi_arready (s_axi_arready),
    .up_axi_rvalid (s_axi_rvalid),
    .up_axi_rresp (s_axi_rresp),
    .up_axi_rdata (s_axi_rdata),
    .up_axi_rready (s_axi_rready),
    .up_wreq (up_wreq_s),
    .up_waddr (up_waddr_s),
    .up_wdata (up_wdata_s),
    .up_wack (up_wack),
    .up_rreq (up_rreq_s),
    .up_raddr (up_raddr_s),
    .up_rdata (up_rdata),
    .up_rack (up_rack));

  // TODO: add support for other LTC235x members

endmodule
