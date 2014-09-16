----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:53:21 04/19/2011 
-- Design Name: 
-- Module Name:    decode4 - Behavioral 
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

entity decode4 is
port(rowno : in std_logic_vector(3 downto 0);
		rownodec : out std_logic_vector(15 downto 0));

end decode4;

architecture Behavioral of decode4 is

begin
process begin
if(rowno = "0000")
then rownodec <= "0000000000000001";
end if;
if(rowno = "0001")
then rownodec <= "0000000000000010";
end if;
if(rowno = "0010")
then rownodec <= "0000000000000100";
end if;
if(rowno = "0011")
then rownodec <= "0000000000001000";
end if;
if(rowno = "0100")
then rownodec <= "0000000000010000";
end if;
if(rowno = "0101")
then rownodec <= "0000000000100000";
end if;
if(rowno = "0110")
then rownodec <= "0000000001000000";
end if;
if(rowno = "0111")
then rownodec <= "0000000010000000";
end if;

if(rowno = "1000")
then rownodec <= "0000000100000000";
end if;
if(rowno = "1001")
then rownodec <= "0000001000000000";
end if;
if(rowno = "1010")
then rownodec <= "0000010000000000";
end if;
if(rowno = "1011")
then rownodec <= "0000100000000000";
end if;
if(rowno = "1100")
then rownodec <= "0001000000000000";
end if;
if(rowno = "1101")
then rownodec <= "0010000000000000";
end if;
if(rowno = "1110")
then rownodec <= "0100000000000000";
end if;
if(rowno = "1111")
then rownodec <= "1000000000000000";
end if;
end process;

end Behavioral;

