-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\mandelbrot_fpga\vertical_ranges.vhd
-- Created: 2019-10-07 19:53:20
-- 
-- Generated by MATLAB 9.7 and HDL Coder 3.15
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: vertical_ranges
-- Source Path: mandelbrot_fpga/mandelbrot_top/mandelbrot_core/vga_driver/vertical_ranges 
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY vertical_ranges IS
  PORT( count                             :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        resolution                        :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        front_porch                       :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        sync                              :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        index                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- uint16
        sync_pulse                        :   OUT   std_logic;
        video_enable                      :   OUT   std_logic
        );
END vertical_ranges;


ARCHITECTURE rtl OF vertical_ranges IS

  -- Signals
  SIGNAL count_unsigned                   : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL resolution_unsigned              : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL front_porch_unsigned             : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Add_out1                         : unsigned(16 DOWNTO 0);  -- ufix17
  SIGNAL Relational_Operator1_relop1      : std_logic;
  SIGNAL sync_unsigned                    : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Add1_out1                        : unsigned(17 DOWNTO 0);  -- ufix18
  SIGNAL Relational_Operator2_relop1      : std_logic;
  SIGNAL Logical_Operator_out1            : std_logic;
  SIGNAL Relational_Operator_relop1       : std_logic;

BEGIN
  count_unsigned <= unsigned(count);

  resolution_unsigned <= unsigned(resolution);

  front_porch_unsigned <= unsigned(front_porch);

  Add_out1 <= resize(resolution_unsigned, 17) + resize(front_porch_unsigned, 17);

  
  Relational_Operator1_relop1 <= '1' WHEN resize(count_unsigned, 17) >= Add_out1 ELSE
      '0';

  sync_unsigned <= unsigned(sync);

  Add1_out1 <= resize(Add_out1, 18) + resize(sync_unsigned, 18);

  
  Relational_Operator2_relop1 <= '1' WHEN resize(count_unsigned, 18) < Add1_out1 ELSE
      '0';

  Logical_Operator_out1 <= Relational_Operator1_relop1 AND Relational_Operator2_relop1;

  
  Relational_Operator_relop1 <= '1' WHEN count_unsigned < resolution_unsigned ELSE
      '0';

  index <= count;

  sync_pulse <= Logical_Operator_out1;

  video_enable <= Relational_Operator_relop1;

END rtl;

