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
use IEEE.numeric_std.all;

package array_b is
type arr is array (3 downto 0) of std_logic_vector(9 downto 0);
end array_b;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.array_b.ALL;
use work.divide.all;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ball1 is
port (	x: out std_logic_vector(9 downto 0):=conv_std_logic_vector(128,10); 
			y: out std_logic_vector(8 downto 0):=conv_std_logic_vector(200,9); 
			ad: in std_logic;
			brick:in std_logic_vector(39 downto 0);
			brickout:out std_logic_vector(39 downto 0);
			scorep:out std_logic_vector(6 downto 0);
			soundPin : out STD_LOGIC_VECTOR(1 downto 0);
			padwn: in std_logic_vector(9 downto 0);
			lives:out std_logic_vector(2 downto 0);
			nthitdwn: out std_logic:='0'; ----------------------remove nthitup k
			breset: in std_logic
			
			);

end ball1;

architecture Behavioral of ball1 is
type int_array is array (0 to 31) of integer range 0 to 255;
signal leftright,updwn : std_logic :='0';
signal ballx1: std_logic_vector(9 downto 0);
signal bally1: std_logic_vector(8 downto 0);
signal live:std_logic_vector(2 downto 0):="010";
signal tempo:std_logic_vector(39 downto 0):="1111111111111111111111111111111111111111";
signal scoreo:std_logic_vector(6 downto 0):="0000000";
signal soundCounter : integer range 0 to 1000000 := 0;
signal sp : std_logic := '0';
signal soundClock : STD_LOGIC := '0';
signal soundPlingCounter : integer range 0 to 100000000 := 0;
signal soundEnable : STD_LOGIC := '0';
signal playSound : STD_LOGIC_VECTOR(1 downto 0) := "00";
shared variable ballx,padup1,paddwn1 :integer ;
shared variable bally :integer ;
shared variable radius :integer := 5;
shared variable len : integer := 80;
shared variable br : integer := 10;
shared variable brickx:integer;
shared variable bricky:integer;
shared variable index:integer;
shared variable xindex:integer;
shared variable yindex:integer;
shared variable brickxo:integer;
shared variable brickyo:integer;
shared variable indexo:integer;
shared variable xindexo:integer;
shared variable yindexo:integer;
shared variable deltax:integer:=1;
shared variable livetemp:integer;
begin
process(ad)
begin
if rising_edge(ad)
then
ballx := CONV_INTEGER(ballx1);
bally := CONV_INTEGER(bally1);
livetemp:=CONV_INTEGER(live);

--if ((bally+radius>=380) and (bally+radius<=440)) then
	--brickx:=8;
	--bricky:=0;
	--if ((leftright='0') and (updwn='1')) then
		--if ((ballx+radius+1>=(62*(brickx+1))) and (brick(bricky*10+9-(brickx+1))='1')) then
			--brickout((bricky*10+9-(brickx+1)))<='0';
			--leftright<='1';
			--ballx:=ballx-1;
		--	bally:=bally+1;
		--elsif ((bally+radius+1-380>=(15*(bricky+1))) and (brick((bricky+1)*10+9-brickx)='1')) then
			--	brickout(((bricky+1)*10+9-brickx))<='0';
				--updwn<='0';
				--ballx:=ballx+1;
				--bally:=bally-1;
		--end if;
	--end if;
