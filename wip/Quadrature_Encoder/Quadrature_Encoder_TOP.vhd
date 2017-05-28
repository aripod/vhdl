library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Quadrature_Encoder_TOP is
    Port ( clk 	: in  	STD_LOGIC;
			  reset	: in  	STD_LOGIC;
			  A 		: in  	STD_LOGIC;
           B 		: in  	STD_LOGIC;
           Up 		: out  	STD_LOGIC;
			  Down 	: out  	STD_LOGIC);
end Quadrature_Encoder_TOP;

architecture Behavioral of Quadrature_Encoder_TOP is

	signal delay_A : STD_LOGIC_VECTOR(1 downto 0);
	signal delay_B : STD_LOGIC;
	signal pulse_A : STD_LOGIC;
	signal sig_up, sig_down : STD_LOGIC;

begin

	sync_A: process(clk)
		begin
		if(rising_edge(clk)) then
			delay_A(0) <= delay_A(1);
			delay_A(1) <= A;
		end if;
	end process;
	pulse_A <= delay_A(1) and (not delay_A(0));
	
	proc_sync_B: process(clk)
		begin
		if(rising_edge(clk)) then
			delay_B <= B;
		end if;
	end process;
	
	turn: process(clk)
		begin
		if(pulse_A='1') then
			if(delay_B='1') then
				sig_up <= '0';
				sig_down <= '1';
			else
				sig_up <= '1';
				sig_down <= '0';
			end if;
		else
			sig_up <= '0';
			sig_down <='0';
		end if;
	end process;
	Up <= sig_up;
	Down <= sig_down;
end Behavioral;