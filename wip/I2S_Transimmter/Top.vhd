library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Top is
    Port ( clk : in  STD_LOGIC;								-- Clock.
           ws : in  STD_LOGIC;								-- World select (0 left, 1 right).
           data : in  STD_LOGIC_VECTOR(31 downto 0);	-- Input data (16 bits left, 16 bits right).
           sd : out  STD_LOGIC);								-- Output serial data.
end Top;

architecture Behavioral of Top is
	
	signal wss, wsp : STD_LOGIC :='0';	--wws:word select sync. wsp: word select pulse.
	signal input_data : STD_LOGIC_VECTOR (15 downto 0) := (others=>'0');
	signal shift_data : STD_LOGIC_VECTOR (15 downto 0) := (others=>'0');
	signal delay : STD_LOGIC_VECTOR (1 downto 0);
	
begin
	
	input_data <= data(31 downto 16) when wss='1' else data(15 downto 0);
	
	sync_edge_detector_ws: process(clk)
		begin
		if(rising_edge(clk)) then
			delay(0) <= delay(1);
			delay(1) <= ws;
		end if;
	end process;
	wss <= delay(1);
	wsp <= delay(1) xor delay(0);
	
	process(clk)
		begin
		if(falling_edge(clk)) then
			if(wsp = '1') then
				shift_data <= input_data;
			else
				shift_data <= '0' & shift_data(15 downto 1);
			end if;
		end if;
	end process;
	sd <= shift_data(0);
	
end Behavioral;