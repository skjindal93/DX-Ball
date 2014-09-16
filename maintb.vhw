--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : maintb.vhw
-- /___/   /\     Timestamp : Tue Apr 16 00:33:12 2013
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: maintb
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY maintb IS
END maintb;

ARCHITECTURE testbench_arch OF maintb IS
    COMPONENT mainc
        PORT (
            start : In std_logic;
            clk : In std_logic;
            reset : In std_logic;
            leftdd : In std_logic;
            rightdd : In std_logic;
            leftuu : In std_logic;
            rightuu : In std_logic;
            speed : In std_logic;
            ballx : Out std_logic_vector (9 DownTo 0);
            bally : Out std_logic_vector (8 DownTo 0);
            padup : Out std_logic_vector (9 DownTo 0);
            padwn : Out std_logic_vector (9 DownTo 0);
            score : Out std_logic_vector (7 DownTo 0);
            togscore : Out std_logic_vector (1 DownTo 0)
        );
    END COMPONENT;

    SIGNAL start : std_logic := '0';
    SIGNAL clk : std_logic := '0';
    SIGNAL reset : std_logic := '0';
    SIGNAL leftdd : std_logic := '0';
    SIGNAL rightdd : std_logic := '0';
    SIGNAL leftuu : std_logic := '0';
    SIGNAL rightuu : std_logic := '0';
    SIGNAL speed : std_logic := '0';
    SIGNAL ballx : std_logic_vector (9 DownTo 0) := "";
    SIGNAL bally : std_logic_vector (8 DownTo 0) := "";
    SIGNAL padup : std_logic_vector (9 DownTo 0) := "";
    SIGNAL padwn : std_logic_vector (9 DownTo 0) := "";
    SIGNAL score : std_logic_vector (7 DownTo 0) := "00000000";
    SIGNAL togscore : std_logic_vector (1 DownTo 0) := "00";

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

    BEGIN
        UUT : mainc
        PORT MAP (
            start => start,
            clk => clk,
            reset => reset,
            leftdd => leftdd,
            rightdd => rightdd,
            leftuu => leftuu,
            rightuu => rightuu,
            speed => speed,
            ballx => ballx,
            bally => bally,
            padup => padup,
            padwn => padwn,
            score => score,
            togscore => togscore
        );

        PROCESS    -- clock process for clk
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                clk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                clk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            BEGIN
                WAIT FOR 1200 ns;

            END PROCESS;

    END testbench_arch;

