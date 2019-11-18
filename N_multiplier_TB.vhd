library IEEE;
use IEEE.std_logic_1164.all;

entity N_multiplier_TB is

end entity;
 
architecture TB of N_multiplier_TB is

use work.N_multiplier;

constant data_width : integer := 32;
constant double_data_width : integer := data_width*2;

signal testA : std_logic_vector(data_width-1 downto 0) := (others => '0');
signal testB : std_logic_vector(data_width-1 downto 0) := (others => '0');
signal testResult : std_logic_vector((data_width*2)-1 downto 0);

begin

testA(3 downto 0) <= "0110";
testB(3 downto 0) <= "0100";


mult1 : entity N_multiplier

	generic map (
		data_width => data_width,
		result_width => double_data_width
		)
		
	port map (
		Multiplicand => testA ,
		Multiplier => testB ,
		o_result => testResult
		);

end architecture;