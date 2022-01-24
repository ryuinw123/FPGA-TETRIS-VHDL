--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : Divider.vhf
-- /___/   /\     Timestamp : 12/12/2020 13:52:45
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan6 -flat -suppress -vhdl C:/Users/ryu/Desktop/FPGA-Flasher-master/RVGA/Divider.vhf -w C:/XILIX/REAL/Divider.sch
--Design Name: Divider
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

entity Divider is
   port ( CLKIN  : in    std_logic; 
          CLKOUT : out   std_logic);
end Divider;

architecture BEHAVIORAL of Divider is
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


