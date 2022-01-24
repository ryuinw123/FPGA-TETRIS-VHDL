----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:13:41 12/16/2020 
-- Design Name: 
-- Module Name:    score27segment - Behavioral 
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

entity score27segment is
    Port ( OSC : in  STD_LOGIC;
           SCOREIN : in  integer;
           a : out  STD_LOGIC;
           b : out  STD_LOGIC;
           c : out  STD_LOGIC;
           d : out  STD_LOGIC;
           e : out  STD_LOGIC;
           f : out  STD_LOGIC;
           g : out  STD_LOGIC;
           common0 : out  STD_LOGIC;
           common1 : out  STD_LOGIC;
           common2 : out  STD_LOGIC;
           common3 : out  STD_LOGIC);
end score27segment;

architecture Behavioral of score27segment is
--------------------- variable zone ------------
component clk_div_120hz
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

signal clk120 : std_logic := '0';
signal scommon : std_logic_vector(3 downto 0);
signal atog : std_logic_vector(6 downto 0);
signal count : integer := 0;
signal pos : natural range 0 to 9;
signal inint : std_logic_vector (3 downto 0) ;
signal score : integer range 0 to 9999;

begin
----------------------- setup zone ---------------
clkdiv : clk_div_120hz port map(
	clk_osc => OSC,
	freq_out => clk120
);


score <= SCOREIN; --- 0 to 9999 <------------------------------------ ป้อน input เปลี่ยนคะแนนตรงนี้


---------------------------- process zone -------------- // common 3 2 1 0 active low


main : process(pos)
begin
	
	if (clk120'event and clk120 = '1') then
		count <= (count + 1) mod 4 ;
	
	
		if(count = 0)then
			pos <= (score mod 10);
			
			scommon <= "1011";
		elsif(count = 1)then
		
			if(score < 10) then
				pos <= 0;
			elsif (score = 10) then
				pos <= 1;
			elsif(score > 10 and score < 100) then
				pos <= (score / 10);
			elsif(score > 99) then
				pos <= (score mod 100) / 10;
			end if;
			
			scommon <= "0111";
		elsif(count = 2)then

			if(score < 100) then
				pos <= 0;
			elsif (score = 100) then
				pos <= 1;
			elsif(score > 100 and score < 1000) then
				pos <= (score / 100);
			elsif(score > 999) then
				pos <= (score mod 1000) / 100;
			end if;
			scommon <= "1110";
			
		elsif(count = 3)then

			if(score < 1000) then
				pos <= 0;
			elsif (score = 1000) then
				pos <= 1;
			elsif(score > 1000 and score < 10000) then
				pos <= (score / 1000);
			elsif(score > 9999) then
				pos <= pos;
			end if;

			
			scommon <= "1101";
		end if;
		
			inint <= std_logic_vector(to_unsigned(pos,inint'LENGTH));
		
			if(inint = "0000")then
				atog <= "0111111";
			elsif(inint = "0001")then
				atog <= "0000110";
			elsif(inint = "0010")then
				atog <= "1011011";
			elsif(inint = "0011")then
				atog <= "1001111";
			elsif(inint = "0100")then
				atog <= "1100110";
			elsif(inint = "0101")then
				atog <= "1101101";
			elsif(inint = "0110")then
				atog <= "1111101";
			elsif(inint = "0111")then
				atog <= "0000111";
			elsif(inint = "1000")then
				atog <= "1111111";
			elsif(inint = "1001")then
				atog <= "1100111";
			end if;
		
	a <= atog(0);
	b <= atog(1);
	c <= atog(2);
	d <= atog(3);
	e <= atog(4);
	f <= atog(5);
	g <= atog(6);
	
	common0 <= scommon(0);
	common1 <= scommon(1);
	common2 <= scommon(2);
	common3 <= scommon(3);
	end if;

end process;


end Behavioral;

