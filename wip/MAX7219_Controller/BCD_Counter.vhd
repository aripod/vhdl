library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD_Counter is
    Port ( clk : in  STD_LOGIC;
           carry_in : in  STD_LOGIC;
           Count : out  STD_LOGIC_VECTOR (3 downto 0);
           carry_out : out  STD_LOGIC);
end BCD_Counter;

architecture Behavioral of BCD_Counter is

	signal internal_count : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
	
begin

	process(clk)
		begin
		if(carry_in = '1') then
			if(rising_edge(clk)) then
				if(internal_count = 9) then
					internal_count <= (others => '0');
				else
					internal_count <= internal_count + '1';
				end if;
			end if;
		end if;
	end process;
	Count <= internal_count;
	carry_out <= '1' when internal_count=9 else '0';

end Behavioral;