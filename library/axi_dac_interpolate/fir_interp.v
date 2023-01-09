// -------------------------------------------------------------
//
// Module: fir_interp
// Generated by MATLAB(R) 9.0 and the Filter Design HDL Coder 3.0.
// Generated on: 2016-07-05 15:54:12
// -------------------------------------------------------------

// -------------------------------------------------------------
// HDL Code Generation Options:
//
// FIRAdderStyle: tree
// OptimizeForHDL: on
// EDAScriptGeneration: off
// AddPipelineRegisters: on
// Name: fir_interp
// TargetLanguage: Verilog
// TestBenchName: fo_copy_tb
// TestBenchStimulus: step ramp chirp noise
// GenerateHDLTestBench: off

// -------------------------------------------------------------
// HDL Implementation    : Fully parallel
// Multipliers           : 12
// Folding Factor        : 1
// -------------------------------------------------------------
// Filter Settings:
//
// Discrete-Time FIR Multirate Filter (real)
// -----------------------------------------
// Filter Structure      : Direct-Form FIR Polyphase Interpolator
// Interpolation Factor  : 2
// Polyphase Length      : 12
// Filter Length         : 24
// Stable                : Yes
// Linear Phase          : Yes (Type 2)
//
// Arithmetic            : fixed
// Numerator             : s16,15 -> [-1 1)
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module fir_interp (
  input  clk,
  input  clk_enable,
  input  reset,
  input  signed [15:0] filter_in, //sfix16_En15
  output signed [35:0] filter_out, //sfix36_En30
  output ce_out
);

