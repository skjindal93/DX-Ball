--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : ballt.vhw
-- /___/   /\     Timestamp : Sun Apr 24 11:15:33 2011
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: ballt
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY ballt IS
END ballt;

ARCHITECTURE testbench_arch OF ballt IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT ball1
        PORT (
            x : Out std_logic_vector (9 DownTo 0);
            y : Out std_logic_vector (8 DownTo 0);
            ad : In std_logic;
            padup : In std_logic_vector (9 DownTo 0);
            padwn : In std_logic_vector (9 DownTo 0);
            nthitup : Out std_logic;
            nthitdwn : Out std_logic;
            breset : In std_logic
        );
    END COMPONENT;

    SIGNAL x : std_logic_vector (9 DownTo 0) := "0000000000";
    SIGNAL y : std_logic_vector (8 DownTo 0) := "000000000";
    SIGNAL ad : std_logic := '0';
    SIGNAL padup : std_logic_vector (9 DownTo 0) := "0000000000";
    SIGNAL padwn : std_logic_vector (9 DownTo 0) := "0000000000";
    SIGNAL nthitup : std_logic := '0';
    SIGNAL nthitdwn : std_logic := '0';
    SIGNAL breset : std_logic := '0';

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

    BEGIN
        UUT : ball1
        PORT MAP (
            x => x,
            y => y,
            ad => ad,
            padup => padup,
            padwn => padwn,
            nthitup => nthitup,
            nthitdwn => nthitdwn,
            breset => breset
        );

        PROCESS    -- clock process for ad
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                ad <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                ad <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                padup <= "0010000000";
                padwn <= "0001000000";
                -- -------------------------------------
                -- -------------  Current Time:  185ns
                WAIT FOR 85 ns;
                breset <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  385ns
                WAIT FOR 200 ns;
                breset <= '0';
                -- -------------------------------------
                WAIT FOR 7815 ns;

            END PROCESS;

    END testbench_arch;

