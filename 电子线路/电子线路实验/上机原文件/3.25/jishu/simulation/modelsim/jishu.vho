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

-- DATE "03/27/2025 19:45:44"

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

ENTITY 	jishu IS
    PORT (
	q0 : OUT std_logic;
	CLR : IN std_logic;
	PRN : IN std_logic;
	NPJT : IN std_logic;
	q1 : OUT std_logic;
	q2 : OUT std_logic;
	q3 : OUT std_logic
	);
END jishu;

-- Design Ports Information
-- q0	=>  Location: PIN_68,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q1	=>  Location: PIN_69,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q2	=>  Location: PIN_70,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q3	=>  Location: PIN_71,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PRN	=>  Location: PIN_73,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- NPJT	=>  Location: PIN_74,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- CLR	=>  Location: PIN_75,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF jishu IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_q0 : std_logic;
SIGNAL ww_CLR : std_logic;
SIGNAL ww_PRN : std_logic;
SIGNAL ww_NPJT : std_logic;
SIGNAL ww_q1 : std_logic;
SIGNAL ww_q2 : std_logic;
SIGNAL ww_q3 : std_logic;
SIGNAL \q0~output_o\ : std_logic;
SIGNAL \q1~output_o\ : std_logic;
SIGNAL \q2~output_o\ : std_logic;
SIGNAL \q3~output_o\ : std_logic;
SIGNAL \PRN~input_o\ : std_logic;
SIGNAL \inst1~1_combout\ : std_logic;
SIGNAL \inst~0_combout\ : std_logic;
SIGNAL \inst1~_emulated_q\ : std_logic;
SIGNAL \inst1~0_combout\ : std_logic;
SIGNAL \inst2~1_combout\ : std_logic;
SIGNAL \inst2~_emulated_q\ : std_logic;
SIGNAL \inst2~0_combout\ : std_logic;
SIGNAL \inst3~1_combout\ : std_logic;
SIGNAL \inst3~_emulated_q\ : std_logic;
SIGNAL \inst3~0_combout\ : std_logic;
SIGNAL \inst9~0_combout\ : std_logic;
SIGNAL \CLR~input_o\ : std_logic;
SIGNAL \inst8~combout\ : std_logic;
SIGNAL \inst~1_combout\ : std_logic;
SIGNAL \NPJT~input_o\ : std_logic;
SIGNAL \inst~3_combout\ : std_logic;
SIGNAL \inst~_emulated_q\ : std_logic;
SIGNAL \inst~2_combout\ : std_logic;
SIGNAL \ALT_INV_inst~0_combout\ : std_logic;
SIGNAL \ALT_INV_inst2~0_combout\ : std_logic;
SIGNAL \ALT_INV_inst1~0_combout\ : std_logic;
SIGNAL \ALT_INV_inst~2_combout\ : std_logic;

BEGIN

q0 <= ww_q0;
ww_CLR <= CLR;
ww_PRN <= PRN;
ww_NPJT <= NPJT;
q1 <= ww_q1;
q2 <= ww_q2;
q3 <= ww_q3;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_inst~0_combout\ <= NOT \inst~0_combout\;
\ALT_INV_inst2~0_combout\ <= NOT \inst2~0_combout\;
\ALT_INV_inst1~0_combout\ <= NOT \inst1~0_combout\;
\ALT_INV_inst~2_combout\ <= NOT \inst~2_combout\;

-- Location: IOOBUF_X30_Y0_N9
\q0~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst~2_combout\,
	devoe => ww_devoe,
	o => \q0~output_o\);

-- Location: IOOBUF_X30_Y0_N2
\q1~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst1~0_combout\,
	devoe => ww_devoe,
	o => \q1~output_o\);

-- Location: IOOBUF_X32_Y0_N23
\q2~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst2~0_combout\,
	devoe => ww_devoe,
	o => \q2~output_o\);

-- Location: IOOBUF_X32_Y0_N16
\q3~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst3~0_combout\,
	devoe => ww_devoe,
	o => \q3~output_o\);

-- Location: IOIBUF_X34_Y2_N22
\PRN~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_PRN,
	o => \PRN~input_o\);

-- Location: LCCOMB_X33_Y2_N12
\inst1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1~1_combout\ = \inst~1_combout\ $ (!\inst1~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst~1_combout\,
	datad => \inst1~0_combout\,
	combout => \inst1~1_combout\);

-- Location: LCCOMB_X33_Y2_N8
\inst~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst~0_combout\ = (\inst8~combout\) # (!\PRN~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \PRN~input_o\,
	datad => \inst8~combout\,
	combout => \inst~0_combout\);

