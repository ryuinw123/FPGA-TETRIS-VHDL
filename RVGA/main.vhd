----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:35:02 12/14/2020 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
    Port ( OSC : in  STD_LOGIC;
			  SW : in STD_LOGIC;
			  LED : inout STD_LOGIC;
           out_pwm : out  STD_LOGIC);
end main;

architecture Behavioral of main is

--------------------- variable zone -------------

----------- note component ------
component Clock_Beat
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_G2
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_GS2
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_A2
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_B2
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_C3
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_D3
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_E3
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_F3
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_G3
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_A3
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_B3
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_C4
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_D4
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_E4
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_F4
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_G4
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_A4
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_B4
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_C5
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_D5
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_E5
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_F5
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_G5
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_A5
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;

component Clock_div_B5
port(
	clk_osc : in  STD_LOGIC;
	freq_out : out  STD_LOGIC
);
end component;
------------------------------

signal out_pw : std_logic_vector(25 downto 0);
signal beat : std_logic := '0';
signal pre_beat : std_logic := '0';
signal iterator : integer := 0 ;
signal count : integer := 0;
signal lled : std_logic := '0';

type LIST is array (0 to 1179) of integer range 0 to 25;

signal note : LIST ;
signal run_note : integer := 0;

--------------------- process zone --------------

begin

----------- Tetris Theme By korobeiniki ------------

note <= (21,21,0,7,7,0,18,18,0,19,19,0,20,20,0,21,21,0,20,20,0,19,19,0,18,18,0,17,17,0,10,10,0,17,17,0,19,19,0,21,21,0,10,10,0,20,20,0,19,19,0,18,18,0,14,14,0,16,16,0,19,19,0,20,20,0,7,7,0,21,21,0,7,7,0,19,19,0,10,10,0,17,17,0,10,10,0,17,17,0,10,10,0,4,4,0,5,5,0,6,6,0,20,20,0,22,22,0,24,24,0,19,19,0,19,19,0,23,23,0,22,22,0,21,21,0,5,5,0,0,0,0,0,0,19,19,0,21,21,0,17,17,0,16,16,0,20,20,0,19,19,0,18,18,0,14,14,0,18,18,0,19,19,0,20,20,0,16,16,0,21,21,0,16,16,0,19,19,0,14,14,0,17,17,0,7,7,0,17,17,0,0,0,0,0,0,21,21,0,7,7,0,18,18,0,19,19,0,20,20,0,21,21,0,20,20,0,19,19,0,18,18,0,17,17,0,10,10,0,17,17,0,19,19,0,21,21,0,10,10,0,20,20,0,19,19,0,18,18,0,14,14,0,16,16,0,19,19,0,20,20,0,7,7,0,21,21,0,7,7,0,19,19,0,10,10,0,17,17,0,10,10,0,17,17,0,10,10,0,4,4,0,5,5,0,6,6,0,20,20,0,22,22,0,24,24,0,19,19,0,19,19,0,23,23,0,22,22,0,21,21,0,5,5,0,0,0,0,0,0,19,19,0,21,21,0,17,17,0,16,16,0,20,20,0,19,19,0,18,18,0,14,14,0,18,18,0,19,19,0,20,20,0,16,16,0,21,21,0,16,16,0,19,19,0,14,14,0,17,17,0,7,7,0,17,17,0,0,0,0,0,0,14,14,0,7,7,0,3,3,0,7,7,0,12,12,0,7,7,0,3,3,0,7,7,0,13,13,0,7,7,0,2,2,0,7,7,0,11,11,0,7,7,0,2,2,0,7,7,0,12,12,0,7,7,0,3,3,0,7,7,0,10,10,0,7,7,0,3,3,0,7,7,0,0,0,0,0,0,7,7,0,2,2,0,7,7,0,11,11,0,7,7,0,2,2,0,7,7,0,14,14,0,7,7,0,3,3,0,7,7,0,12,12,0,7,7,0,3,3,0,7,7,0,13,13,0,7,7,0,2,2,0,7,7,0,11,11,0,7,7,0,2,2,0,7,7,0,12,12,0,7,7,0,14,14,0,7,7,0,17,17,0,7,7,0,3,3,0,7,7,0,0,0,0,0,0,7,7,0,2,2,0,7,7,0,2,2,0,7,7,0,2,2,0,7,7,0,21,21,0,7,7,0,18,18,0,19,19,0,20,20,0,21,21,0,20,20,0,19,19,0,18,18,0,17,17,0,10,10,0,17,17,0,19,19,0,21,21,0,10,10,0,20,20,0,19,19,0,18,18,0,14,14,0,16,16,0,19,19,0,20,20,0,7,7,0,21,21,0,7,7,0,19,19,0,10,10,0,17,17,0,10,10,0,17,17,0,10,10,0,4,4,0,5,5,0,6,6,0,20,20,0,22,22,0,24,24,0,19,19,0,19,19,0,23,23,0,22,22,0,21,21,0,5,5,0,0,0,0,0,0,19,19,0,21,21,0,17,17,0,16,16,0,20,20,0,19,19,0,18,18,0,14,14,0,18,18,0,19,19,0,20,20,0,16,16,0,21,21,0,16,16,0,19,19,0,14,14,0,17,17,0,7,7,0,17,17,0,0,0,0,0,0,21,21,0,7,7,0,18,18,0,19,19,0,20,20,0,21,21,0,20,20,0,19,19,0,18,18,0,17,17,0,10,10,0,17,17,0,19,19,0,21,21,0,10,10,0,20,20,0,19,19,0,18,18,0,14,14,0,16,16,0,19,19,0,20,20,0,7,7,0,21,21,0,7,7,0,19,19,0,10,10,0,17,17,0,10,10,0,17,17,0,10,10,0,4,4,0,5,5,0,6,6,0,20,20,0,22,22,0,24,24,0,19,19,0,19,19,0,23,23,0,22,22,0,21,21,0,5,5,0,0,0,0,0,0,19,19,0,21,21,0,17,17,0,16,16,0,20,20,0,19,19,0,18,18,0,14,14,0,18,18,0,19,19,0,20,20,0,16,16,0,21,21,0,16,16,0,19,19,0,14,14,0,17,17,0,7,7,0,17,17,0,0,0,0,0,0,14,14,0,7,7,0,3,3,0,7,7,0,12,12,0,7,7,0,3,3,0,7,7,0,13,13,0,7,7,0,2,2,0,7,7,0,11,11,0,7,7,0,2,2,0,7,7,0,12,12,0,7,7,0,3,3,0,7,7,0,10,10,0,7,7,0,3,3,0,7,7,0,0,0,0,0,0,7,7,0,2,2,0,7,7,0,11,11,0,7,7,0,2,2,0,7,7,0,14,14,0,7,7,0,3,3,0,7,7,0,12,12,0,7,7,0,3,3,0,7,7,0,13,13,0,7,7,0,2,2,0,7,7,0,11,11,0,7,7,0,2,2,0,7,7,0,12,12,0,7,7,0,14,14,0,7,7,0,17,17,0,7,7,0,3,3,0,7,7,0,0,0,0,0,0,7,7,0,2,2,0,7,7,0,2,2,0,7,7,0,2,2,0,7,7,0,0,0,0,0);

