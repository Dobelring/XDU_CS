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

-- DATE "04/08/2025 17:40:38"

-- 
-- Device: Altera EP4CE10E22C8 Package TQFP144
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	t IS
    PORT (
	b : OUT std_logic;
	cp : IN std_logic;
	h : IN std_logic;
	hon : IN std_logic;
	l : IN std_logic;
	lon : IN std_logic;
	clear : IN std_logic;
	c : OUT std_logic;
	d : OUT std_logic;
	e : OUT std_logic;
	f : OUT std_logic;
	g : OUT std_logic;
	a : OUT std_logic;
	y0 : OUT std_logic;
	y1 : OUT std_logic;
	y2 : OUT std_logic;
	y3 : OUT std_logic;
	y4 : OUT std_logic;
	y5 : OUT std_logic;
	pin_name1 : OUT std_logic
	);
END t;

-- Design Ports Information
-- b	=>  Location: PIN_2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- c	=>  Location: PIN_3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- d	=>  Location: PIN_7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- e	=>  Location: PIN_10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- f	=>  Location: PIN_11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- g	=>  Location: PIN_28,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- a	=>  Location: PIN_1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y0	=>  Location: PIN_31,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y1	=>  Location: PIN_32,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y2	=>  Location: PIN_33,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y3	=>  Location: PIN_34,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y4	=>  Location: PIN_38,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- y5	=>  Location: PIN_39,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pin_name1	=>  Location: PIN_138,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cp	=>  Location: PIN_132,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clear	=>  Location: PIN_129,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- h	=>  Location: PIN_133,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- l	=>  Location: PIN_136,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- lon	=>  Location: PIN_137,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hon	=>  Location: PIN_135,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF t IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_b : std_logic;
SIGNAL ww_cp : std_logic;
SIGNAL ww_h : std_logic;
SIGNAL ww_hon : std_logic;
SIGNAL ww_l : std_logic;
SIGNAL ww_lon : std_logic;
SIGNAL ww_clear : std_logic;
SIGNAL ww_c : std_logic;
SIGNAL ww_d : std_logic;
SIGNAL ww_e : std_logic;
SIGNAL ww_f : std_logic;
SIGNAL ww_g : std_logic;
SIGNAL ww_a : std_logic;
SIGNAL ww_y0 : std_logic;
SIGNAL ww_y1 : std_logic;
SIGNAL ww_y2 : std_logic;
SIGNAL ww_y3 : std_logic;
SIGNAL ww_y4 : std_logic;
SIGNAL ww_y5 : std_logic;
SIGNAL ww_pin_name1 : std_logic;
SIGNAL \inst33~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \b~output_o\ : std_logic;
SIGNAL \c~output_o\ : std_logic;
SIGNAL \d~output_o\ : std_logic;
SIGNAL \e~output_o\ : std_logic;
SIGNAL \f~output_o\ : std_logic;
SIGNAL \g~output_o\ : std_logic;
SIGNAL \a~output_o\ : std_logic;
SIGNAL \y0~output_o\ : std_logic;
SIGNAL \y1~output_o\ : std_logic;
SIGNAL \y2~output_o\ : std_logic;
SIGNAL \y3~output_o\ : std_logic;
SIGNAL \y4~output_o\ : std_logic;
SIGNAL \y5~output_o\ : std_logic;
SIGNAL \pin_name1~output_o\ : std_logic;
SIGNAL \cp~input_o\ : std_logic;
SIGNAL \inst56567|6~0_combout\ : std_logic;
SIGNAL \inst56567|6~q\ : std_logic;
SIGNAL \inst56567|11~combout\ : std_logic;
SIGNAL \inst56567|7~q\ : std_logic;
SIGNAL \inst56567|12~0_combout\ : std_logic;
SIGNAL \inst56567|8~q\ : std_logic;
SIGNAL \lon~input_o\ : std_logic;
SIGNAL \hon~input_o\ : std_logic;
SIGNAL \h~input_o\ : std_logic;
SIGNAL \l~input_o\ : std_logic;
SIGNAL \inst33~combout\ : std_logic;
SIGNAL \inst33~clkctrl_outclk\ : std_logic;
SIGNAL \inst|6~0_combout\ : std_logic;
SIGNAL \clear~input_o\ : std_logic;
SIGNAL \inst|6~q\ : std_logic;
SIGNAL \inst|7~0_combout\ : std_logic;
SIGNAL \inst|7~q\ : std_logic;
SIGNAL \inst|8~0_combout\ : std_logic;
SIGNAL \inst|8~q\ : std_logic;
SIGNAL \inst|13~combout\ : std_logic;
SIGNAL \inst|9~q\ : std_logic;
SIGNAL \inst1|10~combout\ : std_logic;
SIGNAL \inst1|6~q\ : std_logic;
SIGNAL \inst1|47~0_combout\ : std_logic;
SIGNAL \inst1|11~combout\ : std_logic;
SIGNAL \inst1|7~q\ : std_logic;
SIGNAL \inst1|12~combout\ : std_logic;
SIGNAL \inst1|8~q\ : std_logic;
SIGNAL \inst27~0_combout\ : std_logic;
SIGNAL \inst2|6~0_combout\ : std_logic;
SIGNAL \inst2|6~q\ : std_logic;
SIGNAL \inst2|7~0_combout\ : std_logic;
SIGNAL \inst2|7~q\ : std_logic;
SIGNAL \inst2|8~0_combout\ : std_logic;
SIGNAL \inst2|8~q\ : std_logic;
SIGNAL \inst2|46~0_combout\ : std_logic;
SIGNAL \inst2|13~0_combout\ : std_logic;
SIGNAL \inst2|9~q\ : std_logic;
SIGNAL \inst29~1_combout\ : std_logic;
SIGNAL \inst3|47~0_combout\ : std_logic;
SIGNAL \inst3|10~combout\ : std_logic;
SIGNAL \inst3|6~q\ : std_logic;
SIGNAL \inst3|11~combout\ : std_logic;
SIGNAL \inst3|7~q\ : std_logic;
SIGNAL \inst3|12~combout\ : std_logic;
SIGNAL \inst3|8~q\ : std_logic;
SIGNAL \inst29~0_combout\ : std_logic;
SIGNAL \inst6|6~0_combout\ : std_logic;
SIGNAL \inst6|6~q\ : std_logic;
SIGNAL \inst9~1_combout\ : std_logic;
SIGNAL \inst9~2_combout\ : std_logic;
SIGNAL \inst6|11~combout\ : std_logic;
SIGNAL \inst6|7~q\ : std_logic;
SIGNAL \inst9~0_combout\ : std_logic;
SIGNAL \inst7|11~combout\ : std_logic;
SIGNAL \inst7|7~q\ : std_logic;
SIGNAL \inst6|12~combout\ : std_logic;
SIGNAL \inst6|8~q\ : std_logic;
SIGNAL \inst6|9~0_combout\ : std_logic;
SIGNAL \inst6|9~1_combout\ : std_logic;
SIGNAL \inst6|9~q\ : std_logic;
SIGNAL \inst7|10~combout\ : std_logic;
SIGNAL \inst7|6~q\ : std_logic;
SIGNAL \inst7|50~0_combout\ : std_logic;
SIGNAL \inst7|12~combout\ : std_logic;
SIGNAL \inst7|8~q\ : std_logic;
SIGNAL \inst7|13~0_combout\ : std_logic;
SIGNAL \inst7|13~1_combout\ : std_logic;
SIGNAL \inst7|13~2_combout\ : std_logic;
SIGNAL \inst7|9~q\ : std_logic;
SIGNAL \inst16|sub|81~1_combout\ : std_logic;
SIGNAL \inst16|sub|81~0_combout\ : std_logic;
SIGNAL \inst16|sub|81~2_combout\ : std_logic;
SIGNAL \inst15|sub|81~2_combout\ : std_logic;
SIGNAL \inst15|sub|81~3_combout\ : std_logic;
SIGNAL \inst15|sub|81~4_combout\ : std_logic;
SIGNAL \inst15|sub|81~5_combout\ : std_logic;
SIGNAL \inst14|sub|81~3_combout\ : std_logic;
SIGNAL \inst14|sub|81~4_combout\ : std_logic;
SIGNAL \inst14|sub|81~2_combout\ : std_logic;
SIGNAL \inst14|sub|81~5_combout\ : std_logic;
SIGNAL \inst13|sub|81~3_combout\ : std_logic;
SIGNAL \inst13|sub|81~4_combout\ : std_logic;
SIGNAL \inst13|sub|81~2_combout\ : std_logic;
SIGNAL \inst13|sub|81~5_combout\ : std_logic;
SIGNAL \inst17|68~0_combout\ : std_logic;
SIGNAL \inst17|70~combout\ : std_logic;
SIGNAL \inst17|67~0_combout\ : std_logic;
SIGNAL \inst17|71~combout\ : std_logic;
SIGNAL \inst17|66~0_combout\ : std_logic;
SIGNAL \inst17|72~combout\ : std_logic;
SIGNAL \inst17|69~0_combout\ : std_logic;
SIGNAL \inst20|15~0_combout\ : std_logic;
SIGNAL \inst20|15~1_combout\ : std_logic;
SIGNAL \inst20|15~2_combout\ : std_logic;
SIGNAL \inst20|15~3_combout\ : std_logic;
SIGNAL \inst20|15~4_combout\ : std_logic;
SIGNAL \inst20|15~5_combout\ : std_logic;
SIGNAL \inst17|ALT_INV_69~0_combout\ : std_logic;
SIGNAL \inst17|ALT_INV_72~combout\ : std_logic;
SIGNAL \inst17|ALT_INV_66~0_combout\ : std_logic;
SIGNAL \inst17|ALT_INV_71~combout\ : std_logic;
SIGNAL \inst17|ALT_INV_67~0_combout\ : std_logic;
SIGNAL \inst17|ALT_INV_70~combout\ : std_logic;
SIGNAL \inst17|ALT_INV_68~0_combout\ : std_logic;

