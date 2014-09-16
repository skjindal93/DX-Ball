----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:27:06 04/16/2011 
-- Design Name: 
-- Module Name:    clkdivide - Behavioral 
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

entity clkdivide is
    Port ( clkin : in  STD_LOGIC;
           clkout : out  STD_LOGIC);
end clkdivide;

architecture Behavioral of clkdivide is
component modten is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           counterout : inout  STD_LOGIC_VECTOR (3 downto 0));
end component;
signal four : STD_LOGIC_VECTOR (3 downto 0);
begin
counter1: modten port map (clkin,'0',four);
clkout <= not( four(0) or four(1) or four(2) or four(3)); 
end Behavioral;