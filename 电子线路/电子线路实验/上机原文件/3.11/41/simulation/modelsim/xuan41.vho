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

-- DATE "03/11/2025 16:49:05"

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

ENTITY 	xuan41 IS
    PORT (
	pin_name2 : OUT std_logic;
	s0 : IN std_logic;
	s1 : IN std_logic;
	d : IN std_logic;
	pin_name3 : OUT std_logic;
	pin_name4 : OUT std_logic;
	pin_name5 : OUT std_logic
	);
END xuan41;

-- Design Ports Information
-- pin_name2	=>  Location: PIN_M4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pin_name3	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pin_name4	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pin_name5	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- s1	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- s0	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- d	=>  Location: PIN_L11,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF xuan41 IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_pin_name2 : std_logic;
SIGNAL ww_s0 : std_logic;
SIGNAL ww_s1 : std_logic;
SIGNAL ww_d : std_logic;
SIGNAL ww_pin_name3 : std_logic;
SIGNAL ww_pin_name4 : std_logic;
SIGNAL ww_pin_name5 : std_logic;
SIGNAL \pin_name2~output_o\ : std_logic;
SIGNAL \pin_name3~output_o\ : std_logic;
SIGNAL \pin_name4~output_o\ : std_logic;
SIGNAL \pin_name5~output_o\ : std_logic;
SIGNAL \d~input_o\ : std_logic;
SIGNAL \s0~input_o\ : std_logic;
SIGNAL \s1~input_o\ : std_logic;
SIGNAL \inst|33~combout\ : std_logic;
SIGNAL \inst|34~combout\ : std_logic;
SIGNAL \inst|35~combout\ : std_logic;
SIGNAL \inst|36~combout\ : std_logic;
SIGNAL \inst|ALT_INV_36~combout\ : std_logic;
SIGNAL \inst|ALT_INV_35~combout\ : std_logic;
SIGNAL \inst|ALT_INV_34~combout\ : std_logic;
SIGNAL \inst|ALT_INV_33~combout\ : std_logic;

BEGIN

pin_name2 <= ww_pin_name2;
ww_s0 <= s0;
ww_s1 <= s1;
ww_d <= d;
pin_name3 <= ww_pin_name3;
pin_name4 <= ww_pin_name4;
pin_name5 <= ww_pin_name5;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\inst|ALT_INV_36~combout\ <= NOT \inst|36~combout\;
\inst|ALT_INV_35~combout\ <= NOT \inst|35~combout\;
\inst|ALT_INV_34~combout\ <= NOT \inst|34~combout\;
\inst|ALT_INV_33~combout\ <= NOT \inst|33~combout\;

-- Location: IOOBUF_X8_Y0_N2
\pin_name2~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ALT_INV_33~combout\,
	devoe => ww_devoe,
	o => \pin_name2~output_o\);

-- Location: IOOBUF_X12_Y0_N9
\pin_name3~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ALT_INV_34~combout\,
	devoe => ww_devoe,
	o => \pin_name3~output_o\);

-- Location: IOOBUF_X10_Y0_N9
\pin_name4~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ALT_INV_35~combout\,
	devoe => ww_devoe,
	o => \pin_name4~output_o\);

-- Location: IOOBUF_X14_Y0_N2
\pin_name5~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ALT_INV_36~combout\,
	devoe => ww_devoe,
	o => \pin_name5~output_o\);

-- Location: IOIBUF_X31_Y0_N1
\d~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_d,
	o => \d~input_o\);

-- Location: IOIBUF_X12_Y0_N1
\s0~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_s0,
	o => \s0~input_o\);

-- Location: IOIBUF_X8_Y0_N8
\s1~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_s1,
	o => \s1~input_o\);

-- Location: LCCOMB_X11_Y1_N8
\inst|33\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|33~combout\ = (!\d~input_o\ & (!\s0~input_o\ & !\s1~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \d~input_o\,
	datab => \s0~input_o\,
	datac => \s1~input_o\,
	combout => \inst|33~combout\);

-- Location: LCCOMB_X11_Y1_N2
\inst|34\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|34~combout\ = (!\d~input_o\ & (\s0~input_o\ & !\s1~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \d~input_o\,
	datab => \s0~input_o\,
	datac => \s1~input_o\,
	combout => \inst|34~combout\);

-- Location: LCCOMB_X11_Y1_N4
\inst|35\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|35~combout\ = (!\d~input_o\ & (!\s0~input_o\ & \s1~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \d~input_o\,
	datab => \s0~input_o\,
	datac => \s1~input_o\,
	combout => \inst|35~combout\);

-- Location: LCCOMB_X11_Y1_N22
\inst|36\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst|36~combout\ = (!\d~input_o\ & (\s0~input_o\ & \s1~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \d~input_o\,
	datab => \s0~input_o\,
	datac => \s1~input_o\,
	combout => \inst|36~combout\);

ww_pin_name2 <= \pin_name2~output_o\;

ww_pin_name3 <= \pin_name3~output_o\;

ww_pin_name4 <= \pin_name4~output_o\;

ww_pin_name5 <= \pin_name5~output_o\;
END structure;


