library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Quadrature_Encoder is
    Port ( clk 	: in  	STD_LOGIC;
			  reset	: in  	STD_LOGIC;
			  A 		: in  	STD_LOGIC;
           B 		: in  	STD_LOGIC;
           Up 		: out  	STD_LOGIC;
			  Down 	: out  	STD_LOGIC);
end Quadrature_Encoder;

architecture Behavioral of Quadrature_Encoder is

	type state_type is (s0, s1, s2, s3);
	signal present_state, next_state : state_type;
	signal state_up, state_down : STD_LOGIC :='0';
	
begin

	State_Register: process(clk, reset)
		begin
		if(reset = '1') then
			present_state <= s0;
		elsif(clk'event and clk='1') then
			present_state <= next_state;
		end if;
	end process;
	
	C1: process(present_state, A, B)
		begin
		case present_state is
			when s0 =>
				if(A='1' and B='0') then
					next_state <= s1;
				elsif(A='0' and B='1') then
					next_state <= s2;
				else
					next_state <= s0;
				end if;
			when s1 =>
				if(A='1' and B='1') then
					next_state <= s3;
				elsif(A='0' and B='0') then
					next_state <= s0;
				else
					next_state <= s1;
				end if;
			when s2 =>
				if(A='0' and B='0') then
					next_state <= s0;
				elsif(A='1' and B='1') then
					next_state <= s3;
				else
					next_state <= s2;
				end if;
			when s3 =>
				if(A='0' and B='1') then
					next_state <= s2;
				elsif(A='1' and B='0') then
					next_state <= s1;
				else
					next_state <= s3;
				end if;
			when others =>
				null;
		end case;
	end process;

	C2: process(clk, reset)
		begin
		if(reset = '1') then
			state_up <= '0';
			state_down <= '0';
		elsif(clk'event and clk='1') then
			if((present_state=s0 and A='1' and B='0') or (present_state=s3 and A='0' and B='1')) then
				state_up <= '1';
			else
				state_up <= '0';
			end if;
			
			if((present_state=s0 and A='0' and B='1') or (present_state=s3 and A='1' and B='0')) then
				state_down <='1';
			else
				state_down <='0';
			end if;
		end if;
	end process;
	
	Up <= state_up;
	Down <= state_down;
end Behavioral;