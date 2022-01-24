--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : Hz60.vhf
-- /___/   /\     Timestamp : 12/15/2020 16:46:16
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan6 -flat -suppress -vhdl C:/Users/romth/Desktop/flasher/RVGA/Hz60.vhf -w C:/Users/romth/Desktop/REAL/Hz60.sch
--Design Name: Hz60
--Device: spartan6
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity Divider_MUSER_Hz60 is
   port ( CLKIN  : in    std_logic; 
          CLKOUT : out   std_logic);
end Divider_MUSER_Hz60;

architecture BEHAVIORAL of Divider_MUSER_Hz60 is
   attribute BOX_TYPE   : string ;
   signal XLXN_2       : std_logic;
   signal CLKOUT_DUMMY : std_logic;
   component FD
      generic( INIT : bit :=  '0');
      port ( C : in    std_logic; 
             D : in    std_logic; 
             Q : out   std_logic);
   end component;
   attribute BOX_TYPE of FD : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
begin
   CLKOUT <= CLKOUT_DUMMY;
   XLXI_1 : FD
      port map (C=>CLKIN,
                D=>XLXN_2,
                Q=>CLKOUT_DUMMY);
   
   XLXI_2 : INV
      port map (I=>CLKOUT_DUMMY,
                O=>XLXN_2);
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity Hz60 is
   port ( CLK_IN  : in    std_logic; 
          CLK_OUT : out   std_logic);
end Hz60;

architecture BEHAVIORAL of Hz60 is
   signal XLXN_1  : std_logic;
   signal XLXN_2  : std_logic;
   signal XLXN_3  : std_logic;
   signal XLXN_4  : std_logic;
   signal XLXN_5  : std_logic;
   signal XLXN_6  : std_logic;
   signal XLXN_7  : std_logic;
   signal XLXN_8  : std_logic;
   signal XLXN_9  : std_logic;
   signal XLXN_10 : std_logic;
   signal XLXN_11 : std_logic;
   signal XLXN_15 : std_logic;
   signal XLXN_16 : std_logic;
   signal XLXN_17 : std_logic;
   signal XLXN_21 : std_logic;
   signal XLXN_22 : std_logic;
   signal XLXN_25 : std_logic;
   signal XLXN_27 : std_logic;
   component Divider_MUSER_Hz60
      port ( CLKIN  : in    std_logic; 
             CLKOUT : out   std_logic);
   end component;
   
begin
   XLXI_2 : Divider_MUSER_Hz60
      port map (CLKIN=>CLK_IN,
                CLKOUT=>XLXN_1);
   
   XLXI_3 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_1,
                CLKOUT=>XLXN_2);
   
   XLXI_5 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_2,
                CLKOUT=>XLXN_3);
   
   XLXI_6 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_3,
                CLKOUT=>XLXN_4);
   
   XLXI_7 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_4,
                CLKOUT=>XLXN_5);
   
   XLXI_8 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_5,
                CLKOUT=>XLXN_15);
   
   XLXI_9 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_15,
                CLKOUT=>XLXN_6);
   
   XLXI_10 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_6,
                CLKOUT=>XLXN_7);
   
   XLXI_11 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_7,
                CLKOUT=>XLXN_8);
   
   XLXI_12 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_8,
                CLKOUT=>XLXN_9);
   
   XLXI_13 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_9,
                CLKOUT=>XLXN_10);
   
   XLXI_14 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_10,
                CLKOUT=>XLXN_11);
   
   XLXI_15 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_11,
                CLKOUT=>XLXN_16);
   
   XLXI_16 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_16,
                CLKOUT=>XLXN_17);
   
   XLXI_18 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_27,
                CLKOUT=>CLK_OUT);
   
   XLXI_22 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_17,
                CLKOUT=>XLXN_21);
   
   XLXI_23 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_22,
                CLKOUT=>XLXN_25);
   
   XLXI_25 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_25,
                CLKOUT=>XLXN_27);
   
   XLXI_26 : Divider_MUSER_Hz60
      port map (CLKIN=>XLXN_21,
                CLKOUT=>XLXN_22);
   
end BEHAVIORAL;


