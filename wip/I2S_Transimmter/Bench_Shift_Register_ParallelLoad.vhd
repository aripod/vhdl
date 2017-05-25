LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Bench_Shift_Register_ParallelLoad IS
END Bench_Shift_Register_ParallelLoad;
 
ARCHITECTURE behavior OF Bench_Shift_Register_ParallelLoad IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Shift_Register_ParallelLoad
    PORT(
         clk : IN  std_logic;
         pl : IN  std_logic;
         data : IN  std_logic_vector(15 downto 0);
         sd : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal pl : std_logic := '0';
   signal data : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal sd : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Shift_Register_ParallelLoad PORT MAP (
          clk => clk,
          pl => pl,
          data => data,
          sd => sd
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
      wait for clk_period*2;

		data <= x"AAAA";
		pl <= '1';
		wait for clk_period;
		pl <= '0';

      wait;
   end process;

END;