BEGIN

b <= ww_b;
ww_cp <= cp;
ww_h <= h;
ww_hon <= hon;
ww_l <= l;
ww_lon <= lon;
ww_clear <= clear;
c <= ww_c;
d <= ww_d;
e <= ww_e;
f <= ww_f;
g <= ww_g;
a <= ww_a;
y0 <= ww_y0;
y1 <= ww_y1;
y2 <= ww_y2;
y3 <= ww_y3;
y4 <= ww_y4;
y5 <= ww_y5;
pin_name1 <= ww_pin_name1;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\inst33~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \inst33~combout\);
\inst17|ALT_INV_69~0_combout\ <= NOT \inst17|69~0_combout\;
\inst17|ALT_INV_72~combout\ <= NOT \inst17|72~combout\;
\inst17|ALT_INV_66~0_combout\ <= NOT \inst17|66~0_combout\;
\inst17|ALT_INV_71~combout\ <= NOT \inst17|71~combout\;
\inst17|ALT_INV_67~0_combout\ <= NOT \inst17|67~0_combout\;
\inst17|ALT_INV_70~combout\ <= NOT \inst17|70~combout\;
\inst17|ALT_INV_68~0_combout\ <= NOT \inst17|68~0_combout\;

-- Location: IOOBUF_X0_Y23_N9
\b~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst17|ALT_INV_68~0_combout\,
	devoe => ww_devoe,
	o => \b~output_o\);

