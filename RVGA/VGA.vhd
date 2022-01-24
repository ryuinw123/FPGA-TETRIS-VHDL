----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:57:56 12/11/2020 
-- Design Name: 
-- Module Name:    VGA - Behavioral 
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

entity VGA is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           GameIn : in  STD_LOGIC_VECTOR (199 downto 0);
           GameIn2 : in  STD_LOGIC_VECTOR (199 downto 0);
           HSYNC : out  STD_LOGIC;
           VSYNC : out  STD_LOGIC;
           RGB : out  STD_LOGIC_VECTOR (7 downto 0));
end VGA;

architecture Behavioral of VGA is

	type t_Row_Col is array (0 to 19, 0 to 9) of integer range 0 to 9;
	signal game : t_Row_Col;

	signal start : std_logic := '0';
	
	
	signal clk25 : std_logic := '0';
	signal clksee : std_logic := '1';
	
	constant HD : integer := 399;  --  639   Horizontal Display (640)
	constant HFP : integer := 20;         --   16   Right border (front porch)
	constant HSP : integer := 64;       --   96   Sync pulse (Retrace)
	constant HBP : integer := 44;        --   48   Left boarder (back porch)
	
	constant VD : integer := 479;   --  479   Vertical Display (480)
	constant VFP : integer := 10;       	 --   10   Right border (front porch)
	constant VSP : integer := 2;				 --    2   Sync pulse (Retrace)
	constant VBP : integer := 33;       --   33   Left boarder (back porch)
	
	constant BoxX : integer := 9;
	constant BoxY : integer := 19;
	
	
	signal hPos : integer := 0;
	signal vPos : integer := 0;
	
	signal videoOn : std_logic := '0';
	signal StartPointX : integer := 145;
	signal StartPointY : integer := 30;
	signal locationx : integer := 0;
	signal locationy : integer := 0;


begin

clk_div:process(CLK)
begin
	clk25 <= CLK;
end process;

