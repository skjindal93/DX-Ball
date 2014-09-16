
-- VHDL Instantiation Created from source file MAIN.vhd -- 09:16:08 04/24/2011
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT MAIN
	PORT(
		SYSTEM_CLOCK : IN std_logic;
		ballx : IN std_logic_vector(9 downto 0);
		bally : IN std_logic_vector(8 downto 0);
		padup : IN std_logic_vector(9 downto 0);
		padwn : IN std_logic_vector(9 downto 0);          
		LED_0 : OUT std_logic;
		LED_1 : OUT std_logic;
		LED_2 : OUT std_logic;
		LED_3 : OUT std_logic;
		system_clock_buffered : OUT std_logic;
		VGA_OUT_PIXEL_CLOCK : OUT std_logic;
		VGA_COMP_SYNCH : OUT std_logic;
		VGA_OUT_BLANK_Z : OUT std_logic;
		VGA_HSYNCH : OUT std_logic;
		VGA_VSYNCH : OUT std_logic;
		VGA_OUT_RED : OUT std_logic_vector(7 downto 0);
		VGA_OUT_GREEN : OUT std_logic_vector(7 downto 0);
		VGA_OUT_BLUE : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_MAIN: MAIN PORT MAP(
		SYSTEM_CLOCK => ,
		ballx => ,
		bally => ,
		padup => ,
		padwn => ,
		LED_0 => ,
		LED_1 => ,
		LED_2 => ,
		LED_3 => ,
		system_clock_buffered => ,
		VGA_OUT_PIXEL_CLOCK => ,
		VGA_COMP_SYNCH => ,
		VGA_OUT_BLANK_Z => ,
		VGA_HSYNCH => ,
		VGA_VSYNCH => ,
		VGA_OUT_RED => ,
		VGA_OUT_GREEN => ,
		VGA_OUT_BLUE => 
	);


