library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.ALL;

--5bit -to-seven-segment decoder 
--	Entrada:	in 	STD_LOGIC_VECTOR (4 downto 0);
--	LED:	out	STD_LOGIC_VECTOR (6 downto 0);
-- (diseño para activo a 1)
--
-- segment encoding
--      0
--     ---  
--  5 |   | 1
--     ---   <- 6
--  4 |   | 2
--     ---
--      3			El quinto bit es el punto


entity bin5_to_7seg is
    port (
        Entrada:	in 	STD_LOGIC_VECTOR (4 downto 0);
	LED:	out	STD_LOGIC_VECTOR (7 downto 0)
    );
end bin5_to_7seg;

architecture bin5_to_7seg_arch of bin5_to_7seg is
 signal salida_aux: STD_LOGIC_VECTOR (7 downto 0);
signal hex: STD_LOGIC_VECTOR (3 downto 0);
  begin
hex <= Entrada (3 downto 0);
salida_aux(7) <= not Entrada (4);
 	
    with HEX SELect
	salida_aux (6 downto 0) <="1111001" when "0001",	--1
		"0100100" when "0010",	--2
		"0110000" when "0011",	--3
		"0011001" when "0100",	--4
		"0010010" when "0101",	--5
		"0000010" when "0110",	--6
		"1111000" when "0111",	--7
		"0000000" when "1000",	--8
		"0010000" when "1001",	--9
		"0001000" when "1010",	--A
		"0000011" when "1011",	--b
		"1000110" when "1100",	--C
		"0100001" when "1101",	--d
		"0000110" when "1110",	--E
		"0001110" when "1111",	--F
		"1000000" when others;	--0
   LED <= not salida_aux; 

end bin5_to_7seg_arch;
