LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Quadrature_Encoder_Testbench IS
END Quadrature_Encoder_Testbench;
 
ARCHITECTURE behavior OF Quadrature_Encoder_Testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Quadrature_Encoder_TOP
    PORT(
         clk : IN  std_logic;
         A : IN  std_logic;
         B : IN  std_logic;
         Up : OUT  std_logic;
         Down : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal A : std_logic := '0';
   signal B : std_logic := '0';

 	--Outputs
   signal Up : std_logic;
   signal Down : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Quadrature_Encoder_TOP PORT MAP (
          clk => clk,
          A => A,
          B => B,
          Up => Up,
          Down => Down
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
      wait for 20 ns;	
		
		-- Clockwise
		A <= '1';
		wait for 100 ns;
		B <= '1';
		wait for 200 ns;
		A <= '0';
		wait for 100 ns;
		B <= '0';
		wait for 400 ns;
		
		-- Counter-Clockwise
		B <= '1';
		wait for 100 ns;
		A <= '1';
		wait for 200 ns;
		B <= '0';
		wait for 100 ns;
		A <= '0';
		wait for 400 ns;
		
		-- Clockwise
		A <= '1';
		wait for 100 ns;
		B <= '1';
		wait for 200 ns;
		B <= '0';
		wait for 100 ns;
		A <= '0';
		wait for 400 ns;

      wait;
   end process;

END;
