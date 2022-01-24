----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:07:14 12/11/2020 
-- Design Name: 
-- Module Name:    Archi - Behavioral 
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

entity Archi is
Port ( CLK : in  STD_LOGIC;
		 moveRight : in STD_LOGIC;
		 moveLeft : in STD_LOGIC;
		 Rotage : in STD_LOGIC;
		 Movedown : in STD_LOGIC;
		 start : in STD_LOGIC;
		 swap : in STD_LOGIC;
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
		 Cheer1Data : in std_logic_vector(7 downto 0);
		 ScoreOut : out integer);
end Archi;

architecture Behavioral of Archi is



component clock_divider port ( clk,reset: in std_logic;
										clockout: out std_logic);
end component;
type Field1 is array (0 to 19, 0 to 9) of integer range 0 to 9;
type CField is array (0 to 3,0 to 1) of integer range 0 to 9;
type Figures1 is array (0 to 6, 0 to 3) of integer range 0 to 9;
type PointX1 is array(0 to 3) of integer range -2 to 9;
type PointY1 is array(0 to 3) of integer range -2 to 19;
type color1 is array(0 to 6) of STD_LOGIC_VECTOR(7 downto 0);
signal aX : PointX1;
signal aY : PointY1;
signal bX : PointX1;
signal bY : PointY1;
constant BoxX : integer := 9;
constant BoxY : integer := 19;
constant color : color1 := ("11001100","00111000","00000111","10100000","11101000","10000111","11100100");
signal Field : Field1;
signal Field2 : Field1;
signal Field3 : CField;
signal Figures : Figures1 := (((1),(3),(5),(7)),
										((2),(4),(5),(7)),
										((3),(5),(4),(6)),
										((3),(5),(4),(7)),
										((2),(3),(5),(7)),
										((3),(5),(7),(6)),
										((2),(3),(4),(5)));


signal ko : integer := 2;
signal afterko : integer := 5;

signal Score : integer := 0;
signal SHOWSCORE : integer := 0;
signal h : integer := 3;
signal k : integer := 0;
signal b : integer := 0;
signal c : integer := 0;
signal pushfswap : STD_LOGIC := '1';
signal LEDOP : STD_LOGIC := '0';
signal canbuilt : STD_LOGIC := '1';
signal clkout1hz : STD_LOGIC := '0';
signal StartPointX : integer := 100;
signal StartPointY : integer := 30;
signal gameOver : STD_LOGIC := '0';
signal stage : integer := 0;
signal colorcount : integer := 0;
signal hereColor : integer := 0;
signal afterhereColor : integer := 0;
signal scorecount : natural;
signal difficulty : integer := 15;
signal difficultycount : integer := 0;
signal nextblock : STD_LOGIC := '0';
signal swapko : integer := 0;
signal swapcolor : integer := 0;
signal buzzerTimer : integer := 0;
signal buzzerA : STD_LOGIC := '0';


begin

cc : clock_divider port map(clk => CLK,reset => '0' , clockout => clkout1hz);

process(aX,aY,Figures)
variable check : STD_LOGIC := '0';
variable count : integer := 0;
begin
--block checking

