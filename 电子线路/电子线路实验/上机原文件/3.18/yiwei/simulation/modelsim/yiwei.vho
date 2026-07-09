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

-- DATE "03/25/2025 16:42:22"

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

ENTITY 	yiwei IS
    PORT (
	a0 : OUT std_logic;
	CLR : IN std_logic;
	CLK : IN std_logic;
	PRN : IN std_logic;
	a1 : OUT std_logic;
	a2 : OUT std_logic;
	a3 : OUT std_logic;
	a4 : OUT std_logic;
	a5 : OUT std_logic;
	a6 : OUT std_logic;
	a7 : OUT std_logic;
	a8 : OUT std_logic;
	a9 : OUT std_logic
	);
END yiwei;

-- Design Ports Information
-- a0	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a1	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a2	=>  Location: PIN_N10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a3	=>  Location: PIN_L7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a4	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a5	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a6	=>  Location: PIN_L5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a7	=>  Location: PIN_N9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a8	=>  Location: PIN_L9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a9	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PRN	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLR	=>  Location: PIN_J6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLK	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF yiwei IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_a0 : std_logic;
SIGNAL ww_CLR : std_logic;
SIGNAL ww_CLK : std_logic;
SIGNAL ww_PRN : std_logic;
SIGNAL ww_a1 : std_logic;
SIGNAL ww_a2 : std_logic;
SIGNAL ww_a3 : std_logic;
SIGNAL ww_a4 : std_logic;
SIGNAL ww_a5 : std_logic;
SIGNAL ww_a6 : std_logic;
SIGNAL ww_a7 : std_logic;
SIGNAL ww_a8 : std_logic;
SIGNAL ww_a9 : std_logic;
SIGNAL \CLR~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \CLK~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \a0~output_o\ : std_logic;
SIGNAL \a1~output_o\ : std_logic;
SIGNAL \a2~output_o\ : std_logic;
SIGNAL \a3~output_o\ : std_logic;
SIGNAL \a4~output_o\ : std_logic;
SIGNAL \a5~output_o\ : std_logic;
SIGNAL \a6~output_o\ : std_logic;
SIGNAL \a7~output_o\ : std_logic;
SIGNAL \a8~output_o\ : std_logic;
SIGNAL \a9~output_o\ : std_logic;
SIGNAL \CLR~input_o\ : std_logic;
SIGNAL \PRN~input_o\ : std_logic;
SIGNAL \inst~1_combout\ : std_logic;
SIGNAL \CLK~input_o\ : std_logic;
SIGNAL \CLK~inputclkctrl_outclk\ : std_logic;
SIGNAL \CLR~inputclkctrl_outclk\ : std_logic;
SIGNAL \inst4~q\ : std_logic;
SIGNAL \inst1~feeder_combout\ : std_logic;
SIGNAL \inst1~q\ : std_logic;
SIGNAL \inst2~feeder_combout\ : std_logic;
SIGNAL \inst2~q\ : std_logic;
SIGNAL \inst7~feeder_combout\ : std_logic;
SIGNAL \inst7~q\ : std_logic;
SIGNAL \inst3~feeder_combout\ : std_logic;
SIGNAL \inst3~q\ : std_logic;
SIGNAL \inst5~feeder_combout\ : std_logic;
SIGNAL \inst5~q\ : std_logic;
SIGNAL \inst6~feeder_combout\ : std_logic;
SIGNAL \inst6~q\ : std_logic;
SIGNAL \inst8~feeder_combout\ : std_logic;
SIGNAL \inst8~q\ : std_logic;
SIGNAL \inst9~feeder_combout\ : std_logic;
SIGNAL \inst9~q\ : std_logic;
SIGNAL \inst~3_combout\ : std_logic;
SIGNAL \inst~0_combout\ : std_logic;
SIGNAL \inst~_emulated_q\ : std_logic;
SIGNAL \inst~2_combout\ : std_logic;
SIGNAL \ALT_INV_inst~0_combout\ : std_logic;

BEGIN

a0 <= ww_a0;
ww_CLR <= CLR;
ww_CLK <= CLK;
ww_PRN <= PRN;
a1 <= ww_a1;
a2 <= ww_a2;
a3 <= ww_a3;
a4 <= ww_a4;
a5 <= ww_a5;
a6 <= ww_a6;
a7 <= ww_a7;
a8 <= ww_a8;
a9 <= ww_a9;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\CLR~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLR~input_o\);

\CLK~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLK~input_o\);
\ALT_INV_inst~0_combout\ <= NOT \inst~0_combout\;

-- Location: IOOBUF_X22_Y0_N2
\a0~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst~2_combout\,
	devoe => ww_devoe,
	o => \a0~output_o\);

-- Location: IOOBUF_X22_Y0_N9
\a1~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst4~q\,
	devoe => ww_devoe,
	o => \a1~output_o\);

-- Location: IOOBUF_X26_Y0_N9
\a2~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst1~q\,
	devoe => ww_devoe,
	o => \a2~output_o\);

-- Location: IOOBUF_X14_Y0_N2
\a3~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst2~q\,
	devoe => ww_devoe,
	o => \a3~output_o\);

-- Location: IOOBUF_X20_Y0_N9
\a4~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst7~q\,
	devoe => ww_devoe,
	o => \a4~output_o\);

-- Location: IOOBUF_X26_Y0_N2
\a5~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst3~q\,
	devoe => ww_devoe,
	o => \a5~output_o\);

-- Location: IOOBUF_X14_Y0_N9
\a6~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst5~q\,
	devoe => ww_devoe,
	o => \a6~output_o\);

