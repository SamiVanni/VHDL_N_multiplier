library IEEE;
use IEEE.std_logic_1164.all;

entity N_multiplier is

generic (
	data_width : integer := 32;
	result_width : integer := 64
	);

port (
	Multiplicand 	: in std_logic_vector(data_width - 1 downto 0);
	Multiplier 		: in std_logic_vector(data_width - 1 downto 0);
	o_Result			: out std_logic_vector(result_width - 1 downto 0)
	);

end entity;

architecture implementation of N_multiplier is

------------------------------------
-- Architecture declarative items --
------------------------------------

use work.rc_adder;

constant data_width_double : integer := data_width*2;

--Notice that the range of slv is at purpose 1 bigger than data_width. This is because sum lsb at every step is assigned using this bit.
type adderinterconnect is array (data_width-1 downto 0) of std_logic_vector(data_width downto 0);

-- Decided to initialize one big 2d array of connection fabric between the adders, because otherwise there wouldnt be anything
-- to connect the output of the adder.

signal w_fabric : adderinterconnect := (others => (others => '0'));

begin

----------------------
-- Top lvl generate --
----------------------
-- Each iteration creates a full_adder and connects it to the fabric. Also the AND gates shown in design schematic
-- are connected to the adder.

multiplier_block : for i in data_width-1 downto 0 generate

signal r_andvector : std_logic_vector(data_width-1 downto 0) := (others => '0');

begin

	
	--This generates the first cell. Notice that there is no rc_adder.
	ls_cell : if i=0 generate
		
		begin
		
		andgates_counter : for j in data_width-1 downto 0 generate
		r_andvector(j) <= Multiplicand(j) AND Multiplier(0);
		end generate andgates_counter;
		
		o_result(0) <= r_andvector(0);
		w_fabric(i)(data_width-1 downto 1) <= r_andvector(data_width-1 downto 1); 		--B2-B0 input bits to the first middle adder (example schematic)
		w_fabric(i)(data_width) <= '0'; 																--This is the B3 input bit connected to first middle adder (example schematic).
		
	end generate ls_cell;
	
	--Middle adders
	mid_cell : if i>0 AND i<data_width-1 generate
	
		andgates_counter : for j in data_width-1 downto 0 generate
		r_andvector(j) <= Multiplicand(j) AND Multiplier(i);
		end generate andgates_counter;
	
		o_result(i) <= w_fabric(i)(0);
	
		adder : entity rc_adder
		generic map 
			(
			data_width 		=> data_width
			)
			
		port map 
			(
			i_Aword 			=> r_andvector(data_width-1 downto 0),
			i_Bword 			=> w_fabric(i-1)(data_width downto 1),
			o_Sumword 		=> w_fabric(i)(data_width-1 downto 0) ,
			i_Cin 			=> '0',
			o_Cout 			=> w_fabric(i)(data_width)
			);
	
	end generate mid_cell;
	
	--Last adder
	ms_cell : if i=data_width-1 generate
	
		andgates_counter : for j in data_width-1 downto 0 generate
		r_andvector(j) <= Multiplicand(j) AND Multiplier(i);	
		end generate andgates_counter;
	
		
	
		adder : entity rc_adder
		generic map 
			(
			data_width 		=> data_width
			)
			
		port map 
			(
			i_Aword 			=> r_andvector(data_width-1 downto 0),
			i_Bword 			=> w_fabric(i-1)(data_width downto 1),
			o_Sumword 		=> o_result(data_width_double-2 downto data_width-1) ,
			i_Cin 			=> '0',
			o_Cout 			=> o_result(data_width_double-1)
			);
	
	end generate ms_cell;
		



end generate multiplier_block;

end architecture;