-- Location: IOOBUF_X0_Y23_N16
\c~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst17|ALT_INV_70~combout\,
	devoe => ww_devoe,
	o => \c~output_o\);

-- Location: IOOBUF_X0_Y21_N9
\d~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst17|ALT_INV_67~0_combout\,
	devoe => ww_devoe,
	o => \d~output_o\);

-- Location: IOOBUF_X0_Y18_N16
\e~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst17|ALT_INV_71~combout\,
	devoe => ww_devoe,
	o => \e~output_o\);

-- Location: IOOBUF_X0_Y18_N23
\f~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst17|ALT_INV_66~0_combout\,
	devoe => ww_devoe,
	o => \f~output_o\);

-- Location: IOOBUF_X0_Y9_N9
\g~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst17|ALT_INV_72~combout\,
	devoe => ww_devoe,
	o => \g~output_o\);

-- Location: IOOBUF_X0_Y23_N2
\a~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst17|ALT_INV_69~0_combout\,
	devoe => ww_devoe,
	o => \a~output_o\);

-- Location: IOOBUF_X0_Y7_N2
\y0~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst20|15~0_combout\,
	devoe => ww_devoe,
	o => \y0~output_o\);

-- Location: IOOBUF_X0_Y6_N16
\y1~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst20|15~1_combout\,
	devoe => ww_devoe,
	o => \y1~output_o\);

-- Location: IOOBUF_X0_Y6_N23
\y2~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst20|15~2_combout\,
	devoe => ww_devoe,
	o => \y2~output_o\);

-- Location: IOOBUF_X0_Y5_N16
\y3~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst20|15~3_combout\,
	devoe => ww_devoe,
	o => \y3~output_o\);

-- Location: IOOBUF_X1_Y0_N23
\y4~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst20|15~4_combout\,
	devoe => ww_devoe,
	o => \y4~output_o\);

-- Location: IOOBUF_X1_Y0_N16
\y5~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst20|15~5_combout\,
	devoe => ww_devoe,
	o => \y5~output_o\);

-- Location: IOOBUF_X7_Y24_N9
\pin_name1~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst9~0_combout\,
	devoe => ww_devoe,
	o => \pin_name1~output_o\);

-- Location: IOIBUF_X13_Y24_N15
\cp~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_cp,
	o => \cp~input_o\);

-- Location: LCCOMB_X14_Y21_N12
\inst56567|6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst56567|6~0_combout\ = !\inst56567|6~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst56567|6~q\,
	combout => \inst56567|6~0_combout\);

-- Location: FF_X14_Y21_N13
\inst56567|6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \cp~input_o\,
	d => \inst56567|6~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst56567|6~q\);

-- Location: LCCOMB_X14_Y21_N18
\inst56567|11\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst56567|11~combout\ = (\inst56567|7~q\ & ((!\inst56567|6~q\))) # (!\inst56567|7~q\ & (!\inst56567|8~q\ & \inst56567|6~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst56567|8~q\,
	datac => \inst56567|7~q\,
	datad => \inst56567|6~q\,
	combout => \inst56567|11~combout\);

-- Location: FF_X14_Y21_N19
\inst56567|7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \cp~input_o\,
	d => \inst56567|11~combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst56567|7~q\);

-- Location: LCCOMB_X14_Y21_N16
\inst56567|12~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst56567|12~0_combout\ = (\inst56567|8~q\ & ((!\inst56567|6~q\))) # (!\inst56567|8~q\ & (\inst56567|7~q\ & \inst56567|6~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst56567|7~q\,
	datac => \inst56567|8~q\,
	datad => \inst56567|6~q\,
	combout => \inst56567|12~0_combout\);

-- Location: FF_X14_Y21_N17
\inst56567|8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \cp~input_o\,
	d => \inst56567|12~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst56567|8~q\);

-- Location: IOIBUF_X7_Y24_N1
\lon~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_lon,
	o => \lon~input_o\);

-- Location: IOIBUF_X11_Y24_N15
\hon~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_hon,
	o => \hon~input_o\);

-- Location: IOIBUF_X13_Y24_N22
\h~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_h,
	o => \h~input_o\);

-- Location: IOIBUF_X9_Y24_N8
\l~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_l,
	o => \l~input_o\);

-- Location: LCCOMB_X5_Y11_N8
inst33 : cycloneive_lcell_comb
-- Equation(s):
-- \inst33~combout\ = LCELL((\lon~input_o\ & ((\l~input_o\) # ((\hon~input_o\ & \h~input_o\)))) # (!\lon~input_o\ & (\hon~input_o\ & (\h~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \lon~input_o\,
	datab => \hon~input_o\,
	datac => \h~input_o\,
	datad => \l~input_o\,
	combout => \inst33~combout\);

-- Location: CLKCTRL_G1
\inst33~clkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \inst33~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \inst33~clkctrl_outclk\);

-- Location: LCCOMB_X30_Y21_N10
\inst|6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|6~0_combout\ = !\inst|6~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \inst|6~q\,
	combout => \inst|6~0_combout\);

-- Location: IOIBUF_X16_Y24_N22
\clear~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clear,
	o => \clear~input_o\);

-- Location: FF_X29_Y21_N15
\inst|6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	asdata => \inst|6~0_combout\,
	clrn => \clear~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|6~q\);

