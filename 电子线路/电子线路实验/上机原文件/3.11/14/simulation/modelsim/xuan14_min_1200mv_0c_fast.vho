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

-- DATE "03/11/2025 17:04:30"

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

ENTITY 	xuan14 IS
    PORT (
	y : OUT std_logic;
	c1 : IN std_logic;
	c0 : IN std_logic;
	c2 : IN std_logic;
	c3 : IN std_logic;
	s1 : IN std_logic;
	s0 : IN std_logic
	);
END xuan14;

-- Design Ports Information
-- y	=>  Location: PIN_M4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- c2	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- s1	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- c1	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- s0	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- c0	=>  Location: PIN_N10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- c3	=>  Location: PIN_L5,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF xuan14 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_y : std_logic;
SIGNAL ww_c1 : std_logic;
SIGNAL ww_c0 : std_logic;
SIGNAL ww_c2 : std_logic;
SIGNAL ww_c3 : std_logic;
SIGNAL ww_s1 : std_logic;
SIGNAL ww_s0 : std_logic;
SIGNAL \y~output_o\ : std_logic;
SIGNAL \c3~input_o\ : std_logic;
SIGNAL \s0~input_o\ : std_logic;
SIGNAL \s1~input_o\ : std_logic;
SIGNAL \c1~input_o\ : std_logic;
SIGNAL \c0~input_o\ : std_logic;
SIGNAL \inst|9~0_combout\ : std_logic;
SIGNAL \c2~input_o\ : std_logic;
SIGNAL \inst|9~1_combout\ : std_logic;

BEGIN

y <= ww_y;
ww_c1 <= c1;
ww_c0 <= c0;
ww_c2 <= c2;
ww_c3 <= c3;
ww_s1 <= s1;
ww_s0 <= s0;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X8_Y0_N2
\y~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|9~1_combout\,
	devoe => ww_devoe,
	o => \y~output_o\);

-- Location: IOIBUF_X14_Y0_N8
\c3~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_c3,
	o => \c3~input_o\);

-- Location: IOIBUF_X8_Y0_N8
\s0~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_s0,
	o => \s0~input_o\);

-- Location: IOIBUF_X10_Y0_N8
\s1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_s1,
	o => \s1~input_o\);

-- Location: IOIBUF_X14_Y31_N1
\c1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_c1,
	o => \c1~input_o\);

-- Location: IOIBUF_X26_Y0_N8
\c0~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_c0,
	o => \c0~input_o\);

-- Location: LCCOMB_X11_Y1_N0
\inst|9~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|9~0_combout\ = (\s0~input_o\ & ((\s1~input_o\) # ((\c1~input_o\)))) # (!\s0~input_o\ & (!\s1~input_o\ & ((\c0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \s0~input_o\,
	datab => \s1~input_o\,
	datac => \c1~input_o\,
	datad => \c0~input_o\,
	combout => \inst|9~0_combout\);

-- Location: IOIBUF_X12_Y0_N8
\c2~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_c2,
	o => \c2~input_o\);

-- Location: LCCOMB_X11_Y1_N2
\inst|9~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|9~1_combout\ = (\inst|9~0_combout\ & ((\c3~input_o\) # ((!\s1~input_o\)))) # (!\inst|9~0_combout\ & (((\c2~input_o\ & \s1~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \c3~input_o\,
	datab => \inst|9~0_combout\,
	datac => \c2~input_o\,
	datad => \s1~input_o\,
	combout => \inst|9~1_combout\);

ww_y <= \y~output_o\;
END structure;


