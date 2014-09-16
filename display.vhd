----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:42:01 04/20/2011 
-- Design Name: 
-- Module Name:    display - Behavioral 
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

--entity display is
--port(	clk:in std_logic; 
		--padup,padown,ballx:in std_logic_vector(2 downto 0); 
		--bally:in std_logic_vector(3 downto 0); 
		--y: out std_logic_vector(15 downto 0); 
		--x: out std_logic_vector(7 downto 0));
--end display;

architecture Behavioral of display is
component clk100hz is
port(clkin: in std_logic; clkout: out std_logic);
end component;

component decoder3 is
port(colno : in std_logic_vector(2 downto 0);
		colnodec : out std_logic_vector(7 downto 0));
end component;

component decode4 is
port(rowno : in std_logic_vector(3 downto 0);
		rownodec : out std_logic_vector(15 downto 0));
end component;


signal cl100hz: std_logic;
signal padup2,padown2: std_logic_vector(2 downto 0);
signal padupy:std_logic_vector(3 downto 0):="1111";
signal padowny:std_logic_vector(3 downto 0):="0000";
signal count: std_logic_vector(1 downto 0):="01";
signal padownd1,padupd1,padownd2,padupd2,ballxd: std_logic_vector(7 downto 0);
signal ballyd,padupyd,padownyd: std_logic_vector(15 downto 0);

begin

de0: decoder3 port map(padown,padownd1);
de1: decoder3 port map(padup,padupd1);
de2: decoder3 port map(padown2,padownd2);
de3: decoder3 port map(padup2,padupd2);
de4: decoder3 port map(ballx,ballxd);
de5: decode4 port map (bally,ballyd);
de6: decode4 port map (padupy,padupyd);
de7: decode4 port map (padowny,padownyd);

clls: clk100hz port map (clk,cl100hz);

padup2<=padup+'1';
padown2<=padown+'1';

process (cl100hz) begin
if rising_edge(cl100hz) then count<=count+'1'; end if;
if count="11" then count<="00";end if;
end process;

process(count) begin
if count="00" then x<=not ballxd; y<=ballyd; else
if count="01" then x<=not (padupd1 or padupd2); y<=padupyd; else
						x<=not (padownd2 or padownd1); y<=padownyd; end if; end if;
end process;
end Behavioral;