-- Location: LCCOMB_X30_Y21_N20
\inst|7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|7~0_combout\ = \inst|7~q\ $ (((!\inst|9~q\ & \inst|6~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|9~q\,
	datac => \inst|7~q\,
	datad => \inst|6~q\,
	combout => \inst|7~0_combout\);

-- Location: FF_X30_Y21_N21
\inst|7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst|7~0_combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|7~q\);

-- Location: LCCOMB_X30_Y21_N8
\inst|8~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|8~0_combout\ = \inst|8~q\ $ (((\inst|7~q\ & \inst|6~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|7~q\,
	datac => \inst|8~q\,
	datad => \inst|6~q\,
	combout => \inst|8~0_combout\);

-- Location: FF_X30_Y21_N9
\inst|8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst|8~0_combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|8~q\);

-- Location: LCCOMB_X30_Y21_N30
\inst|13\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst|13~combout\ = (\inst|6~q\ & (\inst|7~q\ & ((\inst|8~q\)))) # (!\inst|6~q\ & (((\inst|9~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|6~q\,
	datab => \inst|7~q\,
	datac => \inst|9~q\,
	datad => \inst|8~q\,
	combout => \inst|13~combout\);

-- Location: FF_X29_Y21_N3
\inst|9\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	asdata => \inst|13~combout\,
	clrn => \clear~input_o\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|9~q\);

