LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Bench_Top IS
END Bench_Top;
 
ARCHITECTURE behavior OF Bench_Top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Top
    PORT(
         clk : IN  std_logic;
         ws : IN  std_logic;
         data : IN  std_logic_vector(31 downto 0);
         sd : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ws : std_logic := '0';
   signal data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal sd : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Top PORT MAP (
          clk => clk,
          ws => ws,
          data => data,
          sd => sd
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
      data <= x"FFFFAAAA";
		ws <= '1';
		wait for clk_period*16;
		ws <= '0';
		wait for clk_period*16;
		ws <= '1';

      wait;
   end process;

END;
