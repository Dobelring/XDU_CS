-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 32-bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Full Version"

-- DATE "03/11/2025 16:04:03"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	qjq IS
    PORT (
	Q0 : OUT std_logic;
	A0 : IN std_logic;
	B0 : IN std_logic;
	Cin : IN std_logic;
	Q1 : OUT std_logic;
	A1 : IN std_logic;
	B1 : IN std_logic;
	Q2 : OUT std_logic;
	A2 : IN std_logic;
	B2 : IN std_logic;
	Q3 : OUT std_logic;
	A3 : IN std_logic;
	B3 : IN std_logic;
	Cout : OUT std_logic
	);
END qjq;

-- Design Ports Information
-- Q0	=>  Location: PIN_L5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q1	=>  Location: PIN_N13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q2	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q3	=>  Location: PIN_N12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Cout	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A0	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B0	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Cin	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B1	=>  Location: PIN_L9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A1	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A2	=>  Location: PIN_N9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B2	=>  Location: PIN_M4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B3	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A3	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF qjq IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_Q0 : std_logic;
SIGNAL ww_A0 : std_logic;
SIGNAL ww_B0 : std_logic;
SIGNAL ww_Cin : std_logic;
SIGNAL ww_Q1 : std_logic;
SIGNAL ww_A1 : std_logic;
SIGNAL ww_B1 : std_logic;
SIGNAL ww_Q2 : std_logic;
SIGNAL ww_A2 : std_logic;
SIGNAL ww_B2 : std_logic;
SIGNAL ww_Q3 : std_logic;
SIGNAL ww_A3 : std_logic;
SIGNAL ww_B3 : std_logic;
SIGNAL ww_Cout : std_logic;
SIGNAL \Q0~output_o\ : std_logic;
SIGNAL \Q1~output_o\ : std_logic;
SIGNAL \Q2~output_o\ : std_logic;
SIGNAL \Q3~output_o\ : std_logic;
SIGNAL \Cout~output_o\ : std_logic;
SIGNAL \Cin~input_o\ : std_logic;
SIGNAL \A0~input_o\ : std_logic;
SIGNAL \B0~input_o\ : std_logic;
SIGNAL \inst5~0_combout\ : std_logic;
SIGNAL \B1~input_o\ : std_logic;
SIGNAL \A1~input_o\ : std_logic;
SIGNAL \inst00~0_combout\ : std_logic;
SIGNAL \inst00~1_combout\ : std_logic;
SIGNAL \inst6~combout\ : std_logic;
SIGNAL \inst7~0_combout\ : std_logic;
SIGNAL \B2~input_o\ : std_logic;
SIGNAL \A2~input_o\ : std_logic;
SIGNAL \inst10~0_combout\ : std_logic;
SIGNAL \A3~input_o\ : std_logic;
SIGNAL \B3~input_o\ : std_logic;
SIGNAL \inst12~1_combout\ : std_logic;
SIGNAL \inst12~0_combout\ : std_logic;
SIGNAL \inst15~combout\ : std_logic;
SIGNAL \inst17~0_combout\ : std_logic;

BEGIN

Q0 <= ww_Q0;
ww_A0 <= A0;
ww_B0 <= B0;
ww_Cin <= Cin;
Q1 <= ww_Q1;
ww_A1 <= A1;
ww_B1 <= B1;
Q2 <= ww_Q2;
ww_A2 <= A2;
ww_B2 <= B2;
Q3 <= ww_Q3;
ww_A3 <= A3;
ww_B3 <= B3;
Cout <= ww_Cout;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X14_Y0_N9
\Q0~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst5~0_combout\,
	devoe => ww_devoe,
	o => \Q0~output_o\);

-- Location: IOOBUF_X33_Y10_N9
\Q1~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst6~combout\,
	devoe => ww_devoe,
	o => \Q1~output_o\);

-- Location: IOOBUF_X8_Y0_N9
\Q2~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst10~0_combout\,
	devoe => ww_devoe,
	o => \Q2~output_o\);

-- Location: IOOBUF_X29_Y0_N2
\Q3~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst15~combout\,
	devoe => ww_devoe,
	o => \Q3~output_o\);

-- Location: IOOBUF_X20_Y0_N9
\Cout~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst17~0_combout\,
	devoe => ww_devoe,
	o => \Cout~output_o\);

-- Location: IOIBUF_X22_Y0_N1
\Cin~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Cin,
	o => \Cin~input_o\);

-- Location: IOIBUF_X12_Y0_N1
\A0~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A0,
	o => \A0~input_o\);

-- Location: IOIBUF_X26_Y0_N1
\B0~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B0,
	o => \B0~input_o\);

