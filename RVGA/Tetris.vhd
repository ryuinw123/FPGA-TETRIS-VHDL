----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:52:03 12/11/2020 
-- Design Name: 
-- Module Name:    Tetris - Behavioral 
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

entity Tetris is
    Port ( CLK : in  STD_LOGIC;
			  RST : in  STD_LOGIC;
			  moveRight : in STD_LOGIC;
			  moveLeft : in STD_LOGIC;
			  Rotage : in STD_LOGIC;
			  start : in STD_LOGIC;
			  Movedown : in STD_LOGIC; 
			  SWAP : in STD_LOGIC;
           HSYNC : out  STD_LOGIC;
           VSYNC : out  STD_LOGIC;
			  Buzzer : out STD_LOGIC;
			  LED : out STD_LOGIC;
			  RGB : out  STD_LOGIC_VECTOR (7 downto 0);
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
           common3 : out  STD_LOGIC;
			  Speaker : out STD_LOGIC);
end Tetris;

architecture Behavioral of Tetris is
component vga_driver Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  RGBIN : in  STD_LOGIC_VECTOR (7 downto 0);
			  X : OUT natural range 0 to 1000;
			  Y : Out natural range 0 to 1000;
           HSYNC : out  STD_LOGIC;
           VSYNC : out  STD_LOGIC;
           RGB : out  STD_LOGIC_VECTOR (7 downto 0));
end component;


component MainMenu2
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;

component MainMenu
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;

component Cheer1
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;

component pushF
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;

component intoseven
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
end component;

component main Port ( OSC : in  STD_LOGIC;
			  SW : in STD_LOGIC;
           out_pwm : out  STD_LOGIC);
end component;


component Archi Port ( CLK : in  STD_LOGIC;
		 moveRight : in STD_LOGIC;
		 moveLeft : in STD_LOGIC;
		 Rotage : in STD_LOGIC;
		 Movedown : in STD_LOGIC;
		 swap : in STD_LOGIC;
		 start : in STD_LOGIC;
		 hPos : in natural range 0 to 1000;
		 vPos : in natural range 0 to 1000;
		 Buzzer : out STD_LOGIC;
		 Speaker : out STD_LOGIC;
		 RGBOUT : out  STD_LOGIC_VECTOR (7 downto 0);
		 LED : OUT STD_LOGIC;
		 MainMenuAddress : OUT std_logic_vector(14 downto 0);
		 MainMenuData : IN std_logic_vector(7 downto 0);
		 MainMenu2Address : OUT std_logic_vector(12 downto 0);
		 MainMenu2Data : IN std_logic_vector(7 downto 0);
		 PushFAddress : OUT std_logic_vector(11 downto 0);
		 PushFData : IN std_logic_vector(7 downto 0);
		 GameOverAddress : Out std_logic_vector(12 downto 0);
		 GameOverData : In std_logic_vector(7 downto 0);
		 Cheer1Address : Out std_logic_vector(13 downto 0);
		 Cheer1Data : In std_logic_Vector(7 downto 0);
		 ScoreOut : out integer);
end component;

component Hz60 Port(CLK_IN : in STD_LOGIC;
							CLK_OUT : out STD_LOGIC);
end component;

component blk_mem_gen_v7_5
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;
signal CRGB : STD_LOGIC_VECTOR(7 downto 0);
signal hPos : natural range 0 to 1000;
signal vPos : natural range 0 to 1000;
signal CLK60HZ : STD_LOGIC := '0';
signal Speaker2 : std_logic;
signal MainMenuAddress : std_logic_vector(14 downto 0);
signal MainMenuData : std_logic_vector(7 downto 0);
signal MainMenu2Address : std_logic_vector(12 downto 0);
signal MainMenu2Data : std_logic_vector(7 downto 0);
signal PushFAddress : std_logic_vector(11 downto 0);
signal PushFData : std_logic_vector(7 downto 0);
signal GameOverAddress : std_logic_vector(12 downto 0);
signal GameOverData : std_logic_vector(7 downto 0);
signal Cheer1Address : std_logic_vector(13 downto 0);
signal Cheer1Data : std_logic_vector(7 downto 0);
signal Scorenow : integer := 0;
begin
		gif1 : cheer1 port map(addra => Cheer1Address,douta => Cheer1Data,clka => CLK);
		sdr : blk_mem_gen_v7_5 port map(addra => GameOverAddress,douta => GameOverData,clka => CLK);
		scc: intoseven port map(OSC => CLK,SCOREIN => Scorenow,a=>a,b=>b,c=>c,d=>d,e=>e,f=>f,g=>g,common0=>common0,common1=>common1,common2=>common2,common3=>common3);
		sdt: mainmenu port map (addra => MainMenuAddress,douta => MainMenuData,clka => CLK);
		stt: mainmenu2 port map (addra => MainMenu2Address,douta => MainMenu2Data,clka => CLK);
		akk: pushf port map (addra => PushFAddress,douta => PushFData,clka => CLK);
		cc : Hz60 Port map(CLK_IN => CLK,CLK_OUT => CLK60HZ);
		aa : Archi Port map(CLK => CLK60HZ,moveRight => moveRight,moveLeft => moveLeft,Rotage => Rotage,Movedown => Movedown,sWAP => sWAP,start => start,hPos => hPos,vPos => vPos,Buzzer => Buzzer,Speaker => Speaker,RGBOUT => CRGB,LED => LED,MainMenuAddress => MainMenuAddress,MainMenuData => MainMenuData,MainMenu2Address => MainMenu2Address,MainMenu2Data => MainMenu2Data,PushFAddress=>PushFAddress,PushFData => PushFData,GameOverAddress => GameOverAddress,GameOverData => GameOverData,Cheer1Address => Cheer1Address,Cheer1Data => Cheer1Data,ScoreOut => Scorenow);
		bb : vga_driver Port map(CLK => CLK,RST => RST,RGBIN => CRGB,X => hPos,Y => vPos,HSYNC => HSYNC,VSYNC => VSYNC,RGB => RGB);
end Behavioral;

