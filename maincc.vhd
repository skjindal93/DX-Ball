
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
use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mainc is
    Port (     start : in  STD_LOGIC;
					pausein : in STD_LOGIC;
                clk : in std_logic;
                reset : in std_logic;
                --playerd
                leftdd,rightdd : in std_logic;
                --playeru
                --leftuu,rightuu : in std_logic;
                --speed : in std_logic;
					 bricko:out std_logic_vector(39 downto 0);
                bally: out std_logic_vector(8 downto 0);
                ballx: out std_logic_vector(9 downto 0);
					 --padupo: out std_logic_vector(9 downto 0);
					 padwno: out std_logic_vector(9 downto 0);
					 sound: out std_logic_vector(1 downto 0);
					 liveo: out std_logic_vector(2 downto 0);
                score : out std_logic_vector(6 downto 0);
                togscore : out std_logic_vector(1 downto 0);
					 finish: out std_logic_vector(1 downto 0);
					 kb_clk : in STD_LOGIC;
					 kb_data : in STD_LOGIC
                );
end mainc;

architecture Behavioral of mainc is
component ball1
port (    x: out std_logic_vector(9 downto 0);
            y: out std_logic_vector(8 downto 0);
            ad: in std_logic;
				brick:in std_logic_vector(39 downto 0);
				brickout:out std_logic_vector(39 downto 0);
				scorep:out std_logic_vector(6 downto 0);
				soundPin : out STD_LOGIC_VECTOR(1 downto 0) := "00";
            padwn: in std_logic_vector(9 downto 0);
				lives:out std_logic_vector(2 downto 0);
            nthitdwn: out std_logic;
            breset: in std_logic
				--finishPin : out STD_LOGIC_VECTOR(1 downto 0) := "01"
            );
end component;
component keyboardc IS 
	PORT (
		Pause: IN STD_LOGIC;
		Reset: IN STD_LOGIC;
		KeyboardClock: IN STD_LOGIC;
		KeyboardData: IN STD_LOGIC;
		keycode: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	end component;


component KeyboardController is
    Port ( Clock : in STD_LOGIC;
	        KeyboardClock : in  STD_LOGIC;
           KeyboardData : in  STD_LOGIC;
           LeftPaddleDirection : buffer std_logic;
           RightPaddleDirection : buffer std_logic;
			  Launch : buffer std_logic
	);
end component;
component debounce
port(inp,clkin: in std_logic; outp: out std_logic);
end component;

component clk10hz is
port(clkin: in std_logic; clkout: out std_logic);
end component;

component clkdivide is
port (clkin: in std_logic; clkout:out std_logic);
end component;


--component display is
--port(    clk:in std_logic;
--    padup,padown,ballx:in std_logic_vector(2 downto 0);
--        bally:in std_logic_vector(3 downto 0);
--        y: out std_logic_vector(15 downto 0);
--        x: out std_logic_vector(7 downto 0));
--end component;


signal     x: std_logic_vector(9 downto 0);
SIGNAL		pause:std_logic:='1';

signal    ld1 :std_logic;
signal    rd1:std_logic;
signal    launch1:std_logic;
signal    y: std_logic_vector(8 downto 0);
signal    brick: std_logic_vector(39 downto 0):="1111111111111111111111111111111111111111";
signal    brickout: std_logic_vector(39 downto 0):="1111111111111111111111111111111111111111";
signal	scorep:std_logic_vector(6 downto 0):="0000000";
signal    ad:std_logic;
signal 	key:std_logic_vector(7 downto 0):="00000000";
signal 	padwn: std_logic_vector(9 downto 0):="0101000000";
signal 	lives: std_logic_vector(2 downto 0):="010";
signal	soundPin:std_logic_vector(1 downto 0):="00";
signal	finishPin:std_logic_vector(1 downto 0):="01"; 
signal    nthitdwn: std_logic;--nhithup udega
signal   breset: std_logic;
signal   led,rid,leu,riu: std_logic:='0';
signal   cr:std_logic_vector(7 downto 0);
signal     clkslow1,clkslow,clkpad: std_logic;
signal     clkslow2:std_logic:='0';
signal     leftd,rightd: std_logic;---rightu leftu udega
signal 	count : std_logic_vector(20 downto 0) :="000000000000000000000";


begin
kb : KeyboardController port map (clk,kb_clk,kb_data,ld1,rd1,launch1);
--di: display port map(clk,padup, padwn,x,y,row, column);
b0: ball1 port map(ballx,bally,ad,brick,brickout,scorep,soundPin,padwn,lives,nthitdwn,breset);
d0: debounce port map(leftd,clk,led);
d2: debounce port map(rightd,clk,rid);
cls: clk10hz port map(clk,clkslow);
clpd: clk10hz port map(clk,clkpad);
daf: clkdivide port map(clkslow,clkslow1);

process(clk) begin
if rising_edge(clk) then
if (brickout="0000000000000000000000000000000000000000") then
	finishPin<="00";
else 
	finishPin<="01";
end if;
count<=count+'1';
if count= "000011111111111111111" then count<="000000000000000000000";clkslow2<='1'; else clkslow2<='0'; end if;
end if;
if ((pausein='1' or launch1='0') and lives="000") then 
	pause<='0';
else 
	pause<='1';
end if;
end process;

--led<=leftd;
--leu<=leftu;
--rid<=rightd;
--riu<=rightu;
process (clkslow2)
variable radius :integer := 2;
variable len : integer := 80;
variable br : integer := 2;
begin
if rising_edge(clkslow2) then
if ((leftdd='1' and rightdd = '0') or ld1='0') and conv_integer(padwn)>0 then padwn<=(CONV_STD_LOGIC_VECTOR((CONV_INTEGER(padwn)-2),10)); else
if ((rightdd='1' and leftdd ='0') or rd1='0') and conv_integer(padwn)<620-len then padwn<=(CONV_STD_LOGIC_VECTOR((CONV_INTEGER(padwn)+2),10)); end if;end if; end if;
end process;

--padwn(0)<=padwncal(0);
--padwn(1)<=padwncal(1);
---padwn(2)<=padwncal(2);

--padup(0)<=padupcal(0);
--padup(1)<=padupcal(1);
--padup(2)<=padupcal(2);

leftd<=not leftdd;
rightd<=not rightdd;
--
--x(0)<=xx(0);
--x(1)<=xx(1);
--x(2)<=xx(2);

--y(0)<=yy(0);
--y(1)<=yy(1);
--y(2)<=yy(2);
--y(3)<=yy(3);

breset<=reset;
--breset<=reset;
cr(0)<=(pause and start) and clk;
ad<=(pause and start) and clkslow2;
--cr(0)<=start and clk;
--ad<=start and clkslow2;

padwno<=padwn;
bricko<=brickout;
score<=scorep;
sound<=soundPin;
liveo<=lives;
finish<=finishPin;
end Behavioral;
-- 