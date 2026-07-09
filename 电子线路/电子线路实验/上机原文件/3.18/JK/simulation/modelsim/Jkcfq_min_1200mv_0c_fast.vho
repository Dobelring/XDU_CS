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

-- DATE "03/18/2025 16:31:58"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Jkcfq IS
    PORT (
	Q : OUT std_logic;
	PRN : IN std_logic;
	CLR : IN std_logic;
	K : IN std_logic;
	J : IN std_logic;
	clk : IN std_logic
	);
END Jkcfq;

-- Design Ports Information
-- Q	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PRN	=>  Location: PIN_M4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLR	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- J	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- K	=>  Location: PIN_L5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Jkcfq IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_Q : std_logic;
SIGNAL ww_PRN : std_logic;
SIGNAL ww_CLR : std_logic;
SIGNAL ww_K : std_logic;
SIGNAL ww_J : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL \Q~output_o\ : std_logic;
SIGNAL \PRN~input_o\ : std_logic;
SIGNAL \CLR~input_o\ : std_logic;
SIGNAL \inst~1_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \K~input_o\ : std_logic;
SIGNAL \J~input_o\ : std_logic;
SIGNAL \inst~3_combout\ : std_logic;
SIGNAL \inst~0_combout\ : std_logic;
SIGNAL \inst~_emulated_q\ : std_logic;
SIGNAL \inst~2_combout\ : std_logic;
SIGNAL \ALT_INV_inst~0_combout\ : std_logic;

BEGIN

Q <= ww_Q;
ww_PRN <= PRN;
ww_CLR <= CLR;
ww_K <= K;
ww_J <= J;
ww_clk <= clk;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_inst~0_combout\ <= NOT \inst~0_combout\;

-- Location: IOOBUF_X10_Y0_N9
\Q~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst~2_combout\,
	devoe => ww_devoe,
	o => \Q~output_o\);

-- Location: IOIBUF_X8_Y0_N1
\PRN~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PRN,
	o => \PRN~input_o\);

-- Location: IOIBUF_X12_Y0_N8
\CLR~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLR,
	o => \CLR~input_o\);

-- Location: LCCOMB_X12_Y1_N2
\inst~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~1_combout\ = (\CLR~input_o\ & ((\inst~1_combout\) # (!\PRN~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \CLR~input_o\,
	datac => \PRN~input_o\,
	datad => \inst~1_combout\,
	combout => \inst~1_combout\);

-- Location: IOIBUF_X12_Y0_N1
\clk~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: IOIBUF_X14_Y0_N8
\K~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_K,
	o => \K~input_o\);

-- Location: IOIBUF_X14_Y0_N1
\J~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_J,
	o => \J~input_o\);

-- Location: LCCOMB_X12_Y1_N28
\inst~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~3_combout\ = \inst~1_combout\ $ (((\inst~2_combout\ & (!\K~input_o\)) # (!\inst~2_combout\ & ((\J~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100100111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \K~input_o\,
	datab => \inst~1_combout\,
	datac => \J~input_o\,
	datad => \inst~2_combout\,
	combout => \inst~3_combout\);

-- Location: LCCOMB_X12_Y1_N12
\inst~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~0_combout\ = (!\PRN~input_o\) # (!\CLR~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \CLR~input_o\,
	datac => \PRN~input_o\,
	combout => \inst~0_combout\);

-- Location: FF_X12_Y1_N29
\inst~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst~3_combout\,
	clrn => \ALT_INV_inst~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst~_emulated_q\);

-- Location: LCCOMB_X12_Y1_N10
\inst~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~2_combout\ = (\CLR~input_o\ & ((\inst~1_combout\ $ (\inst~_emulated_q\)) # (!\PRN~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000011010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PRN~input_o\,
	datab => \inst~1_combout\,
	datac => \CLR~input_o\,
	datad => \inst~_emulated_q\,
	combout => \inst~2_combout\);

ww_Q <= \Q~output_o\;
END structure;


