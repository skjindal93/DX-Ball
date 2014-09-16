
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY keyboardc IS 
	PORT (
		Pause: IN STD_LOGIC;
		Reset: IN STD_LOGIC;
		KeyboardClock: IN STD_LOGIC;
		KeyboardData: IN STD_LOGIC;
		keycode: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END keyboardc;

ARCHITECTURE Behavioral OF keyboardc IS
	TYPE state_type IS (
		s_start,s_d0,s_d1,s_d2,s_d3,s_d4,s_d5,s_d6,s_d7,s_parity,s_stop);
	SIGNAL state: state_type;
	BEGIN
		FSM: PROCESS(KeyboardClock, Reset)
		BEGIN
			IF (Reset = '1') THEN
				state <= s_start;
				-- this FSM is driven by the keyboard clock signal
			ELSIF (KeyboardClock'EVENT AND KeyboardClock = '1') THEN
				CASE state is
					WHEN s_start =>
						state <= s_d0;
					WHEN s_d0 =>
						state <= s_d1;
					WHEN s_d1 =>
						state <= s_d2;
					WHEN s_d2 =>
						state <= s_d3;
					WHEN s_d3 =>
						state <= s_d4;
					WHEN s_d4 =>
						state <= s_d5;
					WHEN s_d5 =>
						state <= s_d6;
					WHEN s_d6 =>
						state <= s_d7;
					WHEN s_d7 =>
						state <= s_parity;
					WHEN s_parity =>
						state <= s_stop;
					WHEN s_stop =>
						state <= s_start;
					WHEN OTHERS =>
				END CASE;
			END IF;
	END PROCESS;
	output_logic: PROCESS (state)
	BEGIN
		CASE state IS
			WHEN s_d0 =>
				keycode(0) <= KeyboardData; -- read in data bit 0 from the
			WHEN s_d1 =>
				keycode(1) <= KeyboardData; -- read in data bit 1 from the
			WHEN s_d2 =>
				keycode(2) <= KeyboardData; -- read in data bit 2 from the
			WHEN s_d3 =>
				keycode(3) <= KeyboardData; -- read in data bit 3 from the
			WHEN s_d4 =>
				keycode(4) <= KeyboardData; -- read in data bit 4 from the
			WHEN s_d5 =>
				keycode(5) <= KeyboardData; -- read in data bit 5 from the
			WHEN s_d6 =>
				keycode(6) <= KeyboardData; -- read in data bit 6 from the
			WHEN s_d7 =>
				keycode(7) <= KeyboardData; -- read in data bit 7 from the
			WHEN OTHERS =>
		END CASE;
	END PROCESS;
END Behavioral;