----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:43:12 04/17/2011 
-- Design Name: 
-- Module Name:    mainc - Behavioral 
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

entity mainc is
    Port ( 	start : in  STD_LOGIC;
				clk : in std_logic;
				reset : in std_logic;
				--playerd
				leftdd,rightdd : in std_logic;
				--playeru
				leftuu,rightuu : in std_logic;
				speed : in std_logic;
				ballx : out std_logic_vector(9 downto 0);
				bally : out std_logic_vector(8 downto 0);
				padup: out std_logic_vector(9 downto 0);
				padwn: out std_logic_vector(9 downto 0);
				score : out std_logic_vector(7 downto 0);
				togscore : out std_logic_vector(1 downto 0)
				);
end mainc;

architecture Behavioral of mainc is
component ball 
port (	x: out std_logic_vector(3 downto 0); 
			y: out std_logic_vector(4 downto 0); 
			ad: in std_logic; 
			padup,padwn: in std_logic_vector(2 downto 0); 
			nthitup,nthitdwn: out std_logic;
			breset: in std_logic
			);
end component;

component debounce
port(inp,clkin: in std_logic; outp: out std_logic);
end component;

component clkdivide
port(clkin:in std_logic;clkout: out std_logic);
end component;

component clk10hz is
port(clkin: in std_logic; clkout: out std_logic);
end component;

component display is
port(	clk:in std_logic; 
		padup,padown,ballx:in std_logic_vector(2 downto 0); 
		bally:in std_logic_vector(3 downto 0); 
		y: out std_logic_vector(15 downto 0); 
		x: out std_logic_vector(7 downto 0));
end component;


signal 	x: std_logic_vector(2 downto 0):="100"; 
signal	y: std_logic_vector(3 downto 0):="1000";
signal	xx: std_logic_vector(3 downto 0);
signal	yy: std_logic_vector(4 downto 0);
signal	ad:std_logic; 
signal	padup,padwn: std_logic_vector(2 downto 0); 
signal	padupcal: std_logic_vector(3 downto 0):="0100"; 
signal 	padwncal: std_logic_vector(3 downto 0):="0100"; 
signal	nthitup,nthitdwn: std_logic;
signal   breset: std_logic;
signal   led,rid,leu,riu: std_logic;
signal   cr:std_logic_vector(7 downto 0);
signal 	clkslow,clkpad,clkslow1: std_logic;
signal 	leftd,rightd,leftu,rightu: std_logic;

begin

di: display port map(clk,padup, padwn,x,y,row, column);
b0: ball port map(xx,yy,ad,padup,padwn,nthitup,nthitdwn,breset);
--d0: debounce port map(leftd,clk,led);
--d1: debounce port map(leftu,clk,leu);
--d2: debounce port map(rightd,clk,rid);
--d3: debounce port map(rightu,clk,riu);
cls: clk10hz port map(clk,clkslow);
clpd: clk10hz port map(clk,clkpad);
clkk: clkdivide port map(clkslow,clkslow1);
led<=leftd;
leu<=leftu;
rid<=rightd;
riu<=rightu;
process (clkslow) begin
if led='1' and rid = '0' and padwncal>"0000" then padwncal<=padwncal-'1'; else
if rid='1' and led ='0' and padwncal<"0110" then padwncal<=padwncal+'1'; end if;end if;
end process;

process(clkslow) begin
if leu='1' and riu = '0' and padupcal>"0000" then padupcal<=padupcal-'1'; else
if riu='1' and leu = '0' and padupcal<"0110" then padupcal<=padupcal+'1'; end if; end if;
end process;

padwn(0)<=padwncal(0);
padwn(1)<=padwncal(1);
padwn(2)<=padwncal(2);

padup(0)<=padupcal(0);
padup(1)<=padupcal(1);
padup(2)<=padupcal(2);

leftd<=not leftdd;
rightd<=not rightdd;
leftu<=not leftuu;
rightu<=not rightuu;
x(0)<=xx(0);
x(1)<=xx(1);
x(2)<=xx(2);

y(0)<=yy(0);
y(1)<=yy(1);
y(2)<=yy(2);
y(3)<=yy(3);

breset<=reset;
cr(0)<=start and clk;
ad<=start and clkslow1;

end Behavioral;