library ieee;
use ieee.std_logic_1164.all;


entity timer is

	port
	(	-- Input ports
		clk		: in  std_logic;
		l_reset	: in 	std_logic;
		run_timer: in	std_logic;

		-- Output ports
		
		HEX0				: out std_logic_vector(0 to 6); -- to seven segment display for seconds (ones position)
		
		-----------------------------
		-- Add 3 other HEX outputs --
		-----------------------------
		HEX1				: out std_logic_vector(0 to 6); -- to seven segment display for seconds (tens position)
		HEX2				: out std_logic_vector(0 to 6); -- to seven segment display for minutes (ones position)
		HEX3				: out std_logic_vector(0 to 6) -- to seven segment display for minutes (tens position)
	);
		
end timer;




architecture rtl of timer is

	signal	enb1, enb2, enb3, prescaleEnb							: std_logic;
	signal	cntSecOnes, cntSecTens, cntMinOnes, cntMinTens	: std_logic_vector(3 downto 0);
	
	
	component counterEn 
		generic(	M		: natural;
					N     : natural);
					
		port(		clock, l_reset, enable_in 	: in	std_logic;
					enable_out						: out std_logic;
					count_out						: out std_logic_vector(N-1 downto 0));
	end component;

	
	component hex7seg is
		port(	d : in  std_logic_vector(3 downto 0);
				y : out std_logic_vector(0 to 6));
	end component;

begin

----------------------------------------------------------------
-- add the code for the other 3 required counters and outputs --
----------------------------------------------------------------
	
--	cntMinTens <= "1000";

	minTens : counterEn
		generic map(M => 6, N => 4)
		
		port map(	clock => clk,
						l_reset => l_reset,
						enable_in => enb3,
--						enable_out => ,
						count_out => cntMinTens);
	
	minOnes : counterEn
		generic map(M => 10, N => 4)
		
		port map(	clock => clk,
						l_reset => l_reset,
						enable_in => enb2,
						enable_out => enb3,
						count_out => cntMinOnes);
						
	
	secTens : counterEn
		generic map(M => 6, N => 4)
		
		port map(	clock => clk,
						l_reset => l_reset,
						enable_in => enb1,
						enable_out => enb2,
						count_out => cntSecTens);
	
	secOnes : counterEn
		generic map(M => 10, N => 4)
		
		port map(	clock => clk,
						l_reset => l_reset,
						enable_in => prescaleEnb,
						enable_out => enb1,
						count_out => cntSecOnes);
						



	prescalar : counterEn
		generic map(M => 100000, N => 26) --for demo only you will have to set to correct values
--		generic map(M => 50000000, N => 26) --for demo only you will have to set to correct values

	
		port map(	clock => clk,
						l_reset => l_reset,
						enable_in => run_timer,
						enable_out => prescaleEnb);
									
														
-------------------------------------------------
-- add code required to display other 3 digits --
-------------------------------------------------
	dispMinTens	: hex7seg
		port map(	d	=> cntMinTens,
						y	=> HEX3);
						
	dispMinOnes	: hex7seg
		port map(	d	=> cntMinOnes,
						y	=> HEX2);
						
	dispSecTens	: hex7seg
		port map(	d	=> cntSecTens,
						y	=> HEX1);						

	dispSecOnes	: hex7seg
		port map(	d	=> cntSecOnes,
						y	=> HEX0);
						
end rtl;
