library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Top is
    Port ( clk : in  STD_LOGIC;
           D1 : out  STD_LOGIC_VECTOR (3 downto 0);
           D2 : out  STD_LOGIC_VECTOR (3 downto 0);
			  D3 : out  STD_LOGIC_VECTOR (3 downto 0);
			  D4 : out  STD_LOGIC_VECTOR (3 downto 0));
end Top;

architecture Behavioral of Top is

	signal carry_D1, carry_D2, carry_D3, carry_D4, carry_D5 : STD_LOGIC;
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
		carry_out => carry_D2
	);
	
	carry_D3 <= carry_D2 and carry_D1;
	BCD_Counter_D3: entity work.BCD_Counter PORT MAP(
		clk => clk,
		carry_in => carry_D3,
		Count => D3,
		carry_out => carry_D4
	);

	carry_D5 <= carry_D4 and Carry_D3 and carry_D1;
	BCD_Counter_D4: entity work.BCD_Counter PORT MAP(
		clk => clk,
		carry_in => carry_D5,
		Count => D4,
		carry_out => c
	);
end Behavioral;