-- Location: FF_X33_Y2_N13
\inst1~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ALT_INV_inst~2_combout\,
	d => \inst1~1_combout\,
	clrn => \ALT_INV_inst~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst1~_emulated_q\);

-- Location: LCCOMB_X33_Y2_N20
\inst1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst1~0_combout\ = (!\inst8~combout\ & ((\inst~1_combout\ $ (\inst1~_emulated_q\)) # (!\PRN~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100100011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst~1_combout\,
	datab => \inst8~combout\,
	datac => \PRN~input_o\,
	datad => \inst1~_emulated_q\,
	combout => \inst1~0_combout\);

-- Location: LCCOMB_X32_Y2_N12
\inst2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst2~1_combout\ = \inst2~0_combout\ $ (!\inst~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst2~0_combout\,
	datad => \inst~1_combout\,
	combout => \inst2~1_combout\);

-- Location: FF_X32_Y2_N13
\inst2~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ALT_INV_inst1~0_combout\,
	d => \inst2~1_combout\,
	clrn => \ALT_INV_inst~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst2~_emulated_q\);

-- Location: LCCOMB_X32_Y2_N18
\inst2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst2~0_combout\ = (!\inst8~combout\ & ((\inst~1_combout\ $ (\inst2~_emulated_q\)) # (!\PRN~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010101000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8~combout\,
	datab => \inst~1_combout\,
	datac => \PRN~input_o\,
	datad => \inst2~_emulated_q\,
	combout => \inst2~0_combout\);

-- Location: LCCOMB_X32_Y2_N26
\inst3~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst3~1_combout\ = \inst~1_combout\ $ (!\inst3~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \inst~1_combout\,
	datad => \inst3~0_combout\,
	combout => \inst3~1_combout\);

-- Location: FF_X32_Y2_N27
\inst3~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \ALT_INV_inst2~0_combout\,
	d => \inst3~1_combout\,
	clrn => \ALT_INV_inst~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst3~_emulated_q\);

-- Location: LCCOMB_X32_Y2_N10
\inst3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst3~0_combout\ = (!\inst8~combout\ & ((\inst~1_combout\ $ (\inst3~_emulated_q\)) # (!\PRN~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8~combout\,
	datab => \inst~1_combout\,
	datac => \inst3~_emulated_q\,
	datad => \PRN~input_o\,
	combout => \inst3~0_combout\);

-- Location: LCCOMB_X32_Y2_N4
\inst9~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst9~0_combout\ = (\inst3~0_combout\ & (\inst1~0_combout\ & (!\inst~2_combout\ & !\inst2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst3~0_combout\,
	datab => \inst1~0_combout\,
	datac => \inst~2_combout\,
	datad => \inst2~0_combout\,
	combout => \inst9~0_combout\);

-- Location: IOIBUF_X34_Y3_N22
\CLR~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLR,
	o => \CLR~input_o\);

-- Location: LCCOMB_X33_Y2_N6
inst8 : cycloneive_lcell_comb
-- Equation(s):
-- \inst8~combout\ = (\inst9~0_combout\) # (!\CLR~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst9~0_combout\,
	datad => \CLR~input_o\,
	combout => \inst8~combout\);

-- Location: LCCOMB_X32_Y2_N0
\inst~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst~1_combout\ = (!\inst8~combout\ & ((\inst~1_combout\) # (!\PRN~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst8~combout\,
	datac => \PRN~input_o\,
	datad => \inst~1_combout\,
	combout => \inst~1_combout\);

-- Location: IOIBUF_X34_Y2_N15
\NPJT~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_NPJT,
	o => \NPJT~input_o\);

-- Location: LCCOMB_X33_Y2_N24
\inst~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst~3_combout\ = \inst~1_combout\ $ (!\inst~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \inst~1_combout\,
	datad => \inst~2_combout\,
	combout => \inst~3_combout\);

-- Location: FF_X33_Y2_N25
\inst~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \NPJT~input_o\,
	d => \inst~3_combout\,
	clrn => \ALT_INV_inst~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst~_emulated_q\);

-- Location: LCCOMB_X33_Y2_N0
\inst~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \inst~2_combout\ = (!\inst8~combout\ & ((\inst~1_combout\ $ (\inst~_emulated_q\)) # (!\PRN~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100100011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst~1_combout\,
	datab => \inst8~combout\,
	datac => \PRN~input_o\,
	datad => \inst~_emulated_q\,
	combout => \inst~2_combout\);

ww_q0 <= \q0~output_o\;

ww_q1 <= \q1~output_o\;

ww_q2 <= \q2~output_o\;

ww_q3 <= \q3~output_o\;
END structure;


