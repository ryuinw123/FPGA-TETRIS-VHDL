library IEEE;
 
use IEEE.STD_LOGIC_1164.ALL;
 
use IEEE.numeric_std.ALL;
 
entity clock_divider is
 
port ( clk,reset: in std_logic;
 
clockout: out std_logic);
 
end clock_divider;
 
architecture bhv of clock_divider is
 
signal count: integer:=1;
 
signal tmp : std_logic := '0';
 
begin
 
process(clk,reset)
 
begin
 
if(reset='1') then
 
count<=1;
 
tmp<='0';
 
elsif rising_edge(clk) then
 
count <=count+1;
 
if (count = 10) then
 
tmp <= NOT tmp;
 
count <= 1;
 
end if;
 
end if;
 
clockout <= tmp;
 
end process;
 
end bhv;
