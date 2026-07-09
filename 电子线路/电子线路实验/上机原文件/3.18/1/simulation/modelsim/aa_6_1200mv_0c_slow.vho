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

-- DATE "03/18/2025 15:53:44"

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

ENTITY 	aa IS
    PORT (
	Q : OUT std_logic;
	CLR : IN std_logic;
	clk : IN std_logic;
	D : IN std_logic;
	PRN : IN std_logic
	);
END aa;

-- Design Ports Information
-- Q	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PRN	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLR	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- D	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_M4,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF aa IS
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
SIGNAL ww_CLR : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_D : std_logic;
SIGNAL ww_PRN : std_logic;
SIGNAL \Q~output_o\ : std_logic;
SIGNAL \PRN~input_o\ : std_logic;
SIGNAL \CLR~input_o\ : std_logic;
SIGNAL \inst~1_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \D~input_o\ : std_logic;
SIGNAL \inst~3_combout\ : std_logic;
SIGNAL \inst~0_combout\ : std_logic;
SIGNAL \inst~_emulated_q\ : std_logic;
SIGNAL \inst~2_combout\ : std_logic;
SIGNAL \ALT_INV_inst~0_combout\ : std_logic;

BEGIN

Q <= ww_Q;
ww_CLR <= CLR;
ww_clk <= clk;
ww_D <= D;
ww_PRN <= PRN;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_inst~0_combout\ <= NOT \inst~0_combout\;

-- Location: IOOBUF_X12_Y0_N2
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

-- Location: IOIBUF_X10_Y0_N8
\PRN~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PRN,
	o => \PRN~input_o\);

-- Location: IOIBUF_X26_Y0_N1
\CLR~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLR,
	o => \CLR~input_o\);

-- Location: LCCOMB_X8_Y1_N6
\inst~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~1_combout\ = (\CLR~input_o\ & ((\inst~1_combout\) # (!\PRN~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \PRN~input_o\,
	datac => \CLR~input_o\,
	datad => \inst~1_combout\,
	combout => \inst~1_combout\);

-- Location: IOIBUF_X8_Y0_N1
\clk~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: IOIBUF_X8_Y0_N8
\D~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_D,
	o => \D~input_o\);

-- Location: LCCOMB_X8_Y1_N0
\inst~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~3_combout\ = \inst~1_combout\ $ (\D~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst~1_combout\,
	datad => \D~input_o\,
	combout => \inst~3_combout\);

-- Location: LCCOMB_X8_Y1_N20
\inst~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~0_combout\ = (!\PRN~input_o\) # (!\CLR~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \CLR~input_o\,
	datad => \PRN~input_o\,
	combout => \inst~0_combout\);

-- Location: FF_X8_Y1_N1
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

-- Location: LCCOMB_X8_Y1_N2
\inst~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~2_combout\ = (\CLR~input_o\ & ((\inst~1_combout\ $ (\inst~_emulated_q\)) # (!\PRN~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst~1_combout\,
	datab => \inst~_emulated_q\,
	datac => \CLR~input_o\,
	datad => \PRN~input_o\,
	combout => \inst~2_combout\);

ww_Q <= \Q~output_o\;
END structure;


