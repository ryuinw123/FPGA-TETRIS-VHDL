----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:04:19 12/11/2020 
-- Design Name: 
-- Module Name:    Test - Behavioral 
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

entity Test is
    Port ( GAME : in  STD_LOGIC_VECTOR (199 downto 0);
           LED : out  STD_LOGIC_VECTOR (7 downto 0));
end Test;

architecture Behavioral of Test is
begin
clk:process
begin
for i in 0 to 7 loop
	if (GAME(i) = '1') then
	LED(i)<= '1';
	end if;
end loop;
end process;

end Behavioral;
