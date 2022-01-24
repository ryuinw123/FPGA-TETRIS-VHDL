----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:38:38 12/14/2020 
-- Design Name: 
-- Module Name:    Clock_div_D4 - Behavioral 
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

entity Clock_div_D4 is
    Port ( clk_osc : in  STD_LOGIC;
           freq_out : out  STD_LOGIC);
end Clock_div_D4;

architecture Behavioral of Clock_div_D4 is

---------- variable zone -------

signal count: integer :=1;
signal tmp: std_logic := '0';



---------- process zone ----------------

begin

process
	begin

	if (clk_osc'event and clk_osc= '1') then
	count <= count + 1;

		if ( count = 68096 ) then
			tmp <= NOT tmp ;
			count <= 1;
		end if;
		
	end if;

	freq_out <= tmp;
	
end process;

end Behavioral;