--end if;
	
	if ((bally+radius>=380)) then	
		if ((leftright='0') and (updwn='1')) then
			xindex:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((ballx),10),CONV_STD_LOGIC_VECTOR(62,10)));
			yindex:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((bally+radius-380),11),CONV_STD_LOGIC_VECTOR(15,11)));
			index:=(3-yindex)*10+xindex;
			brickx:=62*(index-10*(CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR(index,7),CONV_STD_LOGIC_VECTOR(10,7)))));
			bricky:=380+15*(3-CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR(index,7),CONV_STD_LOGIC_VECTOR(10,7))));
			if ((ballx>=brickx) and (tempo(index)='1')) then
				if ((bally+radius>=bricky)) then
					tempo(index)<='0';
					leftright<='0';
					updwn<='0';
					ballx:=ballx-deltax;
					bally:=bally-1;
					playSound <= "01";
					--scoreo<=std_logic_vector(unsigned(scoreo)+1);
					scoreo<=CONV_STD_LOGIC_VECTOR((CONV_INTEGER(scoreo)+1),7);
				end if;
			end if;
			xindexo:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((ballx-radius),10),CONV_STD_LOGIC_VECTOR(62,10)));
			yindexo:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((bally-380),11),CONV_STD_LOGIC_VECTOR(15,11)));
			indexo:=(3-yindexo)*10+xindexo;
			brickxo:=62*(indexo-10*(CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR(indexo,7),CONV_STD_LOGIC_VECTOR(10,7)))));
			brickyo:=380+15*(3-CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR(indexo,7),CONV_STD_LOGIC_VECTOR(10,7))));
			if ((indexo-10*CONV_INTEGER(divide(CONV_STD_LOGIC_VECTOR(indexo,7),CONV_STD_LOGIC_VECTOR(10,7))))/=0) then
				if ((ballx-radius<=brickxo) and (tempo(indexo-1)='1')) then
					if ((bally<=brickyo+15) and bally>=brickyo) then
						tempo(indexo-1)<='0';
						leftright<='1';                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
						updwn<='1';
						ballx:=ballx+deltax;
						bally:=bally+1;
						playSound <= "01";
						scoreo<=CONV_STD_LOGIC_VECTOR((CONV_INTEGER(scoreo)+1),7);
						--scoreo<=std_logic_vector(unsigned(scoreo)+1);
					end if;
				end if;
			end if;
		elsif ((leftright='1') and (updwn='1')) then
			xindex:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((ballx),10),CONV_STD_LOGIC_VECTOR(62,10)));
			yindex:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((bally+radius-380),11),CONV_STD_LOGIC_VECTOR(15,11)));
			index:=(3-yindex)*10+xindex;
			brickx:=62*(index-10*(CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR(index,7),CONV_STD_LOGIC_VECTOR(10,7)))));
			bricky:=380+15*(3-CONV_INTEGER(divide(CONV_STD_LOGIC_VECTOR(index,7),CONV_STD_LOGIC_VECTOR(10,7))));
			if ((ballx>=brickx) and (tempo(index)='1')) then
				if ((bally+radius>=bricky)) then
					tempo(index)<='0';
					leftright<='1';
					updwn<='0';
					ballx:=ballx+deltax;
					bally:=bally-1;
					playSound <= "01";
					scoreo<=CONV_STD_LOGIC_VECTOR((CONV_INTEGER(scoreo)+1),7);
					--scoreo<=std_logic_vector(unsigned(scoreo)+1);
				end if;
			end if;
			xindexo:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((ballx+radius),10),CONV_STD_LOGIC_VECTOR(62,10)));
			yindexo:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((bally-380),11),CONV_STD_LOGIC_VECTOR(15,11)));
			indexo:=(3-yindexo)*10+xindexo;
			brickxo:=62*(indexo-10*(CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR(indexo,7),CONV_STD_LOGIC_VECTOR(10,7)))));
			brickyo:=380+15*(3-CONV_INTEGER(divide(CONV_STD_LOGIC_VECTOR(indexo,7),CONV_STD_LOGIC_VECTOR(10,7))));
			if ((ballx+radius>=brickxo+62) and (tempo(indexo+1)='1')) then
				if ((bally<=brickyo+15) and bally>=brickyo) then
					tempo(indexo+1)<='0';
					leftright<='0';
					updwn<='1';
					ballx:=ballx-deltax;
					bally:=bally+1;
					playSound <= "01";
					scoreo<=CONV_STD_LOGIC_VECTOR((CONV_INTEGER(scoreo)+1),7);
					--scoreo<=std_logic_vector(unsigned(scoreo)+1);
				end if;
			end if;
		elsif ((leftright='0') and (updwn='0')) then
			xindex:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((ballx),10),CONV_STD_LOGIC_VECTOR(62,10)));
			yindex:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((bally-radius-380),11),CONV_STD_LOGIC_VECTOR(15,11)));
			index:=(3-yindex)*10+xindex;
			brickx:=62*(index-10*(CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR(index,7),CONV_STD_LOGIC_VECTOR(10,7)))));
			bricky:=380+15*(3-CONV_INTEGER(divide(CONV_STD_LOGIC_VECTOR(index,7),CONV_STD_LOGIC_VECTOR(10,7))));
			if ((ballx>=brickx) and (tempo(index+10)='1')) then
				if ((bally-radius>=bricky)) then
					tempo(index+10)<='0';
					leftright<='0';
					updwn<='1';
					ballx:=ballx-deltax;
					bally:=bally+1;
					playSound <= "01";
					scoreo<=CONV_STD_LOGIC_VECTOR((CONV_INTEGER(scoreo)+1),7);
					--scoreo<=std_logic_vector(unsigned(scoreo)+1);
				end if;
			end if;
			xindexo:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((ballx-radius),10),CONV_STD_LOGIC_VECTOR(62,10)));
			yindexo:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((bally-380),11),CONV_STD_LOGIC_VECTOR(15,11)));
			indexo:=(3-yindexo)*10+xindexo;
			brickxo:=62*(indexo-10*(CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR(indexo,7),CONV_STD_LOGIC_VECTOR(10,7)))));
			brickyo:=380+15*(3-CONV_INTEGER(divide(CONV_STD_LOGIC_VECTOR(indexo,7),CONV_STD_LOGIC_VECTOR(10,7))));
			if ((ballx-radius<=brickxo) and (tempo(indexo-1)='1')) then 
				if ((bally<=brickyo+15) and bally>=brickyo) then
					tempo(indexo-1)<='0';
					leftright<='1';
					updwn<='0';
					ballx:=ballx+deltax;
					bally:=bally-1;
					playSound <= "01";
					scoreo<=CONV_STD_LOGIC_VECTOR((CONV_INTEGER(scoreo)+1),7);
					--scoreo<=std_logic_vector(unsigned(scoreo)+1);
				end if;
			end if;
		elsif ((leftright='1') and (updwn='0')) then
			xindex:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((ballx),10),CONV_STD_LOGIC_VECTOR(62,10)));
			yindex:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((bally-radius-380),11),CONV_STD_LOGIC_VECTOR(15,11)));
			index:=(3-yindex)*10+xindex;
			brickx:=62*(index-10*(CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR(index,7),CONV_STD_LOGIC_VECTOR(10,7)))));
			bricky:=380+15*(3-CONV_INTEGER(divide(CONV_STD_LOGIC_VECTOR(index,7),CONV_STD_LOGIC_VECTOR(10,7))));
			if ((ballx>=brickx) and (tempo(index+10)='1')) then
				if ((bally-radius>=bricky)) then
					tempo(index+10)<='0';
					leftright<='1';
					updwn<='1';
					ballx:=ballx+deltax;
					bally:=bally+1;
					playSound <= "01";
					scoreo<=CONV_STD_LOGIC_VECTOR((CONV_INTEGER(scoreo)+1),7);
					--scoreo<=std_logic_vector(unsigned(scoreo)+1);
				end if;
			end if;
			xindexo:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((ballx+radius),10),CONV_STD_LOGIC_VECTOR(62,10)));
			yindexo:=CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR((bally-380),11),CONV_STD_LOGIC_VECTOR(15,11)));
			indexo:=(3-yindexo)*10+xindexo;
			brickxo:=62*(indexo-10*(CONV_INTEGER(divide (CONV_STD_LOGIC_VECTOR(indexo,7),CONV_STD_LOGIC_VECTOR(10,7)))));
			brickyo:=380+15*(3-CONV_INTEGER(divide(CONV_STD_LOGIC_VECTOR(indexo,7),CONV_STD_LOGIC_VECTOR(10,7))));
			if ((ballx+radius>=brickxo) and (tempo(indexo)='1')) then 
				if ((bally<=brickyo+15) and bally>=brickyo) then
					tempo(indexo)<='0';
					leftright<='0';
					updwn<='0';
					ballx:=ballx-deltax;
					bally:=bally-1;
					playSound <= "01";
					scoreo<=CONV_STD_LOGIC_VECTOR((CONV_INTEGER(scoreo)+1),7);
					--scoreo<=std_logic_vector(unsigned(scoreo)+1);
				end if;
			end if;
		end if;
	else 
		playSound<="00";
	end if;
