----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:36:58 04/22/2011 
-- Design Name: 
-- Module Name:    ball1 - Behavioral 
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

entity ball1 is
port (	x: out std_logic_vector(9 downto 0):=conv_std_logic_vector(128,10); 
			y: out std_logic_vector(8 downto 0):=conv_std_logic_vector(200,9); 
			ad: in std_logic; 
			padup,padwn: in std_logic_vector(9 downto 0);
			nthitup,nthitdwn: out std_logic:='0';
			breset: in std_logic
			);

end ball1;

architecture Behavioral of ball1 is
signal leftright,updwn : std_logic :='0';
signal ballx1: std_logic_vector(9 downto 0);
signal bally1: std_logic_vector(8 downto 0);

begin
process (ad)
variable ballx,padup1,paddwn1 :integer ;
variable bally :integer ;
variable radius :integer := 10;
variable len : integer := 48;
variable br : integer := 10;
begin
if rising_edge(ad)
then
ballx := CONV_INTEGER(ballx1);
bally := CONV_INTEGER(bally1);
padup1 := CONV_INTEGER(padup);
paddwn1 := CONV_INTEGER(padwn);

	if(breset = '1')
	then 
	ballx := 128;
	bally := 200;
	leftright <= '0';
	nthitup <='0';
	updwn <= '0';
	else
		if (leftright = '1'  and updwn = '1')
		then 
			if	( ballx = 255 - radius)
			then bally := bally + 1;
				ballx :=ballx - 1;
				leftright <= '0';
				nthitup <='0';
				nthitdwn <='0';
				
			else 
				if(bally = 400 - br - radius)
				then 
					if(padup1  < ballx and padup1 >ballx-len )
					then ballx := ballx +1;
					bally := bally - 1;
					updwn <= '0';
					nthitup <='0';
					nthitdwn <='0';
					else ballx := 128;
					bally := 200;
					leftright <= '0';
					nthitup <='1';
					updwn <= '0';
					end if;	
				else  ballx := ballx + 1;
				bally := bally + 1;
				nthitup <='0';
				nthitdwn <='0';
				end if;
			end if;
		end if;
	   
		if (leftright = '1'  and updwn = '0')
		then 
			if	( ballx = 255 - radius)
			then bally := bally -1;
			ballx :=ballx - 1;
			leftright <= '0';
			nthitup <='0';
			nthitdwn <='0';
				
			else 
				if(bally = br + radius)
				then 
					if(paddwn1 < ballx and paddwn1 > ballx -len)
					then ballx := ballx +1;
					bally := bally + 1;
					updwn <= '1';
					nthitup <='0';
					nthitdwn <='0';
					else ballx := 128;
					bally := 200;
					leftright <= '1';
					nthitdwn <='1';
					updwn <= '0';
					end if;	
				else  ballx := ballx + 1;
				bally := bally - 1;
				nthitup <='0';
				nthitdwn <='0';
				end if;
			end if;
		end if;
		
		if (leftright = '0'  and updwn = '1')
		then 
			if	( ballx = radius)
			then bally := bally +1;
			ballx :=ballx + 1;
			leftright <= '1';
			nthitup <='0';
			nthitdwn <='0';
				
			else 
				if(bally = 400 - br - radius)
				then 
					if(padup1 < ballx and padup1  > ballx-len )
					then ballx := ballx -1;
					bally := bally - 1;
					updwn <= '0';
					nthitup <='0';
					nthitdwn <='0';
					else ballx := 128;
					bally := 200;
					leftright <= '0';
					nthitup <='1';
					updwn <= '0';
					end if;	
				else  ballx := ballx - 1;
				bally := bally + 1;
				nthitup <='0';
				nthitdwn <='0';
				end if;
			end if;
		end if;
	   
		
		
		if (leftright = '0'  and updwn = '0')
		then 
			if	( ballx = radius)
			then bally := bally -1 ;
			ballx :=ballx + 1;
			leftright <= '1';
			nthitup <='0';
			nthitdwn <='0';
			else 	
				if(bally = br + radius)
				then 
					if(paddwn1 < ballx and paddwn1> (ballx-len) )
					then ballx := ballx -1;
					bally := bally + 1;
					updwn <= '1';
					nthitup <='0';
					nthitdwn <='0';
					else ballx := 128;
					bally := 200;
					leftright <= '1';
					nthitdwn <='1';
					updwn <= '0';
					end if;
				else ballx := ballx - 1;
				bally := bally - 1;
				nthitup <='0';
				nthitdwn <='0';
				end if;
			end if;
		end if;
	end if;

ballx1 <= CONV_STD_LOGIC_VECTOR(ballx,10);
bally1 <= CONV_STD_LOGIC_VECTOR(bally,9);
end if;
end process;

process(ballx1,bally1) begin
x<=ballx1;
y<=bally1;
end process;

end Behavioral;

