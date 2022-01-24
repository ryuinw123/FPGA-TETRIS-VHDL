----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:17:27 12/28/2016 
-- Design Name: 
-- Module Name:    vga_driver - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_driver is
  Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  RGBIN : in  STD_LOGIC_VECTOR (7 downto 0);
			  X : OUT natural range 0 to 1000;
			  Y : Out natural range 0 to 1000;
           HSYNC : out  STD_LOGIC;
           VSYNC : out  STD_LOGIC;
           RGB : out  STD_LOGIC_VECTOR (7 downto 0));	  
end vga_driver;

architecture Behavioral of vga_driver is
	type t_Row_Col is array (0 to 19, 0 to 9) of integer range 0 to 9;
	signal game : t_Row_Col;
	signal game2 : t_Row_Col;
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
	
	if(RST = '1')then
		RGB <= "00000000";
	elsif(clk25'event and clk25 = '1')then
		if(videoOn = '1')then
			x <= hPos;
			y <= vPos;
			RGB <= RGBIN;
		else
			RGB <= "00000000";
		end if;
	end if;
end process;


end Behavioral;