-- Location: LCCOMB_X14_Y1_N8
\inst5~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst5~0_combout\ = \Cin~input_o\ $ (\A0~input_o\ $ (\B0~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Cin~input_o\,
	datac => \A0~input_o\,
	datad => \B0~input_o\,
	combout => \inst5~0_combout\);

-- Location: IOIBUF_X24_Y0_N8
\B1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B1,
	o => \B1~input_o\);

-- Location: IOIBUF_X14_Y0_N1
\A1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A1,
	o => \A1~input_o\);

-- Location: LCCOMB_X14_Y1_N26
\inst00~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst00~0_combout\ = (\Cin~input_o\ & \A0~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Cin~input_o\,
	datac => \A0~input_o\,
	combout => \inst00~0_combout\);

-- Location: LCCOMB_X14_Y1_N28
\inst00~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst00~1_combout\ = (\B0~input_o\ & ((\Cin~input_o\) # (\A0~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \Cin~input_o\,
	datac => \A0~input_o\,
	datad => \B0~input_o\,
	combout => \inst00~1_combout\);

-- Location: LCCOMB_X14_Y1_N6
inst6 : cycloneiv_lcell_comb
-- Equation(s):
-- \inst6~combout\ = \B1~input_o\ $ (\A1~input_o\ $ (((\inst00~0_combout\) # (\inst00~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B1~input_o\,
	datab => \A1~input_o\,
	datac => \inst00~0_combout\,
	datad => \inst00~1_combout\,
	combout => \inst6~combout\);

-- Location: LCCOMB_X14_Y1_N0
\inst7~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst7~0_combout\ = (\B1~input_o\ & ((\A1~input_o\) # ((\inst00~0_combout\) # (\inst00~1_combout\)))) # (!\B1~input_o\ & (\A1~input_o\ & ((\inst00~0_combout\) # (\inst00~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B1~input_o\,
	datab => \A1~input_o\,
	datac => \inst00~0_combout\,
	datad => \inst00~1_combout\,
	combout => \inst7~0_combout\);

-- Location: IOIBUF_X8_Y0_N1
\B2~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B2,
	o => \B2~input_o\);

-- Location: IOIBUF_X20_Y0_N1
\A2~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A2,
	o => \A2~input_o\);

-- Location: LCCOMB_X14_Y1_N2
\inst10~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst10~0_combout\ = \inst7~0_combout\ $ (\B2~input_o\ $ (\A2~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst7~0_combout\,
	datac => \B2~input_o\,
	datad => \A2~input_o\,
	combout => \inst10~0_combout\);

-- Location: IOIBUF_X12_Y0_N8
\A3~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A3,
	o => \A3~input_o\);

-- Location: IOIBUF_X10_Y0_N8
\B3~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B3,
	o => \B3~input_o\);

-- Location: LCCOMB_X14_Y1_N22
\inst12~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst12~1_combout\ = (\B2~input_o\ & ((\inst7~0_combout\) # (\A2~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst7~0_combout\,
	datac => \B2~input_o\,
	datad => \A2~input_o\,
	combout => \inst12~1_combout\);

-- Location: LCCOMB_X14_Y1_N12
\inst12~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst12~0_combout\ = (\inst7~0_combout\ & \A2~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst7~0_combout\,
	datad => \A2~input_o\,
	combout => \inst12~0_combout\);

-- Location: LCCOMB_X14_Y1_N16
inst15 : cycloneiv_lcell_comb
-- Equation(s):
-- \inst15~combout\ = \A3~input_o\ $ (\B3~input_o\ $ (((\inst12~1_combout\) # (\inst12~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A3~input_o\,
	datab => \B3~input_o\,
	datac => \inst12~1_combout\,
	datad => \inst12~0_combout\,
	combout => \inst15~combout\);

-- Location: LCCOMB_X14_Y1_N10
\inst17~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst17~0_combout\ = (\A3~input_o\ & ((\B3~input_o\) # ((\inst12~1_combout\) # (\inst12~0_combout\)))) # (!\A3~input_o\ & (\B3~input_o\ & ((\inst12~1_combout\) # (\inst12~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A3~input_o\,
	datab => \B3~input_o\,
	datac => \inst12~1_combout\,
	datad => \inst12~0_combout\,
	combout => \inst17~0_combout\);

ww_Q0 <= \Q0~output_o\;

ww_Q1 <= \Q1~output_o\;

ww_Q2 <= \Q2~output_o\;

ww_Q3 <= \Q3~output_o\;

ww_Cout <= \Cout~output_o\;
END structure;


