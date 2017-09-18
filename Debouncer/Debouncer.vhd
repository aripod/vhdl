library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.functions.all;
  
entity Debouncer is
	Generic ( T : integer := 10;   -- Time (in ms) for the delay.
	          N : integer := 5 );  -- Number of buttons to debounce.
	Port ( clk : in  STD_LOGIC;
          in_button : in  STD_LOGIC_VECTOR(N-1 downto 0);
          out_debounced : out  STD_LOGIC_VECTOR(N-1 downto 0));
end Debouncer;

architecture Behavioral of Debouncer is

    type delay_matrix is array (0 to N-1, 0 to 1) of STD_LOGIC;

	signal ms_counter : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
	signal ms_pulse : STD_LOGIC := '0';
	signal delay : delay_matrix;
	signal rise_edge : STD_LOGIC;
	signal count_enable : STD_LOGIC := '0';
    signal timer_count : STD_LOGIC_VECTOR (log2(T) downto 0) := (others=>'0');
	signal debounce : STD_LOGIC_VECTOR(N-1 downto 0) := (others=>'0');
	signal reset : STD_LOGIC;
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

    generate_statement: for I in 0 to N-1 generate
        sync_and_edge_detection : process(clk)	-- Detects rising and falling edge.
            begin
            if(rising_edge(clk)) then
                delay(I,0) <= delay(I,1);
                delay(I,1) <= in_button(I);
            end if;
        end process;
        rise_edge <= delay(I,1) and (not delay(I,0));
    
        count_proc: process(clk)
            begin
            if(rising_edge(clk)) then
                if(timer_count=T) then
                    timer_count <= (others=>'0');
                    debounce(I) <= in_button(I);
                    reset <= '1';
                elsif(ms_pulse='1') then
                    timer_count <= timer_count + '1';
                    reset <= '0';
                end if;
            end if;
        end process;
        out_debounced(I) <= debounce(I);
    end generate generate_statement;
	
end Behavioral;