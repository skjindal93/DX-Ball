----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:11:10 04/17/2011 
-- Design Name: 
-- Module Name:    ball - Behavioral 
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

entity ball is
port (	x: out std_logic_vector(3 downto 0); 
			y: out std_logic_vector(4 downto 0); 
			ad: in std_logic; 
			padup,padwn: in std_logic_vector(2 downto 0):="100";
			nthitup,nthitdwn: out std_logic:='0';
			breset: in std_logic
			);

end ball;

architecture Behavioral of ball is
signal leftright,updwn : std_logic :='0';
signal ballx : std_logic_vector(3 downto 0) := "0100";
signal bally : std_logic_vector(4 downto 0) := "01000";

begin
process(ad)
begin 
if(ad='1')
then 
	if(breset = '1')
	then 
	ballx <= "0100";
	bally <= "01000";
	leftright <= '0';
	nthitup <='0';
	updwn <= '0';
	else
		if (leftright = '1'  and updwn = '1')
		then 
			if	( ballx = "0111")
			then bally <= bally +"01";
				ballx<=ballx - "01";
				leftright <= '0';
				nthitup <='0';
				nthitdwn <='0';
				
			else 
				if(bally = "01110")
				then 
					if(padup = ballx or padup = ballx - 1)
					then ballx <= ballx +"01";
					bally <= bally - "01";
					updwn <= '0';
					nthitup <='0';
					nthitdwn <='0';
					else ballx <= "0100";
					bally <= "01000";
					leftright <= '0';
					nthitup <='1';
					updwn <= '0';
					end if;	
				else  ballx <= ballx + "01";
				bally <= bally + "01";
				nthitup <='0';
				nthitdwn <='0';
				end if;
			end if;
		end if;
	   
		if (leftright = '1'  and updwn = '0')
		then 
			if	( ballx = "0111")
			then bally <= bally -"01";
			ballx<=ballx - "01";
			leftright <= '0';
			nthitup <='0';
			nthitdwn <='0';
				
			else 
				if(bally = "00001")
				then 
					if(padup = ballx or padup = ballx - 1)
					then ballx <= ballx +"01";
					bally <= bally + "01";
					updwn <= '1';
					nthitup <='0';
					nthitdwn <='0';
					else ballx <= "0100";
					bally <= "01000";
					leftright <= '1';
					nthitdwn <='1';
					updwn <= '0';
					end if;	
				else  ballx <= ballx + "01";
				bally <= bally - "01";
				nthitup <='0';
				nthitdwn <='0';
				end if;
			end if;
		end if;
		
		if (leftright = '0'  and updwn = '1')
		then 
			if	( ballx = "0000")
			then bally <= bally +"01";
			ballx<=ballx + "01";
			leftright <= '1';
			nthitup <='0';
			nthitdwn <='0';
				
			else 
				if(bally = "01110")
				then 
					if(padup = ballx or padup = ballx - "01")
					then ballx <= ballx -"01";
					bally <= bally - "01";
					updwn <= '0';
					nthitup <='0';
					nthitdwn <='0';
					else ballx <= "0100";
					bally <= "01000";
					leftright <= '0';
					nthitup <='1';
					updwn <= '0';
					end if;	
				else  ballx <= ballx - "01";
				bally <= bally + "01";
				nthitup <='0';
				nthitdwn <='0';
				end if;
			end if;
		end if;
	   
		
		
		if (leftright = '0'  and updwn = '0')
		then 
			if	( ballx = "0000")
			then bally <= bally -"01";
			ballx<=ballx + "01";
			leftright <= '1';
			nthitup <='0';
			nthitdwn <='0';
			else 	
				if(bally = "00001")
				then 
					if(padup = ballx or padup = ballx - "01")
					then ballx <= ballx -"01";
					bally <= bally + "01";
					updwn <= '1';
					nthitup <='0';
					nthitdwn <='0';
					else ballx <= "0100";
					bally <= "01000";
					leftright <= '1';
					nthitdwn <='1';
					updwn <= '0';
					end if;
				else ballx <= ballx - "01";
				bally <= bally - "01";
				nthitup <='0';
				nthitdwn <='0';
				end if;
			end if;
		end if;
	end if;
end if;
end process;

x<=ballx;
y<=bally;
end Behavioral;