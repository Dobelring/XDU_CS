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

-- DATE "03/11/2025 16:22:43"

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

ENTITY 	shao1 IS
    PORT (
	S1 : OUT std_logic;
	B4 : IN std_logic;
	C0 : IN std_logic;
	A1 : IN std_logic;
	A2 : IN std_logic;
	B1 : IN std_logic;
	B2 : IN std_logic;
	A3 : IN std_logic;
	B3 : IN std_logic;
	A4 : IN std_logic;
	S2 : OUT std_logic;
	S3 : OUT std_logic;
	S4 : OUT std_logic;
	C4 : OUT std_logic
	);
END shao1;

-- Design Ports Information
-- S1	=>  Location: PIN_L5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S2	=>  Location: PIN_N13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S3	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S4	=>  Location: PIN_N12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- C4	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- C0	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A1	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B1	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B2	=>  Location: PIN_L9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A2	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A3	=>  Location: PIN_N9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B3	=>  Location: PIN_M4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B4	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A4	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF shao1 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_S1 : std_logic;
SIGNAL ww_B4 : std_logic;
SIGNAL ww_C0 : std_logic;
SIGNAL ww_A1 : std_logic;
SIGNAL ww_A2 : std_logic;
SIGNAL ww_B1 : std_logic;
SIGNAL ww_B2 : std_logic;
SIGNAL ww_A3 : std_logic;
SIGNAL ww_B3 : std_logic;
SIGNAL ww_A4 : std_logic;
SIGNAL ww_S2 : std_logic;
SIGNAL ww_S3 : std_logic;
SIGNAL ww_S4 : std_logic;
SIGNAL ww_C4 : std_logic;
SIGNAL \S1~output_o\ : std_logic;
SIGNAL \S2~output_o\ : std_logic;
SIGNAL \S3~output_o\ : std_logic;
SIGNAL \S4~output_o\ : std_logic;
SIGNAL \C4~output_o\ : std_logic;
SIGNAL \B1~input_o\ : std_logic;
SIGNAL \C0~input_o\ : std_logic;
SIGNAL \A1~input_o\ : std_logic;
SIGNAL \inst|42~0_combout\ : std_logic;
SIGNAL \inst|54~0_combout\ : std_logic;
SIGNAL \inst|18~0_combout\ : std_logic;
SIGNAL \A2~input_o\ : std_logic;
SIGNAL \B2~input_o\ : std_logic;
SIGNAL \inst|43~combout\ : std_logic;
SIGNAL \inst|20~0_combout\ : std_logic;
SIGNAL \inst|24~combout\ : std_logic;
SIGNAL \inst|51~0_combout\ : std_logic;
SIGNAL \B3~input_o\ : std_logic;
SIGNAL \A3~input_o\ : std_logic;
SIGNAL \inst|44~combout\ : std_logic;
SIGNAL \A4~input_o\ : std_logic;
SIGNAL \B4~input_o\ : std_logic;
SIGNAL \inst|45~0_combout\ : std_logic;
SIGNAL \inst|45~1_combout\ : std_logic;
SIGNAL \inst|45~2_combout\ : std_logic;
SIGNAL \inst|2~0_combout\ : std_logic;
SIGNAL \inst|ALT_INV_44~combout\ : std_logic;
SIGNAL \inst|ALT_INV_43~combout\ : std_logic;

BEGIN

S1 <= ww_S1;
ww_B4 <= B4;
ww_C0 <= C0;
ww_A1 <= A1;
ww_A2 <= A2;
ww_B1 <= B1;
ww_B2 <= B2;
ww_A3 <= A3;
ww_B3 <= B3;
ww_A4 <= A4;
S2 <= ww_S2;
S3 <= ww_S3;
S4 <= ww_S4;
C4 <= ww_C4;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\inst|ALT_INV_44~combout\ <= NOT \inst|44~combout\;
\inst|ALT_INV_43~combout\ <= NOT \inst|43~combout\;

-- Location: IOOBUF_X14_Y0_N9
\S1~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|42~0_combout\,
	devoe => ww_devoe,
	o => \S1~output_o\);

-- Location: IOOBUF_X33_Y10_N9
\S2~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ALT_INV_43~combout\,
	devoe => ww_devoe,
	o => \S2~output_o\);

-- Location: IOOBUF_X8_Y0_N9
\S3~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ALT_INV_44~combout\,
	devoe => ww_devoe,
	o => \S3~output_o\);

-- Location: IOOBUF_X29_Y0_N2
\S4~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|45~2_combout\,
	devoe => ww_devoe,
	o => \S4~output_o\);

-- Location: IOOBUF_X20_Y0_N9
\C4~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|2~0_combout\,
	devoe => ww_devoe,
	o => \C4~output_o\);

-- Location: IOIBUF_X22_Y0_N1
\B1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B1,
	o => \B1~input_o\);

-- Location: IOIBUF_X12_Y0_N1
\C0~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_C0,
	o => \C0~input_o\);

-- Location: IOIBUF_X26_Y0_N1
\A1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A1,
	o => \A1~input_o\);

