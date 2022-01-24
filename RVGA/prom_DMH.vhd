----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:56:38 12/15/2020 
-- Design Name: 
-- Module Name:    prom_DMH - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prom_DMH is
    Port ( address : in  natural range 0 to 15;
           M : out  STD_LOGIC_VECTOR (0 to 31));
end prom_DMH;

architecture Behavioral of prom_DMH is
type rom_array is array (NATURAL range <>) of STD_LOGIC_VECTOR(0 to 31);
constant rom : rom_array := ("01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010",
									  "01111110000011000001101000000010")
begin
process
variable j : integer;
begin
	j := address;
	M <= rom(j);
end Behavioral;

