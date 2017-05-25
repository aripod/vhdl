library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Top is
    Port ( clk : in  STD_LOGIC;
           D1 : out  STD_LOGIC_VECTOR (3 downto 0);
           D2 : out  STD_LOGIC_VECTOR (3 downto 0);
			  Carry : out STD_LOGIC);
end Top;

architecture Behavioral of Top is

	signal carry_D1 : STD_LOGIC;
	signal c : std_logic;

begin

	BCD_Counter_D1: entity work.BCD_Counter PORT MAP(
		clk => clk,
		carry_in => '1',
		Count => D1,
		carry_out => carry_D1
	);
	
	BCD_Counter_D2: entity work.BCD_Counter PORT MAP(
		clk => clk,
		carry_in => carry_D1,
		Count => D2,
		carry_out => c
	);

	Carry <= carry_D1;
end Behavioral;

