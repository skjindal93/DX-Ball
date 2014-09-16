----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:47:04 04/19/2011 
-- Design Name: 
-- Module Name:    decoder3 - Behavioral 
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

entity decoder3 is
port(colno : in std_logic_vector(2 downto 0);
		colnodec : out std_logic_vector(7 downto 0));
end decoder3;

architecture Behavioral of decoder3 is

begin
process begin
if(colno = "000")
then colnodec <= "00000001";
end if;
if(colno = "001")
then colnodec <= "00000010";
end if;
if(colno = "010")
then colnodec <= "00000100";
end if;
if(colno = "011")
then colnodec <= "00001000";
end if;
if(colno = "100")
then colnodec <= "00010000";
end if;
if(colno = "101")
then colnodec <= "00100000";
end if;
if(colno = "110")
then colnodec <= "01000000";
end if;
if(colno = "111")
then colnodec <= "10000000";
end if;
end process;
end Behavioral;

