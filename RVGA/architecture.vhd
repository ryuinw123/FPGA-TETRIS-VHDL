----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:33:30 12/11/2020 
-- Design Name: 
-- Module Name:    architecture - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity architecture is
    Port ( CLK : in  STD_LOGIC;
           gameOut : out  STD_LOGIC_VECTOR (199 downto 0));
end architecture;

architecture Behavioral of architecture is
type Field1 is array (0 to 20, 0 to 10) of integer range 0 to 9;
type Figures1 is array (0 to 7, 0 to 4) of integer range 0 to 9;
type Point1 is array(0 to 4,0 to 1) of integer range 0 to 9;
signal PointX : Point1;
signal PointY : Point1;
signal Field : Field1;
signal Figures : Figures1;

begin
process begin
	
end Behavioral;

