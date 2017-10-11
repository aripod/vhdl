LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Bench IS
END Bench;
 
ARCHITECTURE behavior OF Bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Debouncer
    PORT(
         clk : IN  std_logic;
         input : IN  std_logic;
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal input : std_logic := '0';
	
 	--Outputs
   signal output : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;	-- 50MHz
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Debouncer PORT MAP (
          clk => clk,
          input => input,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 200 us;
		input <= '1';
		wait for 500 us;
		input <= '0';
		wait for 150 us;
		input <= '1';
		wait for 250 us;
		input <= '0';
		wait for 200 us;
		input <= '1';
		
		wait for 3 ms;
		input <= '0';
		wait for 200 us;
		input <= '1';
		wait for 500 us;
		input <= '0';
		wait for 150 us;
		input <= '1';
		wait for 250 us;
		input <= '0';

        wait for 5 ms;
        		input <= '1';
        wait for 500 us;
        input <= '0';
        wait for 150 us;
        input <= '1';
        wait for 250 us;
        input <= '0';
        wait for 200 us;
        input <= '1';
        
        wait for 3 ms;
        input <= '0';
        wait for 200 us;
        input <= '1';
        wait for 500 us;
        input <= '0';
        wait for 150 us;
        input <= '1';
        wait for 250 us;
        input <= '0';
      wait;
   end process;
END;