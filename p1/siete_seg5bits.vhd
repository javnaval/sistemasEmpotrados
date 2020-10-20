----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:45:37 06/10/2010 
-- Design Name: 
-- Module Name:  
--
--5bit -to-seven-segment decoder
--	Entrada:	in 	STD_LOGIC_VECTOR (4 downto 0);
--	LED:	out	STD_LOGIC_VECTOR (7 downto 0);
-- (diseño para activo a 1)
--
-- segment encoding
--      0
--     ---  
--  5 |   | 1
--     ---   <- 6
--  4 |   | 2
--     ---
--      3				El quinto bit es el punto

-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.ALL;



entity bin5_to_7segsb is
    port (
        Entrada0:	in 	STD_LOGIC ;
		  Entrada1:	in 	STD_LOGIC ;
		  Entrada2:	in 	STD_LOGIC ;
		  Entrada3:	in 	STD_LOGIC ;
		  Entrada4:	in 	STD_LOGIC ;
	LED0:	out	STD_LOGIC ;
	LED1:	out	STD_LOGIC ;
	LED2:	out	STD_LOGIC ;
	LED3:	out	STD_LOGIC ;
	LED4:	out	STD_LOGIC ;
	LED5:	out	STD_LOGIC ;
	LED6:	out	STD_LOGIC ;
	LED7:	out	STD_LOGIC 
    );
end bin5_to_7segsb;

architecture bin5_to_7segsb_arch of bin5_to_7segsb is
 signal salida_aux: STD_LOGIC_VECTOR (7 downto 0);
signal hex: STD_LOGIC_VECTOR (3 downto 0);
  begin
hex(0) <= Entrada0 ;
hex(1) <= Entrada1 ;
hex(2) <= Entrada2 ;
hex(3) <= Entrada3 ;

salida_aux(7) <= not Entrada4;
 	
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
   LED0 <= not salida_aux(0); 
	LED1 <= not salida_aux(1); 
	LED2 <= not salida_aux(2); 
	LED3 <= not salida_aux(3); 
	LED4 <= not salida_aux(4); 
	LED5 <= not salida_aux(5); 
	LED6 <= not salida_aux(6); 
	LED7 <= not salida_aux(7); 

end bin5_to_7segsb_arch;


