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
	
	signal wsd, wsp : STD_LOGIC;
	signal input_data : STD_LOGIC_VECTOR (15 downto 0) := (others=>'0');
	signal delay : STD_LOGIC_VECTOR (1 downto 0);
	signal not_clk : STD_LOGIC;
begin
	
	input_data <= data(31 downto 16) when wsd='1' else data(15 downto 0);
	
	sync_edge_detection: process(clk)
		begin
		if(rising_edge(clk)) then
			delay(0) <= delay(1);
			delay(1) <= ws;
		end if;
	end process;
	wsd <= delay(1);
	wsp <= delay(1) xor delay(0);
	
	not_clk <= not clk;
	Inst_Shift_Register_ParallelLoad: entity work.Shift_Register_ParallelLoad PORT MAP(
		clk => not_clk,
		pl => wsp,
		data => input_data,
		sd => sd
	);
	
end Behavioral;