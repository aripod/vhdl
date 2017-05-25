LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Bench_Top IS
END Bench_Top;
 
ARCHITECTURE behavior OF Bench_Top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Top
    PORT(
         clk : IN  std_logic;
         D1 : OUT  std_logic_vector(3 downto 0);
         D2 : OUT  std_logic_vector(3 downto 0);
			Carry : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal D1 : std_logic_vector(3 downto 0);
   signal D2 : std_logic_vector(3 downto 0);
	signal Carry : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Top PORT MAP (
          clk => clk,
          D1 => D1,
          D2 => D2,
			 Carry => Carry
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
     

      wait;
   end process;

END;
