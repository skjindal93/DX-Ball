----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:15:21 04/20/2011 
-- Design Name: 
-- Module Name:    debounce - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce is
port(inp,clkin: in std_logic; outp: out std_logic);
end debounce;

architecture Behavioral of debounce is

component clkdivide
port(clkin:in std_logic; clkout:out std_logic);
end component;

component clk10hz is
Port ( clkin : in  STD_LOGIC;
       clkout : out  STD_LOGIC
		 );
end component;

signal clkslow,clk5hz,clkslow1,start: std_logic:='0';
signal count: std_logic_vector(2 downto 0):="000";

begin

cls: clk10hz port map(clkin,clkslow);
cd: clkdivide port map(clkslow,clkslow1);

process (inp,clkslow1) begin
if start='0' and rising_edge(inp) then outp<='1';start<='1'; end if;
if start='1' and rising_edge(clkslow1) then count<=count+'1'; end if;
if count="010" then outp<='0'; end if;
if start='1' and count="011" then start<='0'; count<="000"; outp<='0';end if;
end process;

end Behavioral;