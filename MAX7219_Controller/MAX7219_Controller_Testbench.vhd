--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:16:26 04/23/2017
-- Design Name:   
-- Module Name:   /home/ariel/Documents/VHDL/MAX7219_Controller/MAX7219_Controller_Testbench.vhd
-- Project Name:  MAX7219_Controller
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MAX7219_Controller
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MAX7219_Controller_Testbench IS
END MAX7219_Controller_Testbench;
 
ARCHITECTURE behavior OF MAX7219_Controller_Testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MAX7219_Controller
    PORT(
         Address_in : IN  std_logic_vector(7 downto 0);
         Data_in : IN  std_logic_vector(7 downto 0);
         Clk : IN  std_logic;
         Start : IN  std_logic;
         Dout : OUT  std_logic;
         CS : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Address_in : std_logic_vector(7 downto 0) := (others => '0');
   signal Data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Start : std_logic := '0';

 	--Outputs
   signal Dout : std_logic;
   signal CS : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MAX7219_Controller PORT MAP (
          Address_in => Address_in,
          Data_in => Data_in,
          Clk => Clk,
          Start => Start,
          Dout => Dout,
          CS => CS
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '1';
		wait for Clk_period/2;
		Clk <= '0';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 21 ns;	

		Address_in <= "11010101";
		Data_in <= "10011011";
		wait for 10 ns;
		
		Start <= '1';
		wait for 10 ns;
		Start <= '0';

      wait;
   end process;

END;
