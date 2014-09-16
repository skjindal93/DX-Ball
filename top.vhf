--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : sch2vhdl
--  /   /         Filename : top.vhf
-- /___/   /\     Timestamp : 04/26/2013 18:18:58
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: C:\Xilinx92i\bin\nt\sch2vhdl.exe -intstyle ise -family virtex2p -flat -suppress -w C:/cHOTU/pingnew5/pingnew/top.sch top.vhf
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
   port ( kb_clk              : in    std_logic; 
          kb_data             : in    std_logic; 
          led                 : in    std_logic; 
          pausein             : in    std_logic; 
          reset               : in    std_logic; 
          rid                 : in    std_logic; 
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
   signal XLXN_9                   : std_logic_vector (9 downto 0);
   signal XLXN_10                  : std_logic_vector (8 downto 0);
   signal XLXN_12                  : std_logic_vector (9 downto 0);
   signal XLXN_13                  : std_logic;
   signal XLXN_14                  : std_logic;
   signal XLXN_15                  : std_logic;
   signal XLXN_16                  : std_logic;
   signal XLXN_41                  : std_logic_vector (39 downto 0);
   signal XLXN_43                  : std_logic_vector (6 downto 0);
   signal XLXN_44                  : std_logic_vector (2 downto 0);
   signal XLXN_79                  : std_logic;
   signal XLXN_80                  : std_logic_vector (1 downto 0);
   signal XLXI_22_padup_openSignal : std_logic_vector (9 downto 0);
   component clk10hz
      port ( clkin  : in    std_logic; 
             clkout : out   std_logic);
   end component;
   
   component MAIN
      port ( SYSTEM_CLOCK        : in    std_logic; 
             score               : in    std_logic_vector (6 downto 0); 
             lives               : in    std_logic_vector (2 downto 0); 
             bricki              : in    std_logic_vector (39 downto 0); 
             ballx               : in    std_logic_vector (9 downto 0); 
             bally               : in    std_logic_vector (8 downto 0); 
             padup               : in    std_logic_vector (9 downto 0); 
             padwn               : in    std_logic_vector (9 downto 0); 
             LED_0               : out   std_logic; 
             LED_1               : out   std_logic; 
             LED_2               : out   std_logic; 
             LED_3               : out   std_logic; 
             pixel_clock         : out   std_logic; 
             VGA_OUT_PIXEL_CLOCK : out   std_logic; 
             VGA_COMP_SYNCH      : out   std_logic; 
             VGA_OUT_BLANK_Z     : out   std_logic; 
             VGA_HSYNCH          : out   std_logic; 
             VGA_VSYNCH          : out   std_logic; 
             pass                : out   std_logic; 
             VGA_OUT_RED         : out   std_logic_vector (7 downto 0); 
             VGA_OUT_GREEN       : out   std_logic_vector (7 downto 0); 
             VGA_OUT_BLUE        : out   std_logic_vector (7 downto 0); 
             finish              : in    std_logic_vector (1 downto 0));
   end component;
   
   component mainc
      port ( start    : in    std_logic; 
             clk      : in    std_logic; 
             reset    : in    std_logic; 
             leftdd   : in    std_logic; 
             rightdd  : in    std_logic; 
             kb_clk   : in    std_logic; 
             kb_data  : in    std_logic; 
             bricko   : out   std_logic_vector (39 downto 0); 
             bally    : out   std_logic_vector (8 downto 0); 
             ballx    : out   std_logic_vector (9 downto 0); 
             padwno   : out   std_logic_vector (9 downto 0); 
             sound    : out   std_logic_vector (1 downto 0); 
             liveo    : out   std_logic_vector (2 downto 0); 
             score    : out   std_logic_vector (6 downto 0); 
             togscore : out   std_logic_vector (1 downto 0); 
             finish   : out   std_logic_vector (1 downto 0); 
             pausein  : in    std_logic);
   end component;
   
begin
   XLXI_14 : clk10hz
      port map (clkin=>XLXN_79,
                clkout=>clk10);
   
   XLXI_22 : MAIN
      port map (ballx(9 downto 0)=>XLXN_9(9 downto 0),
                bally(8 downto 0)=>XLXN_10(8 downto 0),
                bricki(39 downto 0)=>XLXN_41(39 downto 0),
                finish(1 downto 0)=>XLXN_80(1 downto 0),
                lives(2 downto 0)=>XLXN_44(2 downto 0),
                padup(9 downto 0)=>XLXI_22_padup_openSignal(9 downto 0),
                padwn(9 downto 0)=>XLXN_12(9 downto 0),
                score(6 downto 0)=>XLXN_43(6 downto 0),
                SYSTEM_CLOCK=>SYSTEM_CLOCK,
                LED_0=>XLXN_13,
                LED_1=>XLXN_14,
                LED_2=>XLXN_15,
                LED_3=>XLXN_16,
                pass=>open,
                pixel_clock=>XLXN_79,
                VGA_COMP_SYNCH=>VGA_COMP_SYNCH,
                VGA_HSYNCH=>VGA_HSYNCH,
                VGA_OUT_BLANK_Z=>VGA_OUT_BLANK_Z,
                VGA_OUT_BLUE(7 downto 0)=>VGA_OUT_BLUE(7 downto 0),
                VGA_OUT_GREEN(7 downto 0)=>VGA_OUT_GREEN(7 downto 0),
                VGA_OUT_PIXEL_CLOCK=>VGA_OUT_PIXEL_CLOCK,
                VGA_OUT_RED(7 downto 0)=>VGA_OUT_RED(7 downto 0),
                VGA_VSYNCH=>VGA_VSYNCH);
   
   XLXI_23 : mainc
      port map (clk=>XLXN_79,
                kb_clk=>kb_clk,
                kb_data=>kb_data,
                leftdd=>led,
                pausein=>pausein,
                reset=>reset,
                rightdd=>rid,
                start=>start,
                ballx(9 downto 0)=>XLXN_9(9 downto 0),
                bally(8 downto 0)=>XLXN_10(8 downto 0),
                bricko(39 downto 0)=>XLXN_41(39 downto 0),
                finish(1 downto 0)=>XLXN_80(1 downto 0),
                liveo(2 downto 0)=>XLXN_44(2 downto 0),
                padwno(9 downto 0)=>XLXN_12(9 downto 0),
                score(6 downto 0)=>XLXN_43(6 downto 0),
                sound=>open,
                togscore=>open);
   
end BEHAVIORAL;


