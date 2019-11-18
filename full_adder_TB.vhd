library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_TB is

port (

  Sum  :  out std_logic;
  o_Cout  :  out std_logic);

end entity;
 
architecture TB of full_adder_TB is

signal  A  :  std_logic := '1';
signal  B  :    std_logic := '0';
signal  i_Cin  :    std_logic :='1';
  
begin

Sum <= i_Cin XOR (A XOR B);
o_Cout <= (A AND B) OR (B AND i_Cin) OR (A AND i_Cin);

end architecture;