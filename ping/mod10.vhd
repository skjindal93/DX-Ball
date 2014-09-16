----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity modten is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           counterout : inout  STD_LOGIC_VECTOR (3 downto 0):="0000");
end modten;

architecture Behavioral of modten is
begin
process(clk,reset)
begin
if reset = '1' then counterout <= "0000";
else if (clk='1' and not(counterout="1001")) then counterout<= counterout + '1';
else if (clk='1' and (counterout="1001")) then counterout<= "0000";
else counterout <= counterout;
end if;end if; end if;
--else CASE counterout IS
--WHEN "0000"=>counterout<="0001";-
--WHEN "0001"=>counterout<="0010";
--WHEN "0010"=>counterout<="0011";
--WHEN "0011"=>counterout<="0100";
--WHEN "0100"=>counterout<="0101";
--WHEN "0101"=>counterout<="0110";
--WHEN "0110"=>counterout<="0111";
--WHEN "0111"=>counterout<="1000";
--WHEN "1000"=>counterout<="1001";
--WHEN OTHERS=>counterout<="0000";
--END CASE;
end process;


end Behavioral;