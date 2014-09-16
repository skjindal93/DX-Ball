
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:07:14 04/19/2011
-- Design Name:   ball
-- Module Name:   E:/Xilinx92installed/ping/balltest.vhd
-- Project Name:  ping
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ball
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY balltest_vhd IS
END balltest_vhd;

ARCHITECTURE behavior OF balltest_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT ball
	PORT(
		ad : IN std_logic;
		breset : IN std_logic;
		padup : IN std_logic_vector(2 downto 0);
		padwn : IN std_logic_vector(2 downto 0);          
		nthitup : OUT std_logic:='0';
		nthitdwn : OUT std_logic:='0';
		x : OUT std_logic_vector(3 downto 0):="0100";
		y : OUT std_logic_vector(4 downto 0):="01000"
		);
	END COMPONENT;

	--Inputs
	SIGNAL ad :  std_logic := '0';
	SIGNAL breset :  std_logic := '0';
	SIGNAL padup :  std_logic_vector(2 downto 0) := (others=>'0');
	SIGNAL padwn :  std_logic_vector(2 downto 0) := (others=>'0');

	--Outputs
	SIGNAL nthitup :  std_logic:='0';
	SIGNAL nthitdwn :  std_logic:='0';
	SIGNAL x :  std_logic_vector(3 downto 0):="0100";
	SIGNAL y :  std_logic_vector(4 downto 0):="01000";

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: ball PORT MAP(
		ad => ad,
		breset => breset,
		padup => padup,
		padwn => padwn,
		nthitup => nthitup,
		nthitdwn => nthitdwn,
		x => x,
		y => y
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- Place stimulus here
		ad<='0';
		breset<='0';
		wait for 100 ns;
		ad<='1';
		wait; -- will wait forever
	END PROCESS;

END;
