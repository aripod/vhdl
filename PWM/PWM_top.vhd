----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:17:50 05/14/2017 
-- Design Name: 
-- Module Name:    PWM_top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWM_top is
    Port ( clk : in  STD_LOGIC;
           Duty : in  STD_LOGIC_VECTOR (9 downto 0);
           PWM : out  STD_LOGIC);
end PWM_top;

architecture Behavioral of PWM_top is
	
	constant WIDTH : integer := 10;
	signal count : STD_LOGIC_VECTOR (WIDTH-1 downto 0) := (others=>'0');
	
begin
	
	process(clk)
		begin
		if(clk'event and clk='1') then
			if(count<=Duty) then
				PWM <= '1';
			else
				PWM <= '0';
			end if;
			
			count <= count + 1;			
		end if;
	end process;
	
end Behavioral;