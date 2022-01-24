----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:51:19 12/15/2020 
-- Design Name: 
-- Module Name:    clk_div_60hz - Behavioral 
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

entity clk_div_120hz is
    Port ( clk_osc : in  STD_LOGIC;
           freq_out : out  STD_LOGIC);
end clk_div_120hz;

architecture Behavioral of clk_div_120hz is

---------- variable zone -------

signal count: integer :=1;
signal tmp: std_logic := '0';



---------- process zone ----------------

begin

process
	begin

	if (clk_osc'event and clk_osc= '1') then
	count <= count + 1;

		if ( count = 64 ) then
		--if ( count = 5000000 ) then
			tmp <= NOT tmp ;
			count <= 1;
		end if;
		
	end if;

	freq_out <= tmp;
	
end process;

end Behavioral;