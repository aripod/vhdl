library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Shift_Register_ParallelLoad is
    Port ( clk : in  STD_LOGIC;
           pl : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (15 downto 0);
           sd : out  STD_LOGIC);
end Shift_Register_ParallelLoad;

architecture Behavioral of Shift_Register_ParallelLoad is
	signal tmp_data : STD_LOGIC_VECTOR (15 downto 0) := (others=>'0');
begin

	process(clk)
		begin
		if(falling_edge(clk)) then
			if(pl = '1') then
				tmp_data<= data;
			else
				tmp_data <= '0' & tmp_data(15 downto 1);
			end if;
		end if;
	end process;
	sd <= tmp_data(0);
end Behavioral;