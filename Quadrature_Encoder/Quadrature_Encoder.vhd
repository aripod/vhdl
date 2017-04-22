library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Quadrature_Encoder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Up : out  STD_LOGIC;
			  Down : out  STD_LOGIC);
end Quadrature_Encoder;

architecture Behavioral of Quadrature_Encoder is

	signal state_up, state_down : STD_LOGIC;
	
begin

	process(A,B)
		begin
		if(A'event and A='1') then
			if(B='1') then
				state_up <= '0';
				state_down <= '1';
			else
				state_up <='1';
				state_down <='0';
			end if;
		end if;
	end process;
	
	Up <= A and state_up;
	Down <= A and state_down;

end Behavioral;