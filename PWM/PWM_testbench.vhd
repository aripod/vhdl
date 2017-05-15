LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TOP_Testbench IS
END TOP_Testbench;
 
ARCHITECTURE behavior OF TOP_Testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PWM_top
    PORT(
         clk : IN  std_logic;
         Duty : IN  std_logic_vector(9 downto 0);
         PWM : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal Duty : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal PWM : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PWM_top PORT MAP (
          clk => clk,
          Duty => Duty,
          PWM => PWM
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		Duty <= "1000000000";
	
      wait for clk_period*10000;


		Duty <= "0010000000";
		
      wait;
   end process;

END;