--block moving
if (CLK'event and CLK = '1') then
	if (stage = 1) then
				
				
				
		scorecount <= scorecount+1;
		k <= k+1;
		b <= b+1;
		difficultycount <= difficultycount + 1;
		if (difficultycount = 1000) then
			difficultycount <= 0;
			if (difficulty > 10) then
				difficulty <= difficulty - 1;
			end if;
		end if;
		colorcount <= colorcount + 1;
		if (colorcount = 6) then
			colorcount <= 0;
		end if;
		if (b = 7) then
			b <= 0;
		end if;
		if (k >= difficulty or MoveDown = '1') then
			check := '1';
			for i in 0 to 3 loop
				if (Field(aY(i)+1,aX(i)) = 1 or aY(i) > 18) then
					check := '0';
					exit;
				end if;
			end loop;
			if (check = '1') then
				for i in 0 to 3 loop
					aY(i) <= aY(i) + 1;
				end loop;
			else
				for i in 0 to 3 loop
					Field(aY(i),aX(i)) <= 1;
				end loop;
				for i in 0 to 9 loop
					if (Field(0,i) = 1) then
						stage <= 2;
						Speaker <= '0';
						exit;
					end if;
				end loop;
				nextblock <= '1';
				canbuilt <= '1';
			end if;
			k <= 0;	
		elsif (swap = '1') then
			check := '1';
			LED <= '1';
			for i in 0 to 9 loop
				if (field2(1,i) = 1) then
					check := '0';
					exit;
				end if;
			end loop;
			if (check = '0') then
				canbuilt <= '1';
			end if;
		elsif (moveRight = '1') then
			check := '1';
			LED <= '0';
			for i in 0 to 3 loop
				if (aX(i) > 8 or Field(aY(i),aX(i)+1) = 1) then
					check := '0';
					exit;
				end if;
			end loop;
			if (check = '1') then
				for i in 0 to 3 loop
					aX(i) <=  aX(i)+1;
				end loop;
			end if;
		elsif (moveLeft = '1') then
			check := '1';
			for i in 0 to 3 loop
				if (aX(i) < 1 or Field (aY(i),aX(i)-1) = 1) then
					check := '0';
					exit;
				end if;
			end loop;
			if (check = '1') then
				for i in 0 to 3 loop
					aX(i) <=  aX(i) -1;
				end loop;
			end if;
		elsif (rotage = '1') then
			check := '1';
			for i in 0 to 3 loop
				if (aX(1) - aY(i) + aY(1) < 0 or aX(1) - aY(i) + aY(1) > 9 or Field (aY(1) + aX(i) - aX(1),aX(1) - aY(i) + aY(1)) = 1  or aY(1) + aX(i) - aX(1) > 19) then
					check := '0';
					exit;
				end if;
			end loop;
			if (check = '1') then
				for i in 0 to 3 loop
					aX(i) <= aX(1) - aY(i) + aY(1);
					aY(i) <= aY(1) + aX(i) - aX(1);
				end loop;
			end if;
		end if;
		if (canbuilt = '1') then
			if (nextblock = '1') then
				ko <= afterko;
				afterko <= b;
				hereColor <= afterhereColor;
				afterhereColor <= Colorcount;
				swapko <= ko;
				swapcolor <= hereColor;
				nextblock <= '0';
			else
				ko <= afterko;
				afterko <= swapko;
				hereColor <= afterhereColor;
				afterhereColor <= swapcolor;
				swapko <= ko;
				swapcolor <= hereColor;
				nextblock <= '0';
			end if;
			if (ko = 0) then
				for i in 0 to h loop
					aX(i) <= Figures(0,i) mod 2 +4;
					aY(i) <= Figures(0,i) /2 - 1;
				end loop;
			elsif (ko = 1) then
				for i in 0 to h loop
					aX(i) <= Figures(1,i) mod 2 +4;
					aY(i) <= Figures(1,i) /2 - 1;
				end loop;
			elsif (ko = 2) then
				for i in 0 to h loop
					aX(i) <= Figures(2,i) mod 2 +4;
					aY(i) <= Figures(2,i) /2 - 1;
				end loop;
			elsif (ko = 3) then
				for i in 0 to h loop
					aX(i) <= Figures(3,i) mod 2 +4;
					aY(i) <= Figures(3,i) /2 - 1;
				end loop;
			elsif (ko = 4) then
				for i in 0 to h loop
					aX(i) <= Figures(4,i) mod 2 +4;
					aY(i) <= Figures(4,i) /2 - 1;
				end loop;
			elsif (ko = 5) then
				for i in 0 to h loop
					aX(i) <= Figures(5,i) mod 2 +4;
					aY(i) <= Figures(5,i) /2 - 1;
				end loop;
			elsif (ko = 6) then
				for i in 0 to h loop
					aX(i) <= Figures(6,i) mod 2 +4;
					aY(i) <= Figures(6,i) /2 - 1;
				end loop;
			end if;
			if (afterko = 0) then
				for i in 0 to h loop
					bX(i) <= Figures(0,i) mod 2;
					bY(i) <= Figures(0,i) /2;
				end loop;
			elsif (afterko = 1) then
				for i in 0 to h loop
					bX(i) <= Figures(1,i) mod 2;
					bY(i) <= Figures(1,i) /2;
				end loop;
			elsif (afterko = 2) then
				for i in 0 to h loop
					bX(i) <= Figures(2,i) mod 2;
					bY(i) <= Figures(2,i) /2;
				end loop;
			elsif (afterko = 3) then
				for i in 0 to h loop
					bX(i) <= Figures(3,i) mod 2;
					bY(i) <= Figures(3,i) /2;
				end loop;
			elsif (afterko = 4) then
				for i in 0 to h loop
					bX(i) <= Figures(4,i) mod 2;
					bY(i) <= Figures(4,i) /2;
				end loop;
			elsif (afterko = 5) then
				for i in 0 to h loop
					bX(i) <= Figures(5,i) mod 2;
					bY(i) <= Figures(5,i) /2;
				end loop;
			elsif (afterko = 6) then
				for i in 0 to h loop
					bX(i) <= Figures(6,i) mod 2;
					bY(i) <= Figures(6,i) /2;
				end loop;
			end if;
			canbuilt <= '0';
		end if;
		
		
	
	
	for i in 0 to 19 loop
		for j in 0 to 9 loop
			if ((i = aY(0) and j = aX(0)) or (i = aY(1) and j = aX(1)) or (i = aY(2) and j = aX(2)) or (i = aY(3) and j = aX(3))) then
				field2(i,j) <= 1;
			else
				field2(i,j) <= 0;
			end if;
		end loop;
	end loop;
	--block building copy
	
	--block checking	
	for i in 19 downto 0 loop
		check := '0';
		for j in 0 to 9 loop
			if (Field(i,j) = 0) then
				check := '1';
				exit;
			end if;
		end loop;
		if (check = '0') then
			Buzzer <= '1';
			BuzzerA <= '1';
			if (score + scorecount/100 + 10 < 9999) then
				score <= score + scorecount/100 + 10;
			end if;
			for q in i downto 1 loop
				for w in 0 to 9 loop
					Field(q,w) <= Field(q-1,w);
				end loop;
			end loop;
			exit;
		end if;	
	end loop;
	
	
	if (BuzzerA = '1') then
		if (BuzzerTimer = 8) then
			Buzzer <= '0';
			BuzzerA <= '0';
			BuzzerTimer <= 0;
		else
			BuzzerTimer <= BuzzerTimer+1;
		end if;
	end if;
	
	for i in 0 to 19 loop
		for j in 0 to 9 loop
			if ((i = aY(0) and j = aX(0)) or (i = aY(1) and j = aX(1)) or (i = aY(2) and j = aX(2)) or (i = aY(3) and j = aX(3))) then
				field2(i,j) <= 1;
			else
				field2(i,j) <= 0;
			end if;
		end loop;
	end loop;
	
	for i in 0 to 3 loop
		for j in 0 to 1 loop
			if ((i = bY(0) and j = bX(0)) or (i = bY(1) and j = bX(1)) or (i = bY(2) and j = bX(2)) or (i = bY(3) and j = bX(3))) then
				field3(i,j) <= 1;
			else
				field3(i,j) <= 0;
			end if;
		end loop;
	end loop;
	scoreout <= score;
	SHOWSCORE <= score;
	--block checking	
	for i in 19 downto 0 loop
		check := '0';
		for j in 0 to 9 loop
			if (Field(i,j) = 0) then
				check := '1';
				exit;
			end if;
		end loop;
		if (check = '0') then
			for q in i downto 1 loop
				for w in 0 to 9 loop
					Field(q,w) <= Field(q-1,w);
				end loop;
			end loop;
			exit;
		end if;	
	end loop;
	elsif (stage = 0) then
		c <= c+1;
		if (c = 18) then
			c <= 0;
			if (pushfswap = '1') then
				pushfswap <= '0';
			else
				pushfswap <= '1';
			end if;
		end if;
	
		Buzzer <= '0';
		if (start = '1') then
			scorecount <= 0;
			Speaker <= '1';
			Buzzer <= '0';
			Score <= 0;
			difficultycount <= 0;
			difficulty <= 15;
			for i in 0 to 19 loop
				for j in 0 to 9 loop
					field(i,j) <= 0;
					field2(i,j) <= 0;
				end loop;
			end loop;
			canbuilt <= '1';
			stage <= 1;
		end if;
	elsif (stage = 2) then
		if (start = '1') then
			stage <= 0;
		end if;
	end if;
	
	
	
	
	
end if;


--block building

end process;
--draw
process
	begin
	if (stage = 2) then
		if (hPos >= 80 and hPos <= 304 and vPos >= 160 and vPos <= 181) then
	           GameOverAddress <=  std_logic_vector(to_signed((((vPos-160)*225))+(hPos -80),13));
				  RGBOUT <=  GameOverData(1)&GameOverData(0)&GameOverData(4)&GameOverData(3)&GameOverData(2)&GameOverData(7)&GameOverData(6)&GameOverData(5);
	   else
	           RGBOUT <= "00000000";
	   end if;
	elsif (stage = 1) then
			        
		  if((hPos >= StartPointX and hPos  <= StartPointX + 1 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				    RGBOUT <= "10000000";
			elsif((hPos >= StartPointX + 100 and hPos  <= StartPointX + 101 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				    RGBOUT <= "10000000";	
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY and vPos <= StartPointY + 1 )))then
				    RGBOUT <= "10000000";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +400 and vPos <= StartPointY + 401 )))then
				    RGBOUT <= "10000000";	
			elsif((hPos >= StartPointX + 150 and hPos  <= StartPointX + 151 AND (vPos >= StartPointY and vPos <= StartPointY +80 )))then
				    RGBOUT <= "10000000";
			elsif((hPos >= StartPointX + 190 and hPos  <= StartPointX + 191 AND (vPos >= StartPointY and vPos <= StartPointY +80 )))then
				    RGBOUT <= "10000000";	
			elsif((hPos >= StartPointX + 150 and hPos  <= StartPointX + 191 AND (vPos >= StartPointY and vPos <= StartPointY + 1 )))then
				    RGBOUT <= "10000000";
			elsif((hPos >= StartPointX + 150 and hPos  <= StartPointX + 191 AND (vPos >= StartPointY +80 and vPos <= StartPointY + 81 )))then
				    RGBOUT <= "10000000";	
			elsif((hPos >= StartPointX +1 + 150 +10 and hPos  <= boxX + StartPointX +0 + 150 +10) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field3(0,0) = 1)then
			        RGBOUT <= color(afterhereColor);
			elsif((hPos >= StartPointX +1 +10 +150 +10 and hPos  <= boxX + StartPointX + 10 + 150+10) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY ) AND field3(0,1) = 1)then
			        RGBOUT <= color(afterhereColor);	 
			elsif((hPos >= StartPointX +1 + 0 + 150 +10 and hPos  <= boxX + StartPointX +0 + 0 + 150+10) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field3(1,0) = 1)then
                    RGBOUT <= color(afterhereColor);
			elsif((hPos >= StartPointX +1 + 10 + 150+10 and hPos  <= boxX + StartPointX +0 + 10 + 150+10) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field3(1,1) = 1)then
                    RGBOUT <= color(afterhereColor);
			elsif((hPos >= StartPointX +1 + 0 + 150+10 and hPos  <= boxX + StartPointX +0 + 0+ 150+10) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field3(2,0) = 1)then
                    RGBOUT <= color(afterhereColor);
         elsif((hPos >= StartPointX +1 + 10 + 150+10 and hPos  <= boxX + StartPointX +0 + 10 + 150+10) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field3(2,1) = 1)then
                    RGBOUT <= color(afterhereColor);
			elsif((hPos >= StartPointX +1 + 0+150+10 and hPos  <= boxX + StartPointX +0 + 0 + 150+10) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field3(3,0) = 1)then
                    RGBOUT <= color(afterhereColor);
         elsif((hPos >= StartPointX +1 + 10+150+10 and hPos  <= boxX + StartPointX +0 + 10 + 150+10) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field3(3,1) = 1)then
                    RGBOUT <= color(afterhereColor);		 

			elsif (hPos >= 240 and hpos <= 319 and Vpos >= 240 and Vpos <= 399) then
						Cheer1Address <=  std_logic_vector(to_signed((((vPos-240)*80))+(hPos -240),14));
						RGBOUT <= Cheer1Data(1)&Cheer1Data(0)&Cheer1Data(4)&Cheer1Data(3)&Cheer1Data(2)&Cheer1Data(7)&Cheer1Data(6)&Cheer1Data(5);
			elsif((hPos >= StartPointX +1 and hPos  <= boxX + StartPointX +0) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field(0,0) = 1)then
			        RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 +10 and hPos  <= boxX + StartPointX + 10) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY ) AND field(0,1) = 1)then
			        RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 +20 and hPos  <= boxX + StartPointX + 20) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field(0,2) = 1)then
			        RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 +30 and hPos  <= boxX + StartPointX + 30) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field(0,3) = 1)then
			        RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 +40 and hPos  <= boxX + StartPointX + 40) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field(0,4) = 1)then
			        RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 +50 and hPos  <= boxX + StartPointX + 50) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field(0,5) = 1)then
			        RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 +60 and hPos  <= boxX + StartPointX + 60) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field(0,6) = 1)then
			        RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 +70 and hPos  <= boxX + StartPointX + 70) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field(0,7) = 1)then
			        RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 +80 and hPos  <= boxX + StartPointX + 80) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field(0,8) = 1)then
			        RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 +90 and hPos  <= boxX + StartPointX + 90) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field(0,9) = 1)then
			        RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field(1,0) = 1)then
                    RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field(1,1) = 1)then
                    RGBOUT <= "01010010";
			elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field(1,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field(1,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field(1,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field(1,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field(1,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field(1,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field(1,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field(1,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field(2,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field(2,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field(2,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field(2,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field(2,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field(2,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field(2,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field(2,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field(2,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field(2,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field(3,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field(3,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field(3,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field(3,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field(3,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field(3,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field(3,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field(3,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field(3,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field(3,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field(4,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field(4,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field(4,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field(4,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field(4,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field(4,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field(4,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field(4,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field(4,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field(4,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field(5,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field(5,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field(5,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field(5,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field(5,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field(5,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field(5,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field(5,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field(5,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field(5,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field(6,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field(6,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field(6,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field(6,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field(6,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field(6,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field(6,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field(6,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field(6,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field(6,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field(7,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field(7,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field(7,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field(7,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field(7,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field(7,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field(7,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field(7,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field(7,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field(7,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field(8,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field(8,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field(8,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field(8,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field(8,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field(8,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field(8,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field(8,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field(8,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field(8,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field(9,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field(9,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field(9,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field(9,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field(9,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field(9,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field(9,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field(9,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field(9,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field(9,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field(10,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field(10,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field(10,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field(10,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field(10,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field(10,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field(10,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field(10,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field(10,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field(10,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field(11,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field(11,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field(11,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field(11,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field(11,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field(11,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field(11,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field(11,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field(11,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field(11,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field(12,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field(12,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field(12,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field(12,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field(12,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field(12,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field(12,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field(12,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field(12,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field(12,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field(13,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field(13,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field(13,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field(13,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field(13,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field(13,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field(13,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field(13,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field(13,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field(13,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field(14,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field(14,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field(14,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field(14,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field(14,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field(14,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field(14,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field(14,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field(14,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field(14,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field(15,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field(15,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field(15,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field(15,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field(15,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field(15,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field(15,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field(15,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field(15,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field(15,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field(16,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field(16,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field(16,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field(16,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field(16,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field(16,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field(16,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field(16,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field(16,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field(16,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field(17,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field(17,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field(17,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field(17,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field(17,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field(17,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field(17,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field(17,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field(17,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field(17,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field(18,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field(18,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field(18,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field(18,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field(18,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field(18,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field(18,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field(18,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field(18,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field(18,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field(19,0) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field(19,1) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field(19,2) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field(19,3) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field(19,4) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field(19,5) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field(19,6) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field(19,7) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field(19,8) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field(19,9) = 1)then
                    RGBOUT <= "01010010";
            elsif((hPos >= StartPointX +1 and hPos  <= boxX + StartPointX +0) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field2(0,0) = 1)then
            		RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 +10 and hPos  <= boxX + StartPointX + 10) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY ) AND field2(0,1) = 1)then
            		RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 +20 and hPos  <= boxX + StartPointX + 20) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field2(0,2) = 1)then
            		RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 +30 and hPos  <= boxX + StartPointX + 30) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field2(0,3) = 1)then
            		RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 +40 and hPos  <= boxX + StartPointX + 40) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field2(0,4) = 1)then
            		RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 +50 and hPos  <= boxX + StartPointX + 50) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field2(0,5) = 1)then
            		RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 +60 and hPos  <= boxX + StartPointX + 60) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field2(0,6) = 1)then
            		RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 +70 and hPos  <= boxX + StartPointX + 70) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field2(0,7) = 1)then
            		RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 +80 and hPos  <= boxX + StartPointX + 80) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field2(0,8) = 1)then
            		RGBOUT <= color(hereColor);
		      elsif((hPos >= StartPointX +1 +90 and hPos  <= boxX + StartPointX + 90) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND field2(0,9) = 1)then
            		RGBOUT <= color(hereColor);        			
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field2(1,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field2(1,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field2(1,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field2(1,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field2(1,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field2(1,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field2(1,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field2(1,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field2(1,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 20 and vPos <= boxY + StartPointY + 20) AND field2(1,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field2(2,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field2(2,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field2(2,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field2(2,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field2(2,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field2(2,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field2(2,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field2(2,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field2(2,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 40 and vPos <= boxY + StartPointY + 40) AND field2(2,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field2(3,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field2(3,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field2(3,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field2(3,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field2(3,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field2(3,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field2(3,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field2(3,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field2(3,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 60 and vPos <= boxY + StartPointY + 60) AND field2(3,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field2(4,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field2(4,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field2(4,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field2(4,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field2(4,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field2(4,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field2(4,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field2(4,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field2(4,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 80 and vPos <= boxY + StartPointY + 80) AND field2(4,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field2(5,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field2(5,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field2(5,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field2(5,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field2(5,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field2(5,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field2(5,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field2(5,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field2(5,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 100 and vPos <= boxY + StartPointY + 100) AND field2(5,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field2(6,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field2(6,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field2(6,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field2(6,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field2(6,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field2(6,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field2(6,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field2(6,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field2(6,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 120 and vPos <= boxY + StartPointY + 120) AND field2(6,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field2(7,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field2(7,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field2(7,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field2(7,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field2(7,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field2(7,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field2(7,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field2(7,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field2(7,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 140 and vPos <= boxY + StartPointY + 140) AND field2(7,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field2(8,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field2(8,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field2(8,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field2(8,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field2(8,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field2(8,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field2(8,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field2(8,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field2(8,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 160 and vPos <= boxY + StartPointY + 160) AND field2(8,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field2(9,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field2(9,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field2(9,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field2(9,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field2(9,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field2(9,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field2(9,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field2(9,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field2(9,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 180 and vPos <= boxY + StartPointY + 180) AND field2(9,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field2(10,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field2(10,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field2(10,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field2(10,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field2(10,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field2(10,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field2(10,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field2(10,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field2(10,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 200 and vPos <= boxY + StartPointY + 200) AND field2(10,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field2(11,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field2(11,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field2(11,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field2(11,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field2(11,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field2(11,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field2(11,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field2(11,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field2(11,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 220 and vPos <= boxY + StartPointY + 220) AND field2(11,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field2(12,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field2(12,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field2(12,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field2(12,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field2(12,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field2(12,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field2(12,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field2(12,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field2(12,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 240 and vPos <= boxY + StartPointY + 240) AND field2(12,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field2(13,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field2(13,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field2(13,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field2(13,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field2(13,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field2(13,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field2(13,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field2(13,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field2(13,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 260 and vPos <= boxY + StartPointY + 260) AND field2(13,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field2(14,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field2(14,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field2(14,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field2(14,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field2(14,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field2(14,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field2(14,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field2(14,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field2(14,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 280 and vPos <= boxY + StartPointY + 280) AND field2(14,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field2(15,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field2(15,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field2(15,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field2(15,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field2(15,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field2(15,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field2(15,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field2(15,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field2(15,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 300 and vPos <= boxY + StartPointY + 300) AND field2(15,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field2(16,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field2(16,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field2(16,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field2(16,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field2(16,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field2(16,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field2(16,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field2(16,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field2(16,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 320 and vPos <= boxY + StartPointY + 320) AND field2(16,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field2(17,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field2(17,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field2(17,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field2(17,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field2(17,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field2(17,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field2(17,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field2(17,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field2(17,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 340 and vPos <= boxY + StartPointY + 340) AND field2(17,9) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field2(18,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field2(18,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field2(18,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field2(18,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field2(18,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field2(18,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field2(18,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field2(18,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field2(18,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 360 and vPos <= boxY + StartPointY + 360) AND field2(18,9) = 1)then
                    RGBOUT <= color(hereColor);
				elsif((hPos >= StartPointX +1 + 0 and hPos  <= boxX + StartPointX +0 + 0) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field2(19,0) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 10 and hPos  <= boxX + StartPointX +0 + 10) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field2(19,1) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 20 and hPos  <= boxX + StartPointX +0 + 20) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field2(19,2) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 30 and hPos  <= boxX + StartPointX +0 + 30) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field2(19,3) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 40 and hPos  <= boxX + StartPointX +0 + 40) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field2(19,4) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 50 and hPos  <= boxX + StartPointX +0 + 50) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field2(19,5) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 60 and hPos  <= boxX + StartPointX +0 + 60) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field2(19,6) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 70 and hPos  <= boxX + StartPointX +0 + 70) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field2(19,7) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 80 and hPos  <= boxX + StartPointX +0 + 80) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field2(19,8) = 1)then
                    RGBOUT <= color(hereColor);
            elsif((hPos >= StartPointX +1 + 90 and hPos  <= boxX + StartPointX +0 + 90) AND (vPos >= StartPointY +2 + 380 and vPos <= boxY + StartPointY + 380) AND field2(19,9) = 1)then
                    RGBOUT <= color(hereColor);
			else
				RGBOUT <= "00000000";
			end if;
	elsif (stage = 0) then
		if (hPos >= 35 and vPos >= 20 and hPos <= 353 and vPos <= 109) then
			MainMenuAddress <=  std_logic_vector(to_signed((((vPos-20)*319))+(hPos -35),15));
			RGBOUT <= MainMenuData(1)&MainMenuData(0)&MainMenuData(4)&MainMenuData(3)&MainMenuData(2)&MainMenuData(7)&MainMenuData(6)&MainMenuData(5);
		elsif (hPos >= 95 and vPos >= 250 and hPos <= 282 and vPos <= 263 and pushfswap = '1') then
			pushfAddress <=  std_logic_vector(to_signed((((vPos-250)*188))+(hPos -95),12));
			RGBOUT <= pushFData(1)&pushFData(0)&pushFData(4)&pushFData(3)&pushFData(2)&pushFData(7)&pushFData(6)&pushFData(5);
		elsif (hPos >= 95 and vPos >= 250 and hPos <= 282 and vPos <= 263 and pushfswap = '0') then
			RGBOUT <= "00000000";
		elsif (hPos >= 121 and vPos >= 416 and hPos <= 370 and vPos <= 440) then
			MainMenu2Address <=  std_logic_vector(to_signed((((vPos-416)*249))+(hPos -121),13));
			RGBOUT <= MainMenu2Data(1)&MainMenu2Data(0)&MainMenu2Data(4)&MainMenu2Data(3)&MainMenu2Data(2)&MainMenu2Data(7)&MainMenu2Data(6)&MainMenu2Data(5);
		else
			RGBOUT <= "00000000";
		end if;
	end if;
end process;

end Behavioral;



