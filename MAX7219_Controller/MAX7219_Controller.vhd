----------------------------------------------------------------------------------
-- Description: MAX7219 Controller for 8 7-Segment displays.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MAX7219_Controller is
    Port ( Address_in : in  STD_LOGIC_VECTOR (3 downto 0);
           Data_in : in  STD_LOGIC_VECTOR (3 downto 0);
           Clk : in  STD_LOGIC;
			  Start : in  STD_LOGIC;
           Dout : out  STD_LOGIC;
           CS : out  STD_LOGIC);
end MAX7219_Controller;

architecture Behavioral of MAX7219_Controller is

	signal data : STD_LOGIC_VECTOR (15 downto 0):=(others=>'0');
	signal data_out : STD_LOGIC:='0';
	signal count_enable : STD_LOGIC:='0';
	signal count : STD_LOGIC_VECTOR (5 downto 0):=(others=>'0');
	signal CS_signal : STD_LOGIC:='1';
begin

	process(clk)
		begin
		if(clk'event and clk='1') then
			if(Start = '1') then
				data(3 downto 0) <= Data_in;
				data(11 downto 8) <= Address_in;
				count <= (others=>'0');
				count_enable <= '1';
			else
				if(count_enable = '1') then
					CS_signal <= '0';
					data_out <= data(15);
					data <= data(14 downto 0) & '0';
					count <= count + 1;
					if(count = "10000") then
						CS_signal <= '1';
						count_enable <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;
	
	Dout <= data_out;
	CS <= CS_signal;

end Behavioral;