paddwn1 := CONV_INTEGER(padwn);
if (livetemp=0) then
	ballx := CONV_INTEGER(padwn)+(len/2);
	bally := 10+radius;
	deltax:=1;
	tempo<="1111111111111111111111111111111111111111";
	scoreo<="0000000";
	livetemp:=3;
	leftright <= '1';
	updwn <= '1';
end if;
	if(breset = '1')
	then 
	ballx := CONV_INTEGER(padwn)+(len/2);
	bally := 10+radius;
	deltax:=1;
	tempo<="1111111111111111111111111111111111111111";
	scoreo<="0000000";
	livetemp:=3;
	leftright <= '1';
	updwn <= '1';
	else
		if (leftright = '1'  and updwn = '1')
		then 
			if	( ballx >= 620 - radius) then 
				bally := bally + 1;
				ballx :=ballx - deltax;
				leftright <= '0';
				nthitdwn <='0';
				
			else 
				if(bally >= 440 - radius)then 
					ballx := ballx +deltax;
					bally := bally - 1;
					updwn <= '0';
					nthitdwn <='0';	
				else  
					ballx := ballx + deltax;
					bally := bally + 1;
					nthitdwn <='0';
				end if;
			end if;
		end if;
	   
		if (leftright = '1'  and updwn = '0')
		then 
			if	( ballx >= 620 - radius)
			then bally := bally -1;
			ballx :=ballx - deltax;
			leftright <= '0';
			nthitdwn <='0';
			else 
				if(bally = br + radius)
				then 
					if(paddwn1+20 <= ballx and paddwn1-20>= ballx -len)
					then 
					deltax:=1;
					ballx := ballx +deltax;
					bally := bally + 1;
					updwn <= '1';
					nthitdwn <='0';
					elsif ((paddwn1 < ballx and paddwn1+20>ballx) or (paddwn1-20<ballx-len and paddwn1> ballx -len))
					then 
					deltax:=2;
					ballx := ballx +deltax;
					bally := bally + 1;
					updwn <= '1';
					nthitdwn <='0';
				else    -------------------------try to put breset='1'in this else only.
					ballx := CONV_INTEGER(padwn)+(len/2);
					bally := 10;
					deltax:=1;
					livetemp:=livetemp-1;
					leftright <= '1';
					nthitdwn <='1';
					updwn <= '1';
					end if;	
				else  
				ballx := ballx + deltax;
				bally := bally - 1;
				nthitdwn <='0';
				end if;
			end if;
		end if;
		if (leftright = '0'  and updwn = '1') then 
			if	( ballx <= radius)
			then bally := bally +1;
			ballx :=ballx + deltax;
			leftright <= '1';
			nthitdwn <='0';
			else 
				if(bally = 440 - radius) then 
					ballx := ballx -deltax;
					bally := bally - 1;
					updwn <= '0';
					nthitdwn <='0';	
				else  
					ballx := ballx - deltax;
					bally := bally + 1;
					nthitdwn <='0';
				end if;
			end if;
		end if;
	   
		
		
		if (leftright = '0'  and updwn = '0')
		then 
			if	( ballx <= radius) then 
				bally := bally -1 ;
				ballx :=ballx + deltax;
				leftright <= '1';
				nthitdwn <='0';
			else 	
				if(bally = br + radius)
				then 
					if(paddwn1+20 <= ballx and paddwn1-20>= ballx -len)
					
					then 
					deltax:=1;
					ballx := ballx -deltax;
					bally := bally + 1;
					updwn <= '1';
					nthitdwn <='0';
					elsif ((paddwn1 < ballx and paddwn1+20>ballx) or (paddwn1-20<ballx-len and paddwn1> ballx -len))
					then 
					deltax:=2;
					ballx := ballx -deltax;
					bally := bally + 1;
					updwn <= '1';
					nthitdwn <='0';
					else -------------------------try to put breset='1'in this else only.
						ballx := CONV_INTEGER(padwn)+(len/2);
						bally := 10+radius;
						deltax:=1;
						livetemp:=livetemp-1;
						leftright <= '1';
						nthitdwn <='1';
						updwn <= '1';
					end if;
				else 
					ballx := ballx - deltax;
					bally := bally - 1;
					nthitdwn <='0';
				end if;
			end if;
		end if;
	end if;

ballx1 <= CONV_STD_LOGIC_VECTOR(ballx,10);
bally1 <= CONV_STD_LOGIC_VECTOR(bally,9);
live<=CONV_STD_LOGIC_VECTOR(livetemp,3);
brickout<=tempo;
scorep<=scoreo;
soundPin<=playSound;
end if;
end process;

process(ballx1,bally1,live) begin
x<=ballx1;
y<=bally1;
lives<=live;
end process;

end Behavioral;