////////////////////////////////////////////////////////////////
//Module Architecture: fir_interp
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [15:0] coeffphase1_1 = 16'b1111111110101001; //sfix16_En15
  parameter signed [15:0] coeffphase1_2 = 16'b1111111101111010; //sfix16_En15
  parameter signed [15:0] coeffphase1_3 = 16'b0000010011111111; //sfix16_En15
  parameter signed [15:0] coeffphase1_4 = 16'b1111101010101110; //sfix16_En15
  parameter signed [15:0] coeffphase1_5 = 16'b1111001001101000; //sfix16_En15
  parameter signed [15:0] coeffphase1_6 = 16'b0011011010110011; //sfix16_En15
  parameter signed [15:0] coeffphase1_7 = 16'b0101011100111111; //sfix16_En15
  parameter signed [15:0] coeffphase1_8 = 16'b0000110010011010; //sfix16_En15
  parameter signed [15:0] coeffphase1_9 = 16'b1111000000000010; //sfix16_En15
  parameter signed [15:0] coeffphase1_10 = 16'b0000001110101000; //sfix16_En15
  parameter signed [15:0] coeffphase1_11 = 16'b0000000111110010; //sfix16_En15
  parameter signed [15:0] coeffphase1_12 = 16'b1111111100011100; //sfix16_En15
  parameter signed [15:0] coeffphase2_1 = 16'b1111111100011100; //sfix16_En15
  parameter signed [15:0] coeffphase2_2 = 16'b0000000111110010; //sfix16_En15
  parameter signed [15:0] coeffphase2_3 = 16'b0000001110101000; //sfix16_En15
  parameter signed [15:0] coeffphase2_4 = 16'b1111000000000010; //sfix16_En15
  parameter signed [15:0] coeffphase2_5 = 16'b0000110010011010; //sfix16_En15
  parameter signed [15:0] coeffphase2_6 = 16'b0101011100111111; //sfix16_En15
  parameter signed [15:0] coeffphase2_7 = 16'b0011011010110011; //sfix16_En15
  parameter signed [15:0] coeffphase2_8 = 16'b1111001001101000; //sfix16_En15
  parameter signed [15:0] coeffphase2_9 = 16'b1111101010101110; //sfix16_En15
  parameter signed [15:0] coeffphase2_10 = 16'b0000010011111111; //sfix16_En15
  parameter signed [15:0] coeffphase2_11 = 16'b1111111101111010; //sfix16_En15
  parameter signed [15:0] coeffphase2_12 = 16'b1111111110101001; //sfix16_En15

  // Signals
  reg  [1:0] cur_count = 0; // ufix2
  wire phase_1; // boolean
  reg  signed [15:0] delay_pipeline [0:11]; // sfix16_En15
  wire signed [31:0] product; // sfix32_En30
  wire signed [15:0] product_mux; // sfix16_En15
  wire signed [31:0] product_1; // sfix32_En30
  wire signed [15:0] product_mux_1; // sfix16_En15
  wire signed [31:0] product_2; // sfix32_En30
  wire signed [15:0] product_mux_2; // sfix16_En15
  wire signed [31:0] product_3; // sfix32_En30
  wire signed [15:0] product_mux_3; // sfix16_En15
  wire signed [31:0] product_4; // sfix32_En30
  wire signed [15:0] product_mux_4; // sfix16_En15
  wire signed [31:0] product_5; // sfix32_En30
  wire signed [15:0] product_mux_5; // sfix16_En15
  wire signed [31:0] product_6; // sfix32_En30
  wire signed [15:0] product_mux_6; // sfix16_En15
  wire signed [31:0] product_7; // sfix32_En30
  wire signed [15:0] product_mux_7; // sfix16_En15
  wire signed [31:0] product_8; // sfix32_En30
  wire signed [15:0] product_mux_8; // sfix16_En15
  wire signed [31:0] product_9; // sfix32_En30
  wire signed [15:0] product_mux_9; // sfix16_En15
  wire signed [31:0] product_10; // sfix32_En30
  wire signed [15:0] product_mux_10; // sfix16_En15
  wire signed [31:0] product_11; // sfix32_En30
  wire signed [15:0] product_mux_11; // sfix16_En15
  wire signed [35:0] sumvector1 [0:5] ; // sfix36_En30
  wire signed [31:0] add_signext; // sfix32_En30
  wire signed [31:0] add_signext_1; // sfix32_En30
  wire signed [32:0] add_temp; // sfix33_En30
  wire signed [31:0] add_signext_2; // sfix32_En30
  wire signed [31:0] add_signext_3; // sfix32_En30
  wire signed [32:0] add_temp_1; // sfix33_En30
  wire signed [31:0] add_signext_4; // sfix32_En30
  wire signed [31:0] add_signext_5; // sfix32_En30
  wire signed [32:0] add_temp_2; // sfix33_En30
  wire signed [31:0] add_signext_6; // sfix32_En30
  wire signed [31:0] add_signext_7; // sfix32_En30
  wire signed [32:0] add_temp_3; // sfix33_En30
  wire signed [31:0] add_signext_8; // sfix32_En30
  wire signed [31:0] add_signext_9; // sfix32_En30
  wire signed [32:0] add_temp_4; // sfix33_En30
  wire signed [31:0] add_signext_10; // sfix32_En30
  wire signed [31:0] add_signext_11; // sfix32_En30
  wire signed [32:0] add_temp_5; // sfix33_En30
  reg  signed [35:0] sumdelay_pipeline1 [0:5]; // sfix36_En30
  wire signed [35:0] sumvector2 [0:2] ; // sfix36_En30
  wire signed [35:0] add_signext_12; // sfix36_En30
  wire signed [35:0] add_signext_13; // sfix36_En30
  wire signed [36:0] add_temp_6; // sfix37_En30
  wire signed [35:0] add_signext_14; // sfix36_En30
  wire signed [35:0] add_signext_15; // sfix36_En30
  wire signed [36:0] add_temp_7; // sfix37_En30
  wire signed [35:0] add_signext_16; // sfix36_En30
  wire signed [35:0] add_signext_17; // sfix36_En30
  wire signed [36:0] add_temp_8; // sfix37_En30
  reg  signed [35:0] sumdelay_pipeline2 [0:2]; // sfix36_En30
  wire signed [35:0] sumvector3 [0:1] ; // sfix36_En30
  wire signed [35:0] add_signext_18; // sfix36_En30
  wire signed [35:0] add_signext_19; // sfix36_En30
  wire signed [36:0] add_temp_9; // sfix37_En30
  reg  signed [35:0] sumdelay_pipeline3 [0:1]; // sfix36_En30
  wire signed [35:0] sum4; // sfix36_En30
  wire signed [35:0] add_signext_20; // sfix36_En30
  wire signed [35:0] add_signext_21; // sfix36_En30
  wire signed [36:0] add_temp_10; // sfix37_En30
  reg  signed [35:0] output_register = 0; // sfix36_En30

  // Block Statements
  always @ (posedge clk or posedge reset)
    begin: ce_output
      if (reset == 1'b1) begin
        cur_count <= 2'b00;
      end
      else begin
        if (clk_enable == 1'b1) begin
          if (cur_count == 2'b01) begin
            cur_count <= 2'b00;
          end
          else begin
            cur_count <= cur_count + 1;
          end
        end
      end
    end // ce_output

  assign  phase_1 = (cur_count == 2'b01 && clk_enable == 1'b1)? 1 : 0;

  //   ---------------- Delay Registers ----------------

  always @( posedge clk or posedge reset)
    begin: Delay_Pipeline_process
      if (reset == 1'b1) begin
        delay_pipeline[0] <= 0;
        delay_pipeline[1] <= 0;
        delay_pipeline[2] <= 0;
        delay_pipeline[3] <= 0;
        delay_pipeline[4] <= 0;
        delay_pipeline[5] <= 0;
        delay_pipeline[6] <= 0;
        delay_pipeline[7] <= 0;
        delay_pipeline[8] <= 0;
        delay_pipeline[9] <= 0;
        delay_pipeline[10] <= 0;
        delay_pipeline[11] <= 0;
      end
      else begin
        if (phase_1 == 1'b1) begin
          delay_pipeline[0] <= filter_in;
          delay_pipeline[1] <= delay_pipeline[0];
          delay_pipeline[2] <= delay_pipeline[1];
          delay_pipeline[3] <= delay_pipeline[2];
          delay_pipeline[4] <= delay_pipeline[3];
          delay_pipeline[5] <= delay_pipeline[4];
          delay_pipeline[6] <= delay_pipeline[5];
          delay_pipeline[7] <= delay_pipeline[6];
          delay_pipeline[8] <= delay_pipeline[7];
          delay_pipeline[9] <= delay_pipeline[8];
          delay_pipeline[10] <= delay_pipeline[9];
          delay_pipeline[11] <= delay_pipeline[10];
        end
      end
    end // Delay_Pipeline_process

  assign product_mux = (cur_count == 2'b00) ? coeffphase1_12 :
                      coeffphase2_12;
  assign product = delay_pipeline[11] * product_mux;

  assign product_mux_1 = (cur_count == 2'b00) ? coeffphase1_11 :
                        coeffphase2_11;
  assign product_1 = delay_pipeline[10] * product_mux_1;

  assign product_mux_2 = (cur_count == 2'b00) ? coeffphase1_10 :
                        coeffphase2_10;
  assign product_2 = delay_pipeline[9] * product_mux_2;

  assign product_mux_3 = (cur_count == 2'b00) ? coeffphase1_9 :
                        coeffphase2_9;
  assign product_3 = delay_pipeline[8] * product_mux_3;

  assign product_mux_4 = (cur_count == 2'b00) ? coeffphase1_8 :
                        coeffphase2_8;
  assign product_4 = delay_pipeline[7] * product_mux_4;

  assign product_mux_5 = (cur_count == 2'b00) ? coeffphase1_7 :
                        coeffphase2_7;
  assign product_5 = delay_pipeline[6] * product_mux_5;

  assign product_mux_6 = (cur_count == 2'b00) ? coeffphase1_6 :
                        coeffphase2_6;
  assign product_6 = delay_pipeline[5] * product_mux_6;

  assign product_mux_7 = (cur_count == 2'b00) ? coeffphase1_5 :
                        coeffphase2_5;
  assign product_7 = delay_pipeline[4] * product_mux_7;

  assign product_mux_8 = (cur_count == 2'b00) ? coeffphase1_4 :
                        coeffphase2_4;
  assign product_8 = delay_pipeline[3] * product_mux_8;

  assign product_mux_9 = (cur_count == 2'b00) ? coeffphase1_3 :
                        coeffphase2_3;
  assign product_9 = delay_pipeline[2] * product_mux_9;

  assign product_mux_10 = (cur_count == 2'b00) ? coeffphase1_2 :
                         coeffphase2_2;
  assign product_10 = delay_pipeline[1] * product_mux_10;

  assign product_mux_11 = (cur_count == 2'b00) ? coeffphase1_1 :
                         coeffphase2_1;
  assign product_11 = delay_pipeline[0] * product_mux_11;

  assign add_signext = product;
  assign add_signext_1 = product_1;
  assign add_temp = add_signext + add_signext_1;
  assign sumvector1[0] = $signed({{3{add_temp[32]}}, add_temp});

  assign add_signext_2 = product_2;
  assign add_signext_3 = product_3;
  assign add_temp_1 = add_signext_2 + add_signext_3;
  assign sumvector1[1] = $signed({{3{add_temp_1[32]}}, add_temp_1});

  assign add_signext_4 = product_4;
  assign add_signext_5 = product_5;
  assign add_temp_2 = add_signext_4 + add_signext_5;
  assign sumvector1[2] = $signed({{3{add_temp_2[32]}}, add_temp_2});

  assign add_signext_6 = product_6;
  assign add_signext_7 = product_7;
  assign add_temp_3 = add_signext_6 + add_signext_7;
  assign sumvector1[3] = $signed({{3{add_temp_3[32]}}, add_temp_3});

  assign add_signext_8 = product_8;
  assign add_signext_9 = product_9;
  assign add_temp_4 = add_signext_8 + add_signext_9;
  assign sumvector1[4] = $signed({{3{add_temp_4[32]}}, add_temp_4});

  assign add_signext_10 = product_10;
  assign add_signext_11 = product_11;
  assign add_temp_5 = add_signext_10 + add_signext_11;
  assign sumvector1[5] = $signed({{3{add_temp_5[32]}}, add_temp_5});

  always @ (posedge clk or posedge reset)
    begin: sumdelay_pipeline_process1
      if (reset == 1'b1) begin
        sumdelay_pipeline1[0] <= 0;
        sumdelay_pipeline1[1] <= 0;
        sumdelay_pipeline1[2] <= 0;
        sumdelay_pipeline1[3] <= 0;
        sumdelay_pipeline1[4] <= 0;
        sumdelay_pipeline1[5] <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          sumdelay_pipeline1[0] <= sumvector1[0];
          sumdelay_pipeline1[1] <= sumvector1[1];
          sumdelay_pipeline1[2] <= sumvector1[2];
          sumdelay_pipeline1[3] <= sumvector1[3];
          sumdelay_pipeline1[4] <= sumvector1[4];
          sumdelay_pipeline1[5] <= sumvector1[5];
        end
      end
    end // sumdelay_pipeline_process1

  assign add_signext_12 = sumdelay_pipeline1[0];
  assign add_signext_13 = sumdelay_pipeline1[1];
  assign add_temp_6 = add_signext_12 + add_signext_13;
  assign sumvector2[0] = add_temp_6[35:0];

  assign add_signext_14 = sumdelay_pipeline1[2];
  assign add_signext_15 = sumdelay_pipeline1[3];
  assign add_temp_7 = add_signext_14 + add_signext_15;
  assign sumvector2[1] = add_temp_7[35:0];

  assign add_signext_16 = sumdelay_pipeline1[4];
  assign add_signext_17 = sumdelay_pipeline1[5];
  assign add_temp_8 = add_signext_16 + add_signext_17;
  assign sumvector2[2] = add_temp_8[35:0];

  always @ (posedge clk or posedge reset)
    begin: sumdelay_pipeline_process2
      if (reset == 1'b1) begin
        sumdelay_pipeline2[0] <= 0;
        sumdelay_pipeline2[1] <= 0;
        sumdelay_pipeline2[2] <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          sumdelay_pipeline2[0] <= sumvector2[0];
          sumdelay_pipeline2[1] <= sumvector2[1];
          sumdelay_pipeline2[2] <= sumvector2[2];
        end
      end
    end // sumdelay_pipeline_process2

  assign add_signext_18 = sumdelay_pipeline2[0];
  assign add_signext_19 = sumdelay_pipeline2[1];
  assign add_temp_9 = add_signext_18 + add_signext_19;
  assign sumvector3[0] = add_temp_9[35:0];

  assign sumvector3[1] = sumdelay_pipeline2[2];

  always @ (posedge clk or posedge reset)
    begin: sumdelay_pipeline_process3
      if (reset == 1'b1) begin
        sumdelay_pipeline3[0] <= 0;
        sumdelay_pipeline3[1] <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          sumdelay_pipeline3[0] <= sumvector3[0];
          sumdelay_pipeline3[1] <= sumvector3[1];
        end
      end
    end // sumdelay_pipeline_process3

  assign add_signext_20 = sumdelay_pipeline3[0];
  assign add_signext_21 = sumdelay_pipeline3[1];
  assign add_temp_10 = add_signext_20 + add_signext_21;
  assign sum4 = add_temp_10[35:0];

  always @ (posedge clk or posedge reset)
    begin: Output_Register_process
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          output_register <= sum4;
        end
      end
    end // Output_Register_process

  // Assignment Statements
  assign ce_out = phase_1;
  assign filter_out = output_register;
endmodule