-- Location: IOOBUF_X20_Y0_N2
\a7~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst6~q\,
	devoe => ww_devoe,
	o => \a7~output_o\);

-- Location: IOOBUF_X24_Y0_N9
\a8~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst8~q\,
	devoe => ww_devoe,
	o => \a8~output_o\);

-- Location: IOOBUF_X12_Y0_N9
\a9~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst9~q\,
	devoe => ww_devoe,
	o => \a9~output_o\);

-- Location: IOIBUF_X16_Y0_N22
\CLR~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLR,
	o => \CLR~input_o\);

-- Location: IOIBUF_X24_Y0_N1
\PRN~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PRN,
	o => \PRN~input_o\);

-- Location: LCCOMB_X20_Y1_N2
\inst~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~1_combout\ = (\CLR~input_o\ & ((\inst~1_combout\) # (!\PRN~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PRN~input_o\,
	datac => \CLR~input_o\,
	datad => \inst~1_combout\,
	combout => \inst~1_combout\);

-- Location: IOIBUF_X16_Y0_N15
\CLK~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLK,
	o => \CLK~input_o\);

-- Location: CLKCTRL_G17
\CLK~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLK~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLK~inputclkctrl_outclk\);

-- Location: CLKCTRL_G19
\CLR~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLR~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLR~inputclkctrl_outclk\);

-- Location: FF_X20_Y1_N9
inst4 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	asdata => \inst~2_combout\,
	clrn => \CLR~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst4~q\);

-- Location: LCCOMB_X20_Y1_N30
\inst1~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst1~feeder_combout\ = \inst4~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst4~q\,
	combout => \inst1~feeder_combout\);

-- Location: FF_X20_Y1_N31
inst1 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst1~feeder_combout\,
	clrn => \CLR~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1~q\);

-- Location: LCCOMB_X20_Y1_N24
\inst2~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst2~feeder_combout\ = \inst1~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst1~q\,
	combout => \inst2~feeder_combout\);

-- Location: FF_X20_Y1_N25
inst2 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst2~feeder_combout\,
	clrn => \CLR~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2~q\);

-- Location: LCCOMB_X20_Y1_N10
\inst7~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst7~feeder_combout\ = \inst2~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst2~q\,
	combout => \inst7~feeder_combout\);

-- Location: FF_X20_Y1_N11
inst7 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst7~feeder_combout\,
	clrn => \CLR~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7~q\);

-- Location: LCCOMB_X20_Y1_N20
\inst3~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst3~feeder_combout\ = \inst7~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst7~q\,
	combout => \inst3~feeder_combout\);

-- Location: FF_X20_Y1_N21
inst3 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst3~feeder_combout\,
	clrn => \CLR~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst3~q\);

-- Location: LCCOMB_X20_Y1_N18
\inst5~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst5~feeder_combout\ = \inst3~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst3~q\,
	combout => \inst5~feeder_combout\);

-- Location: FF_X20_Y1_N19
inst5 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst5~feeder_combout\,
	clrn => \CLR~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst5~q\);

-- Location: LCCOMB_X20_Y1_N28
\inst6~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst6~feeder_combout\ = \inst5~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst5~q\,
	combout => \inst6~feeder_combout\);

-- Location: FF_X20_Y1_N29
inst6 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst6~feeder_combout\,
	clrn => \CLR~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst6~q\);

-- Location: LCCOMB_X20_Y1_N6
\inst8~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst8~feeder_combout\ = \inst6~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst6~q\,
	combout => \inst8~feeder_combout\);

-- Location: FF_X20_Y1_N7
inst8 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst8~feeder_combout\,
	clrn => \CLR~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst8~q\);

-- Location: LCCOMB_X20_Y1_N12
\inst9~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst9~feeder_combout\ = \inst8~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst8~q\,
	combout => \inst9~feeder_combout\);

-- Location: FF_X20_Y1_N13
inst9 : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst9~feeder_combout\,
	clrn => \CLR~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst9~q\);

-- Location: LCCOMB_X20_Y1_N16
\inst~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~3_combout\ = \inst~1_combout\ $ (\inst9~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst~1_combout\,
	datad => \inst9~q\,
	combout => \inst~3_combout\);

-- Location: LCCOMB_X20_Y1_N8
\inst~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~0_combout\ = (!\CLR~input_o\) # (!\PRN~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PRN~input_o\,
	datad => \CLR~input_o\,
	combout => \inst~0_combout\);

-- Location: FF_X20_Y1_N17
\inst~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLK~inputclkctrl_outclk\,
	d => \inst~3_combout\,
	clrn => \ALT_INV_inst~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst~_emulated_q\);

-- Location: LCCOMB_X20_Y1_N26
\inst~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \inst~2_combout\ = (\CLR~input_o\ & ((\inst~1_combout\ $ (\inst~_emulated_q\)) # (!\PRN~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010101010001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \CLR~input_o\,
	datab => \inst~1_combout\,
	datac => \PRN~input_o\,
	datad => \inst~_emulated_q\,
	combout => \inst~2_combout\);

ww_a0 <= \a0~output_o\;

ww_a1 <= \a1~output_o\;

ww_a2 <= \a2~output_o\;

ww_a3 <= \a3~output_o\;

ww_a4 <= \a4~output_o\;

ww_a5 <= \a5~output_o\;

ww_a6 <= \a6~output_o\;

ww_a7 <= \a7~output_o\;

ww_a8 <= \a8~output_o\;

ww_a9 <= \a9~output_o\;
END structure;