Horizontal_position_counter:process(clk25, RST)
begin
	if(RST = '1')then
		hpos <= 0;
	elsif(clk25'event and clk25 = '1')then
		if (hPos = (HD + HFP + HSP + HBP)) then
			hPos <= 0;
		else
			hPos <= hPos + 1;
		end if;
	end if;
end process;

Vertical_position_counter:process(clk25, RST, hPos)
begin
	if(RST = '1')then
		vPos <= 0;
	elsif(clk25'event and clk25 = '1')then
		if(hPos = (HD + HFP + HSP + HBP))then
			if (vPos = (VD + VFP + VSP + VBP)) then
				vPos <= 0;
			else
				vPos <= vPos + 1;
			end if;
		end if;
	end if;
end process;

Horizontal_Synchronisation:process(clk25, RST, hPos)
begin
	if(RST = '1')then
		HSYNC <= '0';
	elsif(clk25'event and clk25 = '1')then
		if((hPos <= (HD + HFP)) OR (hPos > HD + HFP + HSP))then
			HSYNC <= '1';
		else
			HSYNC <= '0';
		end if;
	end if;
end process;

Vertical_Synchronisation:process(clk25, RST, vPos)
begin
	if(RST = '1')then
		VSYNC <= '0';
	elsif(clk25'event and clk25 = '1')then
		if((vPos <= (VD + VFP)) OR (vPos > VD + VFP + VSP))then
			VSYNC <= '1';
		else
			VSYNC <= '0';
		end if;
	end if;
end process;

video_on:process(clk25, RST, hPos, vPos)
begin
	if(RST = '1')then
		videoOn <= '0';
	elsif(clk25'event and clk25 = '1')then
		if(hPos <= HD and vPos <= VD)then
			videoOn <= '1';
		else
			videoOn <= '0';
		end if;
	end if;
end process;
-------------------------------------------------------------------------------------


drawtable:process(clk25, RST, hPos, vPos, videoOn, game) --hpos 0 - 383 vpos 0 - 450
begin
	for i in 0 to 199 loop
		if (TEST(i) = '1') then
			game(i/10,i mod 10) <= 1;
		end if;
	end loop;
	
	
	
	if(RST = '1')then
		RGB <= "00000000";
	elsif(clk25'event and clk25 = '1')then
		if(videoOn = '1')then		
			--for i in 0 to 10 loop
			if((hPos >= StartPointX and hPos  <= StartPointX + 1 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				RGB <= "10000000";
			elsif((hPos >= StartPointX + 10 and hPos  <= StartPointX + 11 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX + 20 and hPos  <= StartPointX + 21 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX + 30 and hPos  <= StartPointX + 31 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX + 40 and hPos  <= StartPointX + 41 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX + 50 and hPos  <= StartPointX + 51 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX + 60 and hPos  <= StartPointX + 61 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX + 70 and hPos  <= StartPointX + 71 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX + 80 and hPos  <= StartPointX + 81 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX + 90 and hPos  <= StartPointX + 91 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX + 100 and hPos  <= StartPointX + 101 AND (vPos >= StartPointY and vPos <= StartPointY +400 )))then
				RGB <= "10000000";
				
				
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY and vPos <= StartPointY + 1 )))then
				RGB <= "10000000";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +20 and vPos <= StartPointY + 21 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +40 and vPos <= StartPointY + 41 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +60 and vPos <= StartPointY + 61 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +80 and vPos <= StartPointY + 81 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +100 and vPos <= StartPointY + 101 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +120 and vPos <= StartPointY + 121 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +140 and vPos <= StartPointY + 141 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +160 and vPos <= StartPointY + 161 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +180 and vPos <= StartPointY + 181 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +200 and vPos <= StartPointY + 201 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +220 and vPos <= StartPointY + 221 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +240 and vPos <= StartPointY + 241 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +260 and vPos <= StartPointY + 261 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +280 and vPos <= StartPointY + 281 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +300 and vPos <= StartPointY + 301 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +320 and vPos <= StartPointY + 321 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +340 and vPos <= StartPointY + 341 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +360 and vPos <= StartPointY + 361 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +380 and vPos <= StartPointY + 381 )))then
				RGB <= "10010010";
			elsif((hPos >= StartPointX and hPos  <= StartPointX + 100 AND (vPos >= StartPointY +400 and vPos <= StartPointY + 401 )))then
				RGB <= "10000000";


			elsif((hPos >= StartPointX +1 and hPos  <= boxX + StartPointX +0) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,0) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +10 and hPos  <= boxX + StartPointX + 10) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY ) AND game(0,1) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +20 and hPos  <= boxX + StartPointX + 20) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,2) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +30 and hPos  <= boxX + StartPointX + 30) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,3) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +40 and hPos  <= boxX + StartPointX + 40) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,4) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +50 and hPos  <= boxX + StartPointX + 50) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,5) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +60 and hPos  <= boxX + StartPointX + 60) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,6) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +70 and hPos  <= boxX + StartPointX + 70) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,7) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +80 and hPos  <= boxX + StartPointX + 80) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,8) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +90 and hPos  <= boxX + StartPointX + 90) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,9) = 1)then
			RGB <= "00111000";
			
			elsif((hPos >= StartPointX +1 and hPos  <= boxX + StartPointX +0) AND (vPos >= StartPointY +2  and vPos <= boxY + StartPointY + 20) AND game(0,0) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +10 and hPos  <= boxX + StartPointX + 10) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY + 20) AND game(0,1) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +20 and hPos  <= boxX + StartPointX + 20) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,2) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +30 and hPos  <= boxX + StartPointX + 30) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,3) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +40 and hPos  <= boxX + StartPointX + 40) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,4) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +50 and hPos  <= boxX + StartPointX + 50) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,5) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +60 and hPos  <= boxX + StartPointX + 60) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,6) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +70 and hPos  <= boxX + StartPointX + 70) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,7) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +80 and hPos  <= boxX + StartPointX + 80) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,8) = 1)then
			RGB <= "00111000";
			elsif((hPos >= StartPointX +1 +90 and hPos  <= boxX + StartPointX + 90) AND (vPos >= StartPointY +2 and vPos <= boxY + StartPointY) AND game(0,9) = 1)then
			RGB <= "00111000";
			
			else
				RGB <= "00000000";
			end if;

			--end loop;
			
		else
			RGB <= "00000000";
		end if;
	end if;
end process;


end Behavioral;

