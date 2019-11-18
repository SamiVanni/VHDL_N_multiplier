library IEEE;
use IEEE.std_logic_1164.all;

entity rc_adder is

generic (
	data_width : integer := 32
	);

port (
  i_Aword  	:  in std_logic_vector(data_width - 1 downto 0);
  i_Bword  	:  in std_logic_vector(data_width - 1 downto 0);
  o_Sumword :  out std_logic_vector(data_width - 1 downto 0);
  i_Cin  	:  in  std_logic;
  o_Cout  	:  out std_logic
  );

end entity;

architecture implementation of rc_adder is

use work.full_adder;

signal s_carry_chain : std_logic_vector(data_width-1 downto 1);

begin

adder : for i in data_width-1 downto 0 generate
	
begin

	msb_cell : if i=data_width-1 generate
		--most significant cell
		add_bit : entity full_adder
			port map (
				A => i_Aword(i),
				B => i_Bword(i),
				Sum => o_sumword(i),
				i_Cin => s_carry_chain(i),
				o_Cout => o_Cout
				);
	end generate msb_cell;
			
	lsb_cell : if i=0 generate
		--least significant cell
		add_bit : entity full_adder
			port map(
				A => i_Aword(i),
				B => i_Bword(i),
				Sum => o_sumword(i),
				i_Cin => i_Cin,
				o_Cout => s_carry_chain(i+1)
				);
	end generate lsb_cell;

	mid_cell : if (i>0) AND (i<data_width-1) generate
		--middle cells
		add_bit : entity full_adder	
			port map(
				A => i_Aword(i),
				B => i_Bword(i),
				Sum => o_sumword(i),
				i_Cin => s_carry_chain(i),
				o_Cout => s_carry_chain(i+1)
				);
	end generate mid_cell;

end generate adder;


end architecture;