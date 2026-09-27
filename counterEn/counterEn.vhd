library ieee;
use ieee.std_logic_1164.all;	--will use std_logic types 
use ieee.numeric_std.all;		--need to do arithmetic


entity counterEn is

	generic 
	(
		M		:	natural := 6;	--modulo of counter (counts from 0 to M-1)
		N   	: 	natural := 3	--number of bits for counter (must be large enough!)
	);

	port
	(	-- Input ports
		clock			: in  std_logic;
		l_reset		: in 	std_logic;
		enable_in	: in 	std_logic;
		
		-- Output ports
		enable_out	: out std_logic;
		count_out	: out std_logic_vector(N-1 downto 0));
	
end counterEn;




architecture rtl of counterEn is

	signal	count 		: unsigned(N-1 downto 0);
	signal	enbOutReg	: std_logic;

	
begin
-- There can be multiple process blocks in an architecture.

-- This process is a behavioral description of a counter with enable.
	process(clock, l_reset, enable_in)
	begin
		if(l_reset = '0') then					--asynchronous l_reset (active low)
			count <= (others => '0');
		elsif(rising_edge(clock)) then
			if(enable_in = '1') then			--count only if enable asserted
				if(count < M-1) then
					count <= count + 1;
				else
					count <= (others => '0');	--wrap around modulo M
				end if;
			--else
				--count <= count;					--this else clause is optional
			end if;
		end if;
	end process;
	
	count_out <= std_logic_vector(count);	--assign count to output
	
	
-- This process is a behavioral description of maximum count detector (high when count = M-1)	
	process(clock, l_reset, enable_in, count)
	begin
		if(l_reset = '0') then
			enbOutReg <= '0';
		elsif(rising_edge(clock)) then
			if((count = M-1) and (enable_in = '1')) then
				enbOutReg <= '1';
			else
				enbOutReg <= '0';  -- this is required because we want a 1 clock long pulse
			end if;
		end if;
	end process;
	
	enable_out <= enbOutReg;
	
end rtl;
