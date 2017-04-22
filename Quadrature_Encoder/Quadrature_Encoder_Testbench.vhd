LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Quadrature_Encoder_Testbench IS
END Quadrature_Encoder_Testbench;
 
ARCHITECTURE behavior OF Quadrature_Encoder_Testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Quadrature_Encoder
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         Up : OUT  std_logic;
         Down : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic := '0';
   signal B : std_logic := '0';

 	--Outputs
   signal Up : std_logic;
   signal Down : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Quadrature_Encoder PORT MAP (
          A => A,
          B => B,
          Up => Up,
          Down => Down
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 20 ns;	
	
		-- Clockwise
		A <= '0';
		B <= '0';
		wait for 20 ns;
		A <= '1';
		wait for 10 ns;
		B <= '1';
		wait for 10 ns;
		A <= '0';
		wait for 10 ns;
		B <= '0';
		
		wait for 50 ns;
		
		-- Clockwise
		A <= '0';
		B <= '0';
		wait for 20 ns;
		A <= '1';
		wait for 10 ns;
		B <= '1';
		wait for 10 ns;
		A <= '0';
		wait for 10 ns;
		B <= '0';
		
		wait for 50 ns;
		
		-- Counter-Clockwise
		A <= '0';
		B <= '1';
		wait for 20 ns;
		A <= '1';
		wait for 10 ns;
		B <= '0';
		wait for 10 ns;
		A <= '0';
		

      wait;
   end process;

END;