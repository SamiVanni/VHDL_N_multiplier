-- Sum truth table
-- A - - B - - C - - S - - Cout
-- 0 - - 0 - -  0 - - 0 - - 0
-- 0 - - 0 - -  1 - - 1 - - 0
-- 0 - - 1 - -  0 - - 1 - - 0
-- 0 - - 1 - -  1 - - 0 - - 1
-- 1 - - 0 - -  0 - - 1 - - 0
-- 1 - - 0 - -  1 - - 0 - - 1
-- 1 - - 1 - -  0 - - 0 - - 1
-- 1 - - 1 - -  1 - - 1 - - 1
-- Sum = Cin XOR (A XOR B)
-- Cout = A B + B Cin + A Cin


library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is

port (
  A  :  in std_logic;
  B  :  in  std_logic;
  Sum  :  out std_logic;
  i_Cin  :  in  std_logic;
  o_Cout  :  out std_logic);

end entity;
 
architecture implementation of full_adder is

begin

Sum <= i_Cin XOR (A XOR B);
o_Cout <= (A AND B) OR (B AND i_Cin) OR (A AND i_Cin);

end architecture;