-- Location: LCCOMB_X14_Y1_N8
\inst|42~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|42~0_combout\ = \B1~input_o\ $ (\C0~input_o\ $ (\A1~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B1~input_o\,
	datac => \C0~input_o\,
	datad => \A1~input_o\,
	combout => \inst|42~0_combout\);

-- Location: LCCOMB_X14_Y1_N10
\inst|54~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|54~0_combout\ = (!\B1~input_o\ & !\C0~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B1~input_o\,
	datac => \C0~input_o\,
	combout => \inst|54~0_combout\);

-- Location: LCCOMB_X14_Y1_N28
\inst|18~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|18~0_combout\ = (!\A1~input_o\ & ((!\C0~input_o\) # (!\B1~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B1~input_o\,
	datac => \C0~input_o\,
	datad => \A1~input_o\,
	combout => \inst|18~0_combout\);

-- Location: IOIBUF_X14_Y0_N1
\A2~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A2,
	o => \A2~input_o\);

-- Location: IOIBUF_X24_Y0_N8
\B2~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B2,
	o => \B2~input_o\);

-- Location: LCCOMB_X14_Y1_N6
\inst|43\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|43~combout\ = \A2~input_o\ $ (\B2~input_o\ $ (((\inst|54~0_combout\) # (\inst|18~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000100011110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|54~0_combout\,
	datab => \inst|18~0_combout\,
	datac => \A2~input_o\,
	datad => \B2~input_o\,
	combout => \inst|43~combout\);

-- Location: LCCOMB_X14_Y1_N24
\inst|20~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|20~0_combout\ = (!\A2~input_o\ & !\B2~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A2~input_o\,
	datad => \B2~input_o\,
	combout => \inst|20~0_combout\);

-- Location: LCCOMB_X14_Y1_N26
\inst|24\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|24~combout\ = (\A2~input_o\ & \B2~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \A2~input_o\,
	datad => \B2~input_o\,
	combout => \inst|24~combout\);

-- Location: LCCOMB_X14_Y1_N12
\inst|51~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|51~0_combout\ = (\inst|20~0_combout\) # ((!\inst|24~combout\ & ((\inst|54~0_combout\) # (\inst|18~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|54~0_combout\,
	datab => \inst|20~0_combout\,
	datac => \inst|24~combout\,
	datad => \inst|18~0_combout\,
	combout => \inst|51~0_combout\);

-- Location: IOIBUF_X8_Y0_N1
\B3~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B3,
	o => \B3~input_o\);

-- Location: IOIBUF_X20_Y0_N1
\A3~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A3,
	o => \A3~input_o\);

-- Location: LCCOMB_X14_Y1_N22
\inst|44\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|44~combout\ = \inst|51~0_combout\ $ (\B3~input_o\ $ (\A3~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|51~0_combout\,
	datac => \B3~input_o\,
	datad => \A3~input_o\,
	combout => \inst|44~combout\);

-- Location: IOIBUF_X12_Y0_N8
\A4~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A4,
	o => \A4~input_o\);

-- Location: IOIBUF_X10_Y0_N8
\B4~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B4,
	o => \B4~input_o\);

-- Location: LCCOMB_X14_Y1_N0
\inst|45~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|45~0_combout\ = (\inst|24~combout\) # ((\B1~input_o\ & ((\C0~input_o\) # (\A1~input_o\))) # (!\B1~input_o\ & (\C0~input_o\ & \A1~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|24~combout\,
	datab => \B1~input_o\,
	datac => \C0~input_o\,
	datad => \A1~input_o\,
	combout => \inst|45~0_combout\);

-- Location: LCCOMB_X14_Y1_N18
\inst|45~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|45~1_combout\ = (\B3~input_o\ & ((\A3~input_o\) # ((!\inst|20~0_combout\ & \inst|45~0_combout\)))) # (!\B3~input_o\ & (!\inst|20~0_combout\ & (\inst|45~0_combout\ & \A3~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|20~0_combout\,
	datab => \inst|45~0_combout\,
	datac => \B3~input_o\,
	datad => \A3~input_o\,
	combout => \inst|45~1_combout\);

-- Location: LCCOMB_X14_Y1_N20
\inst|45~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|45~2_combout\ = \A4~input_o\ $ (\B4~input_o\ $ (\inst|45~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100101100110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A4~input_o\,
	datab => \B4~input_o\,
	datad => \inst|45~1_combout\,
	combout => \inst|45~2_combout\);

-- Location: LCCOMB_X14_Y1_N30
\inst|2~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|2~0_combout\ = (\A4~input_o\ & ((\B4~input_o\) # (\inst|45~1_combout\))) # (!\A4~input_o\ & (\B4~input_o\ & \inst|45~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \A4~input_o\,
	datab => \B4~input_o\,
	datad => \inst|45~1_combout\,
	combout => \inst|2~0_combout\);

ww_S1 <= \S1~output_o\;

ww_S2 <= \S2~output_o\;

ww_S3 <= \S3~output_o\;

ww_S4 <= \S4~output_o\;

ww_C4 <= \C4~output_o\;
END structure;


