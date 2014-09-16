--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : sch2vhdl
--  /   /         Filename : top.vhf
-- /___/   /\     Timestamp : 04/24/2011 09:36:02
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: C:\Xilinx92i\bin\nt\sch2vhdl.exe -intstyle ise -family virtex2p -flat -suppress -w C:/Users/pallav/Desktop/ping/top.sch top.vhf
--Design Name: top
--Device: virtex2p
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesis and simulted, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity top is
   port ( led                 : in    std_logic; 
          leu                 : in    std_logic; 
          reset               : in    std_logic; 
          rid                 : in    std_logic; 
          riu                 : in    std_logic; 
          speed               : in    std_logic; 
          start               : in    std_logic; 
          SYSTEM_CLOCK        : in    std_logic; 
          clk10               : out   std_logic; 
          VGA_COMP_SYNCH      : out   std_logic; 
          VGA_HSYNCH          : out   std_logic; 
          VGA_OUT_BLANK_Z     : out   std_logic; 
          VGA_OUT_BLUE        : out   std_logic_vector (7 downto 0); 
          VGA_OUT_GREEN       : out   std_logic_vector (7 downto 0); 
          VGA_OUT_PIXEL_CLOCK : out   std_logic; 
          VGA_OUT_RED         : out   std_logic_vector (7 downto 0); 
          VGA_VSYNCH          : out   std_logic);
end top;

architecture BEHAVIORAL of top is
   signal XLXN_9              : std_logic_vector (9 downto 0);
   signal XLXN_10             : std_logic_vector (8 downto 0);
   signal XLXN_11             : std_logic_vector (9 downto 0);
   signal XLXN_12             : std_logic_vector (9 downto 0);
   signal XLXN_13             : std_logic;
   signal XLXN_14             : std_logic;
   signal XLXN_15             : std_logic;
   signal XLXN_16             : std_logic;
   signal XLXN_38             : std_logic;
   component mainc
      port ( start    : in    std_logic; 
             clk      : in    std_logic; 
             reset    : in    std_logic; 
             leftdd   : in    std_logic; 
             rightdd  : in    std_logic; 
             leftuu   : in    std_logic; 
             rightuu  : in    std_logic; 
             speed    : in    std_logic; 
             score    : out   std_logic_vector (7 downto 0); 
             togscore : out   std_logic_vector (1 downto 0); 
             bally    : out   std_logic_vector (8 downto 0); 
             ballx    : out   std_logic_vector (9 downto 0); 
             padupo   : out   std_logic_vector (9 downto 0); 
             padwno   : out   std_logic_vector (9 downto 0));
   end component;
   
   component clk10hz
      port ( clkin  : in    std_logic; 
             clkout : out   std_logic);
   end component;
   
   component MAIN
      port ( SYSTEM_CLOCK        : in    std_logic; 
             ballx               : in    std_logic_vector (9 downto 0); 
             bally               : in    std_logic_vector (8 downto 0); 
             padup               : in    std_logic_vector (9 downto 0); 
             padwn               : in    std_logic_vector (9 downto 0); 
             LED_0               : out   std_logic; 
             LED_1               : out   std_logic; 
             LED_2               : out   std_logic; 
             LED_3               : out   std_logic; 
             VGA_OUT_PIXEL_CLOCK : out   std_logic; 
             VGA_COMP_SYNCH      : out   std_logic; 
             VGA_OUT_BLANK_Z     : out   std_logic; 
             VGA_HSYNCH          : out   std_logic; 
             VGA_VSYNCH          : out   std_logic; 
             VGA_OUT_RED         : out   std_logic_vector (7 downto 0); 
             VGA_OUT_GREEN       : out   std_logic_vector (7 downto 0); 
             VGA_OUT_BLUE        : out   std_logic_vector (7 downto 0); 
             pixel_clock         : out   std_logic);
   end component;
   
begin
   XLXI_4 : mainc
      port map (clk=>XLXN_38,
                leftdd=>led,
                leftuu=>leu,
                reset=>reset,
                rightdd=>rid,
                rightuu=>riu,
                speed=>speed,
                start=>start,
                ballx(9 downto 0)=>XLXN_9(9 downto 0),
                bally(8 downto 0)=>XLXN_10(8 downto 0),
                padupo(9 downto 0)=>XLXN_11(9 downto 0),
                padwno(9 downto 0)=>XLXN_12(9 downto 0),
                score=>open,
                togscore=>open);
   
   XLXI_14 : clk10hz
      port map (clkin=>XLXN_38,
                clkout=>clk10);
   
   XLXI_22 : MAIN
      port map (ballx(9 downto 0)=>XLXN_9(9 downto 0),
                bally(8 downto 0)=>XLXN_10(8 downto 0),
                padup(9 downto 0)=>XLXN_11(9 downto 0),
                padwn(9 downto 0)=>XLXN_12(9 downto 0),
                SYSTEM_CLOCK=>SYSTEM_CLOCK,
                LED_0=>XLXN_13,
                LED_1=>XLXN_14,
                LED_2=>XLXN_15,
                LED_3=>XLXN_16,
                pixel_clock=>XLXN_38,
                VGA_COMP_SYNCH=>VGA_COMP_SYNCH,
                VGA_HSYNCH=>VGA_HSYNCH,
                VGA_OUT_BLANK_Z=>VGA_OUT_BLANK_Z,
                VGA_OUT_BLUE(7 downto 0)=>VGA_OUT_BLUE(7 downto 0),
                VGA_OUT_GREEN(7 downto 0)=>VGA_OUT_GREEN(7 downto 0),
                VGA_OUT_PIXEL_CLOCK=>VGA_OUT_PIXEL_CLOCK,
                VGA_OUT_RED(7 downto 0)=>VGA_OUT_RED(7 downto 0),
                VGA_VSYNCH=>VGA_VSYNCH);
   
end BEHAVIORAL;


