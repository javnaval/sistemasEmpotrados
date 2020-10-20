library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.ALL;

ENTITY upcount IS
	PORT (Clock, Resetn, Enable : IN STD_LOGIC ;
	Q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) ) ;
END upcount;

ARCHITECTURE behavioral OF upcount IS
SIGNAL Count : std_logic_vector(1 DOWNTO 0);
BEGIN
	PROCESS( Clock , Resetn)
	BEGIN
	IF (Resetn = '0') THEN
	Count <= "00" ;
	ELSIF rising_edge(Clock) THEN
	IF (Enable = '1') THEN
	Count <= Count + 1 ;
	ELSE
	Count <= Count ;
	END IF ;
	END IF;
	END PROCESS;
	Q <= Count;
END behavioral;