----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:21:11 04/20/2011 
-- Design Name: 
-- Module Name:    clk10hz - Behavioral 
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

entity clk100hz is
port(clkin: in std_logic; clkout: out std_logic);
end clk100hz;

architecture Behavioral of clk100hz is
component clkdivide is
Port ( clkin : in  STD_LOGIC;
       clkout : out  STD_LOGIC);
end component;

signal   cr:std_logic_vector(5 downto 0);

begin
cd1: clkdivide port map(clkin,cr(1)); -- 10mhz
cd2: clkdivide port map(cr(1),cr(2)); -- 1mhz
cd3: clkdivide port map(cr(2),cr(3)); -- 100 khz
cd4: clkdivide port map(cr(3),clkout); -- 10 khz
--cd5: clkdivide port map(cr(4),clkout); -- 1 khz
--cd6: clkdivide port map(cr(5),clkout); -- 100 hz
end Behavioral;

