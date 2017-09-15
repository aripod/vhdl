library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.functions.all;

entity Debouncer is
	Generic ( T : integer := 10);	-- Time (in ms) for the delay.
	Port ( clk : in  STD_LOGIC;
          input : in  STD_LOGIC;
          output : out  STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is

	signal ms_counter : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
	signal ms_pulse : STD_LOGIC := '0';
	signal delay : STD_LOGIC_VECTOR (1 downto 0);
	signal rise_edge : STD_LOGIC;
	signal count_enable : STD_LOGIC := '0';
	signal timer_count : STD_LOGIC_VECTOR (log2(T) downto 0) := (others=>'0');
	signal reset, debounce : STD_LOGIC := '0';
begin

	miliseconds: process(clk)	-- Generates a pulse (1 clk period length) every 1 ms.
		begin
		if(rising_edge(clk)) then
			if(ms_counter = 50000) then
				ms_pulse <= '1';
				ms_counter <= (others=>'0');
			else
				ms_pulse <= '0';
				ms_counter <= ms_counter + '1';
			end if;
		end if;
	end process;

	sync_and_edge_detection : process(clk)	-- Detects rising and falling edge.
		begin
		if(rising_edge(clk)) then
			delay(0) <= delay(1);
			delay(1) <= input;
		end if;
	end process;
	rise_edge <= delay(1) and (not delay(0));
	
	trigger_count: process(clk)
		begin
		if(reset='1') then
			count_enable <= '0';
		elsif(rising_edge(clk)) then
			if(rise_edge='1') then
				count_enable <='1';
			end if;
		end if;
	end process;

	count_proc: process(clk)
		begin
		if(rising_edge(clk)) then
			if(timer_count=T) then
				timer_count <= (others=>'0');
				debounce <= input;
				reset <= '1';
			elsif(ms_pulse='1') then
				timer_count <= timer_count + '1';
				reset <= '0';
			end if;
		end if;
	end process;
	output <= debounce;
	
end Behavioral;