---- note port map ----

u_beat : Clock_Beat port map(
clk_osc => OSC,
freq_out => beat
);

-- u0 no sound
out_pw(0) <= '0';

u1 : Clock_div_G2 port map(
clk_osc => OSC,
freq_out => out_pw(1)
);

u2 : Clock_div_GS2 port map(
clk_osc => OSC,
freq_out => out_pw(2)
);

u3 : Clock_div_A2 port map(
clk_osc => OSC,
freq_out => out_pw(3)
);

u4 : Clock_div_B2 port map(
clk_osc => OSC,
freq_out => out_pw(4)
);

u5 : Clock_div_C3 port map(
clk_osc => OSC,
freq_out => out_pw(5)
);

u6 : Clock_div_D3 port map(
clk_osc => OSC,
freq_out => out_pw(6)
);

u7 : Clock_div_E3 port map(
clk_osc => OSC,
freq_out => out_pw(7)
);

u8 : Clock_div_F3 port map(
clk_osc => OSC,
freq_out => out_pw(8)
);

u9 : Clock_div_G3 port map(
clk_osc => OSC,
freq_out => out_pw(9)
);

u10 : Clock_div_A3 port map(
clk_osc => OSC,
freq_out => out_pw(10)
);

u11 : Clock_div_B3 port map(
clk_osc => OSC,
freq_out => out_pw(11)
);

u12 : Clock_div_C4 port map(
clk_osc => OSC,
freq_out => out_pw(12)
);

u13 : Clock_div_D4 port map(
clk_osc => OSC,
freq_out => out_pw(13)
);

u14 : Clock_div_E4 port map(
clk_osc => OSC,
freq_out => out_pw(14)
);

u15 : Clock_div_F4 port map(
clk_osc => OSC,
freq_out => out_pw(15)
);

u16 : Clock_div_G4 port map(
clk_osc => OSC,
freq_out => out_pw(16)
);

u17 : Clock_div_A4 port map(
clk_osc => OSC,
freq_out => out_pw(17)
);

u18 : Clock_div_B4 port map(
clk_osc => OSC,
freq_out => out_pw(18)
);

u19 : Clock_div_C5 port map(
clk_osc => OSC,
freq_out => out_pw(19)
);

u20 : Clock_div_D5 port map(
clk_osc => OSC,
freq_out => out_pw(20)
);

u21 : Clock_div_E5 port map(
clk_osc => OSC,
freq_out => out_pw(21)
);

u22 : Clock_div_F5 port map(
clk_osc => OSC,
freq_out => out_pw(22)
);

u23 : Clock_div_G5 port map(
clk_osc => OSC,
freq_out => out_pw(23)
);

u24 : Clock_div_A5 port map(
clk_osc => OSC,
freq_out => out_pw(24)
);

u25 : Clock_div_B5 port map(
clk_osc => OSC,
freq_out => out_pw(25)
);

--------- music process ---------

music :process
begin

if (beat'event and beat = '1') then
	count <= (count + 1) mod 1180; -- num of array song
	lled <= not lled;	
end if;

if (sw = '1') then
	
	out_pwm <= out_pw(note(count));
	
end if;

LED <= lled;

end process;


end Behavioral;