-- Location: LCCOMB_X29_Y21_N8
\inst1|10\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|10~combout\ = \inst1|6~q\ $ (((\inst|9~q\ & \inst|6~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst|9~q\,
	datac => \inst1|6~q\,
	datad => \inst|6~q\,
	combout => \inst1|10~combout\);

-- Location: FF_X29_Y21_N9
\inst1|6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst1|10~combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|6~q\);

-- Location: LCCOMB_X30_Y21_N28
\inst1|47~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|47~0_combout\ = (\inst|9~q\ & \inst|6~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst|9~q\,
	datad => \inst|6~q\,
	combout => \inst1|47~0_combout\);

-- Location: LCCOMB_X30_Y21_N18
\inst1|11\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|11~combout\ = (!\inst27~0_combout\ & (\inst1|7~q\ $ (((\inst1|6~q\ & \inst1|47~0_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst27~0_combout\,
	datab => \inst1|6~q\,
	datac => \inst1|7~q\,
	datad => \inst1|47~0_combout\,
	combout => \inst1|11~combout\);

-- Location: FF_X30_Y21_N19
\inst1|7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst1|11~combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|7~q\);

-- Location: LCCOMB_X29_Y21_N18
\inst1|12\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1|12~combout\ = (\inst1|6~q\ & ((\inst1|8~q\ & ((!\inst1|47~0_combout\))) # (!\inst1|8~q\ & (\inst1|7~q\ & \inst1|47~0_combout\)))) # (!\inst1|6~q\ & (((\inst1|8~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|6~q\,
	datab => \inst1|7~q\,
	datac => \inst1|8~q\,
	datad => \inst1|47~0_combout\,
	combout => \inst1|12~combout\);

-- Location: FF_X29_Y21_N19
\inst1|8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst1|12~combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1|8~q\);

-- Location: LCCOMB_X29_Y21_N30
\inst27~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst27~0_combout\ = (\inst|6~q\ & (\inst1|8~q\ & (\inst1|6~q\ & \inst|9~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|6~q\,
	datab => \inst1|8~q\,
	datac => \inst1|6~q\,
	datad => \inst|9~q\,
	combout => \inst27~0_combout\);

-- Location: LCCOMB_X28_Y21_N6
\inst2|6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst2|6~0_combout\ = \inst2|6~q\ $ (\inst27~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst2|6~q\,
	datad => \inst27~0_combout\,
	combout => \inst2|6~0_combout\);

-- Location: FF_X28_Y21_N7
\inst2|6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst2|6~0_combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|6~q\);

-- Location: LCCOMB_X28_Y21_N22
\inst2|7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst2|7~0_combout\ = \inst2|7~q\ $ (((!\inst2|9~q\ & (\inst2|6~q\ & \inst27~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011010011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|9~q\,
	datab => \inst2|6~q\,
	datac => \inst2|7~q\,
	datad => \inst27~0_combout\,
	combout => \inst2|7~0_combout\);

-- Location: FF_X28_Y21_N23
\inst2|7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst2|7~0_combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|7~q\);

-- Location: LCCOMB_X28_Y21_N18
\inst2|8~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst2|8~0_combout\ = \inst2|8~q\ $ (((\inst2|7~q\ & (\inst2|6~q\ & \inst27~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|7~q\,
	datab => \inst2|6~q\,
	datac => \inst2|8~q\,
	datad => \inst27~0_combout\,
	combout => \inst2|8~0_combout\);

-- Location: FF_X28_Y21_N19
\inst2|8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst2|8~0_combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|8~q\);

-- Location: LCCOMB_X28_Y21_N12
\inst2|46~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst2|46~0_combout\ = (\inst2|7~q\ & (\inst2|6~q\ & (\inst2|8~q\ & \inst27~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|7~q\,
	datab => \inst2|6~q\,
	datac => \inst2|8~q\,
	datad => \inst27~0_combout\,
	combout => \inst2|46~0_combout\);

-- Location: LCCOMB_X28_Y21_N26
\inst2|13~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst2|13~0_combout\ = (\inst2|46~0_combout\) # ((\inst2|9~q\ & ((!\inst2|6~q\) # (!\inst27~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst27~0_combout\,
	datab => \inst2|6~q\,
	datac => \inst2|9~q\,
	datad => \inst2|46~0_combout\,
	combout => \inst2|13~0_combout\);

-- Location: FF_X28_Y21_N27
\inst2|9\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst2|13~0_combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2|9~q\);

-- Location: LCCOMB_X29_Y21_N10
\inst29~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst29~1_combout\ = (\inst2|9~q\ & (\inst2|6~q\ & (\inst27~0_combout\ & \inst29~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|9~q\,
	datab => \inst2|6~q\,
	datac => \inst27~0_combout\,
	datad => \inst29~0_combout\,
	combout => \inst29~1_combout\);

-- Location: LCCOMB_X29_Y21_N2
\inst3|47~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst3|47~0_combout\ = (\inst2|9~q\ & (\inst2|6~q\ & \inst27~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|9~q\,
	datab => \inst2|6~q\,
	datad => \inst27~0_combout\,
	combout => \inst3|47~0_combout\);

-- Location: LCCOMB_X29_Y21_N4
\inst3|10\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst3|10~combout\ = (!\inst29~1_combout\ & (\inst3|6~q\ $ (\inst3|47~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst29~1_combout\,
	datac => \inst3|6~q\,
	datad => \inst3|47~0_combout\,
	combout => \inst3|10~combout\);

-- Location: FF_X29_Y21_N5
\inst3|6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst3|10~combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst3|6~q\);

-- Location: LCCOMB_X28_Y21_N8
\inst3|11\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst3|11~combout\ = (!\inst29~1_combout\ & (\inst3|7~q\ $ (((\inst3|47~0_combout\ & \inst3|6~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst3|47~0_combout\,
	datab => \inst29~1_combout\,
	datac => \inst3|7~q\,
	datad => \inst3|6~q\,
	combout => \inst3|11~combout\);

-- Location: FF_X28_Y21_N9
\inst3|7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst3|11~combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst3|7~q\);

-- Location: LCCOMB_X29_Y21_N20
\inst3|12\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst3|12~combout\ = (\inst3|6~q\ & ((\inst3|8~q\ & ((!\inst3|47~0_combout\))) # (!\inst3|8~q\ & (\inst3|7~q\ & \inst3|47~0_combout\)))) # (!\inst3|6~q\ & (((\inst3|8~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst3|7~q\,
	datab => \inst3|6~q\,
	datac => \inst3|8~q\,
	datad => \inst3|47~0_combout\,
	combout => \inst3|12~combout\);

-- Location: FF_X29_Y21_N21
\inst3|8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst3|12~combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst3|8~q\);

-- Location: LCCOMB_X29_Y21_N12
\inst29~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst29~0_combout\ = (\inst3|6~q\ & \inst3|8~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst3|6~q\,
	datad => \inst3|8~q\,
	combout => \inst29~0_combout\);

-- Location: LCCOMB_X28_Y21_N16
\inst6|6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst6|6~0_combout\ = \inst29~1_combout\ $ (\inst6|6~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst29~1_combout\,
	datac => \inst6|6~q\,
	combout => \inst6|6~0_combout\);

-- Location: FF_X28_Y21_N17
\inst6|6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst6|6~0_combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst6|6~q\);

-- Location: LCCOMB_X28_Y21_N24
\inst9~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst9~1_combout\ = (\inst2|9~q\ & \inst2|6~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst2|9~q\,
	datad => \inst2|6~q\,
	combout => \inst9~1_combout\);

-- Location: LCCOMB_X29_Y21_N26
\inst9~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst9~2_combout\ = (\inst29~0_combout\ & (\inst6|6~q\ & (\inst27~0_combout\ & \inst9~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst29~0_combout\,
	datab => \inst6|6~q\,
	datac => \inst27~0_combout\,
	datad => \inst9~1_combout\,
	combout => \inst9~2_combout\);

-- Location: LCCOMB_X28_Y21_N4
\inst6|11\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst6|11~combout\ = (!\inst9~0_combout\ & (\inst6|7~q\ $ (((!\inst6|9~q\ & \inst9~2_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst6|9~q\,
	datab => \inst9~2_combout\,
	datac => \inst6|7~q\,
	datad => \inst9~0_combout\,
	combout => \inst6|11~combout\);

-- Location: FF_X28_Y21_N5
\inst6|7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst6|11~combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst6|7~q\);

-- Location: LCCOMB_X29_Y21_N28
\inst9~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst9~0_combout\ = (\inst7|7~q\ & (\inst6|7~q\ & (\inst6|6~q\ & \inst29~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|7~q\,
	datab => \inst6|7~q\,
	datac => \inst6|6~q\,
	datad => \inst29~1_combout\,
	combout => \inst9~0_combout\);

-- Location: LCCOMB_X29_Y21_N22
\inst7|11\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|11~combout\ = (\inst7|9~q\ & (!\inst9~0_combout\ & (\inst7|7~q\))) # (!\inst7|9~q\ & (\inst7|50~0_combout\ $ (((!\inst9~0_combout\ & \inst7|7~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110010100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|9~q\,
	datab => \inst9~0_combout\,
	datac => \inst7|7~q\,
	datad => \inst7|50~0_combout\,
	combout => \inst7|11~combout\);

-- Location: FF_X29_Y21_N23
\inst7|7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst7|11~combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|7~q\);

-- Location: LCCOMB_X28_Y21_N20
\inst6|12\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst6|12~combout\ = (!\inst9~0_combout\ & (\inst6|8~q\ $ (((\inst6|7~q\ & \inst9~2_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst6|7~q\,
	datab => \inst9~2_combout\,
	datac => \inst6|8~q\,
	datad => \inst9~0_combout\,
	combout => \inst6|12~combout\);

-- Location: FF_X28_Y21_N21
\inst6|8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst6|12~combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst6|8~q\);

-- Location: LCCOMB_X28_Y21_N30
\inst6|9~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst6|9~0_combout\ = (!\inst7|7~q\ & \inst6|8~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst7|7~q\,
	datad => \inst6|8~q\,
	combout => \inst6|9~0_combout\);

-- Location: LCCOMB_X28_Y21_N28
\inst6|9~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst6|9~1_combout\ = (\inst9~2_combout\ & (\inst6|9~0_combout\ & (\inst6|7~q\))) # (!\inst9~2_combout\ & (((\inst6|9~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst6|9~0_combout\,
	datab => \inst6|7~q\,
	datac => \inst6|9~q\,
	datad => \inst9~2_combout\,
	combout => \inst6|9~1_combout\);

-- Location: FF_X28_Y21_N29
\inst6|9\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst6|9~1_combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst6|9~q\);

-- Location: LCCOMB_X28_Y21_N14
\inst7|10\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|10~combout\ = (!\inst9~0_combout\ & (\inst7|6~q\ $ (((\inst6|9~q\ & \inst9~2_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst6|9~q\,
	datab => \inst9~2_combout\,
	datac => \inst7|6~q\,
	datad => \inst9~0_combout\,
	combout => \inst7|10~combout\);

-- Location: FF_X28_Y21_N15
\inst7|6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst7|10~combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|6~q\);

-- Location: LCCOMB_X29_Y21_N6
\inst7|50~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|50~0_combout\ = (\inst7|6~q\ & (\inst6|9~q\ & (\inst9~2_combout\ & !\inst9~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|6~q\,
	datab => \inst6|9~q\,
	datac => \inst9~2_combout\,
	datad => \inst9~0_combout\,
	combout => \inst7|50~0_combout\);

-- Location: LCCOMB_X29_Y21_N0
\inst7|12\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|12~combout\ = (\inst7|7~q\ & (\inst7|50~0_combout\ $ (((!\inst9~0_combout\ & \inst7|8~q\))))) # (!\inst7|7~q\ & (!\inst9~0_combout\ & (\inst7|8~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001101000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|7~q\,
	datab => \inst9~0_combout\,
	datac => \inst7|8~q\,
	datad => \inst7|50~0_combout\,
	combout => \inst7|12~combout\);

-- Location: FF_X29_Y21_N1
\inst7|8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst7|12~combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|8~q\);

-- Location: LCCOMB_X29_Y21_N14
\inst7|13~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|13~0_combout\ = (!\inst6|9~q\) # (!\inst7|6~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|6~q\,
	datad => \inst6|9~q\,
	combout => \inst7|13~0_combout\);

-- Location: LCCOMB_X29_Y21_N24
\inst7|13~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|13~1_combout\ = (\inst7|9~q\ & (!\inst9~0_combout\ & ((\inst7|13~0_combout\) # (!\inst9~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst9~2_combout\,
	datab => \inst7|9~q\,
	datac => \inst7|13~0_combout\,
	datad => \inst9~0_combout\,
	combout => \inst7|13~1_combout\);

-- Location: LCCOMB_X29_Y21_N16
\inst7|13~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst7|13~2_combout\ = (\inst7|13~1_combout\) # ((\inst7|50~0_combout\ & (\inst7|8~q\ & \inst7|7~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|50~0_combout\,
	datab => \inst7|8~q\,
	datac => \inst7|7~q\,
	datad => \inst7|13~1_combout\,
	combout => \inst7|13~2_combout\);

-- Location: FF_X29_Y21_N17
\inst7|9\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \inst33~clkctrl_outclk\,
	d => \inst7|13~2_combout\,
	clrn => \clear~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst7|9~q\);

-- Location: LCCOMB_X26_Y21_N26
\inst16|sub|81~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst16|sub|81~1_combout\ = (!\inst56567|7~q\ & ((\inst56567|6~q\ & (\inst7|9~q\)) # (!\inst56567|6~q\ & ((\inst6|9~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|9~q\,
	datab => \inst6|9~q\,
	datac => \inst56567|7~q\,
	datad => \inst56567|6~q\,
	combout => \inst16|sub|81~1_combout\);

-- Location: LCCOMB_X26_Y21_N28
\inst16|sub|81~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst16|sub|81~0_combout\ = (\inst56567|7~q\ & (\inst2|9~q\)) # (!\inst56567|7~q\ & ((\inst|9~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst2|9~q\,
	datac => \inst56567|7~q\,
	datad => \inst|9~q\,
	combout => \inst16|sub|81~0_combout\);

-- Location: LCCOMB_X26_Y21_N16
\inst16|sub|81~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst16|sub|81~2_combout\ = (\inst56567|8~q\ & (((\inst16|sub|81~1_combout\)))) # (!\inst56567|8~q\ & (!\inst56567|6~q\ & ((\inst16|sub|81~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst56567|6~q\,
	datab => \inst56567|8~q\,
	datac => \inst16|sub|81~1_combout\,
	datad => \inst16|sub|81~0_combout\,
	combout => \inst16|sub|81~2_combout\);

-- Location: LCCOMB_X26_Y21_N6
\inst15|sub|81~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst15|sub|81~2_combout\ = (\inst56567|6~q\ & (\inst7|8~q\)) # (!\inst56567|6~q\ & ((\inst6|8~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst7|8~q\,
	datac => \inst6|8~q\,
	datad => \inst56567|6~q\,
	combout => \inst15|sub|81~2_combout\);

-- Location: LCCOMB_X26_Y21_N12
\inst15|sub|81~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst15|sub|81~3_combout\ = (\inst56567|7~q\ & (((\inst56567|6~q\)))) # (!\inst56567|7~q\ & ((\inst56567|6~q\ & ((\inst1|8~q\))) # (!\inst56567|6~q\ & (\inst|8~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst|8~q\,
	datab => \inst1|8~q\,
	datac => \inst56567|7~q\,
	datad => \inst56567|6~q\,
	combout => \inst15|sub|81~3_combout\);

-- Location: LCCOMB_X26_Y21_N14
\inst15|sub|81~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst15|sub|81~4_combout\ = (\inst56567|7~q\ & ((\inst15|sub|81~3_combout\ & (\inst3|8~q\)) # (!\inst15|sub|81~3_combout\ & ((\inst2|8~q\))))) # (!\inst56567|7~q\ & (((\inst15|sub|81~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst3|8~q\,
	datab => \inst2|8~q\,
	datac => \inst56567|7~q\,
	datad => \inst15|sub|81~3_combout\,
	combout => \inst15|sub|81~4_combout\);

-- Location: LCCOMB_X26_Y21_N8
\inst15|sub|81~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst15|sub|81~5_combout\ = (\inst56567|8~q\ & (\inst15|sub|81~2_combout\ & ((!\inst56567|7~q\)))) # (!\inst56567|8~q\ & (((\inst15|sub|81~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst15|sub|81~2_combout\,
	datab => \inst15|sub|81~4_combout\,
	datac => \inst56567|7~q\,
	datad => \inst56567|8~q\,
	combout => \inst15|sub|81~5_combout\);

-- Location: LCCOMB_X26_Y21_N10
\inst14|sub|81~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst14|sub|81~3_combout\ = (\inst56567|6~q\ & ((\inst1|7~q\) # ((\inst56567|7~q\)))) # (!\inst56567|6~q\ & (((!\inst56567|7~q\ & \inst|7~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|7~q\,
	datab => \inst56567|6~q\,
	datac => \inst56567|7~q\,
	datad => \inst|7~q\,
	combout => \inst14|sub|81~3_combout\);

-- Location: LCCOMB_X26_Y21_N4
\inst14|sub|81~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst14|sub|81~4_combout\ = (\inst14|sub|81~3_combout\ & (((\inst3|7~q\) # (!\inst56567|7~q\)))) # (!\inst14|sub|81~3_combout\ & (\inst2|7~q\ & (\inst56567|7~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst14|sub|81~3_combout\,
	datab => \inst2|7~q\,
	datac => \inst56567|7~q\,
	datad => \inst3|7~q\,
	combout => \inst14|sub|81~4_combout\);

-- Location: LCCOMB_X26_Y21_N20
\inst14|sub|81~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst14|sub|81~2_combout\ = (\inst56567|6~q\ & (\inst7|7~q\)) # (!\inst56567|6~q\ & ((\inst6|7~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst7|7~q\,
	datac => \inst6|7~q\,
	datad => \inst56567|6~q\,
	combout => \inst14|sub|81~2_combout\);

-- Location: LCCOMB_X26_Y21_N30
\inst14|sub|81~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst14|sub|81~5_combout\ = (\inst56567|8~q\ & (!\inst56567|7~q\ & ((\inst14|sub|81~2_combout\)))) # (!\inst56567|8~q\ & (((\inst14|sub|81~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst56567|7~q\,
	datab => \inst56567|8~q\,
	datac => \inst14|sub|81~4_combout\,
	datad => \inst14|sub|81~2_combout\,
	combout => \inst14|sub|81~5_combout\);

-- Location: LCCOMB_X26_Y21_N24
\inst13|sub|81~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst13|sub|81~3_combout\ = (\inst56567|7~q\ & (\inst56567|6~q\)) # (!\inst56567|7~q\ & ((\inst56567|6~q\ & (\inst1|6~q\)) # (!\inst56567|6~q\ & ((\inst|6~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst56567|7~q\,
	datab => \inst56567|6~q\,
	datac => \inst1|6~q\,
	datad => \inst|6~q\,
	combout => \inst13|sub|81~3_combout\);

-- Location: LCCOMB_X26_Y21_N2
\inst13|sub|81~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst13|sub|81~4_combout\ = (\inst13|sub|81~3_combout\ & ((\inst3|6~q\) # ((!\inst56567|7~q\)))) # (!\inst13|sub|81~3_combout\ & (((\inst56567|7~q\ & \inst2|6~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110010001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst3|6~q\,
	datab => \inst13|sub|81~3_combout\,
	datac => \inst56567|7~q\,
	datad => \inst2|6~q\,
	combout => \inst13|sub|81~4_combout\);

-- Location: LCCOMB_X26_Y21_N22
\inst13|sub|81~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst13|sub|81~2_combout\ = (\inst56567|6~q\ & (\inst7|6~q\)) # (!\inst56567|6~q\ & ((\inst6|6~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst7|6~q\,
	datab => \inst56567|6~q\,
	datad => \inst6|6~q\,
	combout => \inst13|sub|81~2_combout\);

-- Location: LCCOMB_X26_Y21_N0
\inst13|sub|81~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst13|sub|81~5_combout\ = (\inst56567|8~q\ & (!\inst56567|7~q\ & ((\inst13|sub|81~2_combout\)))) # (!\inst56567|8~q\ & (((\inst13|sub|81~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst56567|7~q\,
	datab => \inst13|sub|81~4_combout\,
	datac => \inst13|sub|81~2_combout\,
	datad => \inst56567|8~q\,
	combout => \inst13|sub|81~5_combout\);

-- Location: LCCOMB_X1_Y21_N0
\inst17|68~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst17|68~0_combout\ = (\inst14|sub|81~5_combout\ & ((\inst16|sub|81~2_combout\) # ((\inst15|sub|81~5_combout\ & !\inst13|sub|81~5_combout\)))) # (!\inst14|sub|81~5_combout\ & (((\inst15|sub|81~5_combout\ & \inst13|sub|81~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst16|sub|81~2_combout\,
	datab => \inst15|sub|81~5_combout\,
	datac => \inst14|sub|81~5_combout\,
	datad => \inst13|sub|81~5_combout\,
	combout => \inst17|68~0_combout\);

-- Location: LCCOMB_X1_Y21_N2
\inst17|70\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst17|70~combout\ = (\inst15|sub|81~5_combout\ & (\inst16|sub|81~2_combout\)) # (!\inst15|sub|81~5_combout\ & (((\inst14|sub|81~5_combout\ & !\inst13|sub|81~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst16|sub|81~2_combout\,
	datab => \inst15|sub|81~5_combout\,
	datac => \inst14|sub|81~5_combout\,
	datad => \inst13|sub|81~5_combout\,
	combout => \inst17|70~combout\);

-- Location: LCCOMB_X1_Y21_N16
\inst17|67~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst17|67~0_combout\ = (\inst15|sub|81~5_combout\ & (\inst14|sub|81~5_combout\ $ (!\inst13|sub|81~5_combout\))) # (!\inst15|sub|81~5_combout\ & (!\inst14|sub|81~5_combout\ & \inst13|sub|81~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst15|sub|81~5_combout\,
	datac => \inst14|sub|81~5_combout\,
	datad => \inst13|sub|81~5_combout\,
	combout => \inst17|67~0_combout\);

-- Location: LCCOMB_X1_Y21_N18
\inst17|71\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst17|71~combout\ = (\inst13|sub|81~5_combout\) # ((\inst15|sub|81~5_combout\ & !\inst14|sub|81~5_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst15|sub|81~5_combout\,
	datac => \inst14|sub|81~5_combout\,
	datad => \inst13|sub|81~5_combout\,
	combout => \inst17|71~combout\);

-- Location: LCCOMB_X1_Y21_N20
\inst17|66~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst17|66~0_combout\ = (\inst15|sub|81~5_combout\ & (((\inst14|sub|81~5_combout\ & \inst13|sub|81~5_combout\)))) # (!\inst15|sub|81~5_combout\ & ((\inst14|sub|81~5_combout\) # ((!\inst16|sub|81~2_combout\ & \inst13|sub|81~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst16|sub|81~2_combout\,
	datab => \inst15|sub|81~5_combout\,
	datac => \inst14|sub|81~5_combout\,
	datad => \inst13|sub|81~5_combout\,
	combout => \inst17|66~0_combout\);

-- Location: LCCOMB_X1_Y21_N26
\inst17|72\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst17|72~combout\ = (\inst15|sub|81~5_combout\ & (((\inst14|sub|81~5_combout\ & \inst13|sub|81~5_combout\)))) # (!\inst15|sub|81~5_combout\ & (!\inst16|sub|81~2_combout\ & (!\inst14|sub|81~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000100000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst16|sub|81~2_combout\,
	datab => \inst15|sub|81~5_combout\,
	datac => \inst14|sub|81~5_combout\,
	datad => \inst13|sub|81~5_combout\,
	combout => \inst17|72~combout\);

-- Location: LCCOMB_X1_Y21_N12
\inst17|69~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst17|69~0_combout\ = (\inst16|sub|81~2_combout\ & ((\inst14|sub|81~5_combout\) # ((\inst15|sub|81~5_combout\ & !\inst13|sub|81~5_combout\)))) # (!\inst16|sub|81~2_combout\ & ((\inst15|sub|81~5_combout\ & ((!\inst13|sub|81~5_combout\))) # 
-- (!\inst15|sub|81~5_combout\ & (!\inst14|sub|81~5_combout\ & \inst13|sub|81~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000111101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst16|sub|81~2_combout\,
	datab => \inst15|sub|81~5_combout\,
	datac => \inst14|sub|81~5_combout\,
	datad => \inst13|sub|81~5_combout\,
	combout => \inst17|69~0_combout\);

-- Location: LCCOMB_X14_Y21_N22
\inst20|15~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst20|15~0_combout\ = (!\inst56567|7~q\ & (!\inst56567|6~q\ & !\inst56567|8~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst56567|7~q\,
	datac => \inst56567|6~q\,
	datad => \inst56567|8~q\,
	combout => \inst20|15~0_combout\);

-- Location: LCCOMB_X14_Y21_N28
\inst20|15~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst20|15~1_combout\ = (!\inst56567|7~q\ & (\inst56567|6~q\ & !\inst56567|8~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst56567|7~q\,
	datac => \inst56567|6~q\,
	datad => \inst56567|8~q\,
	combout => \inst20|15~1_combout\);

-- Location: LCCOMB_X14_Y21_N2
\inst20|15~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst20|15~2_combout\ = (\inst56567|7~q\ & (!\inst56567|6~q\ & !\inst56567|8~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst56567|7~q\,
	datac => \inst56567|6~q\,
	datad => \inst56567|8~q\,
	combout => \inst20|15~2_combout\);

-- Location: LCCOMB_X14_Y21_N4
\inst20|15~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst20|15~3_combout\ = (\inst56567|7~q\ & (\inst56567|6~q\ & !\inst56567|8~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst56567|7~q\,
	datac => \inst56567|6~q\,
	datad => \inst56567|8~q\,
	combout => \inst20|15~3_combout\);

-- Location: LCCOMB_X14_Y21_N30
\inst20|15~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst20|15~4_combout\ = (!\inst56567|7~q\ & (!\inst56567|6~q\ & \inst56567|8~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst56567|7~q\,
	datac => \inst56567|6~q\,
	datad => \inst56567|8~q\,
	combout => \inst20|15~4_combout\);

-- Location: LCCOMB_X14_Y21_N0
\inst20|15~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst20|15~5_combout\ = (!\inst56567|7~q\ & (\inst56567|6~q\ & \inst56567|8~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst56567|7~q\,
	datac => \inst56567|6~q\,
	datad => \inst56567|8~q\,
	combout => \inst20|15~5_combout\);

ww_b <= \b~output_o\;

ww_c <= \c~output_o\;

ww_d <= \d~output_o\;

ww_e <= \e~output_o\;

ww_f <= \f~output_o\;

ww_g <= \g~output_o\;

ww_a <= \a~output_o\;

ww_y0 <= \y0~output_o\;

ww_y1 <= \y1~output_o\;

ww_y2 <= \y2~output_o\;

ww_y3 <= \y3~output_o\;

ww_y4 <= \y4~output_o\;

ww_y5 <= \y5~output_o\;

ww_pin_name1 <= \pin_name1~output_o\;
END structure;


