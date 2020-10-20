----------------------------------------------------------------------------------
-- Company: UCM
-- Engineer: Javier Navalón Carrasco
-- 
-- Create Date:    20:48:05 10/12/2020 
-- Design Name: 
-- Module Name:    maquina_tragaperras - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Slot machine, assignment made for Sistemas Empotrados
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--convenio: rst resetea a 1, jugar juega a 1

entity maquina_tragaperras is
	port(clk_in: in STD_LOGIC;
	pushb1: in STD_LOGIC; --jugar
	pushb2: in STD_LOGIC; --reset 
	leds1, leds2, leds3, leds4, leds5, leds6,
	leds7, leds8: out STD_LOGIC;
	display0, display1, display2, display3,
	display4, display5, display6: out STD_LOGIC
	);
end maquina_tragaperras;

architecture Behavioral of maquina_tragaperras is

	 function To_Std_Logic(L: BOOLEAN) return std_logic is
		begin
		if L then
		return('1');
		else
		return('0');
		end if;
	end function To_Std_Logic;
	
	
	component debouncer IS
  PORT (
    rst: IN std_logic;
    clk: IN std_logic;
    x: IN std_logic;
    xDeb: OUT std_logic;
    xDebFallingEdge: OUT std_logic;
    xDebRisingEdge: OUT std_logic
	);
END component debouncer;
		
	component divisor1 is 
 port (
        rst: in STD_LOGIC;
        clk_in: in STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end component divisor1;

	 component upcount IS
	PORT (Clock, Resetn, Enable : IN STD_LOGIC ;
	Q : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) ) ;
END component upcount;

	type states is (s0, s1, s2, s3);
	signal current_state:states;
	signal next_state:states;
	
	signal clk_1hz: std_logic;
	signal x_jugar, jugar, rst: std_logic;
	signal num1, num2, num3, pg, pm:std_logic;
	signal num1_res, num2_res, num3_res:std_logic_vector(1 downto 0);
	
begin
	leds8 <= '0';
	leds7 <= '0';
	jugar <= pushb1;
	rst <= not pushb2;
	
	leds1 <= num1_res(0);
	leds2 <= num1_res(1);
	leds3 <= num2_res(0);
	leds4 <= num2_res(1);
	leds5 <= num3_res(0);
	leds6 <= num3_res(1);
	
	display6 <= pm;
	display0 <= pg;
	display1 <= pg;
	display2 <= pg;
	display3 <= pg;
	display4 <= pg;
	display5 <= pg;

	divisor: divisor1 
	port map(clk_in => clk_in,
	rst => rst,
	clk_out=>clk_1hz);
	
	deb: debouncer
	port map(rst => not rst,
	clk  => clk_in,
	x => jugar,
	xDebFallingEdge=>x_jugar);
	
	slot1: upcount
	port map(
	Clock => clk_1hz,
	Resetn => not rst,
	Enable => not num1,
	Q => num1_res );
	
	slot2: upcount
	port map(
	Clock => clk_1hz,
	Resetn => not rst,
	Enable => not num2,
	Q => num2_res);
	
	slot3: upcount
	port map(
	Clock => clk_1hz,
	Resetn => not rst,
	Enable => not num3,
	Q => num3_res);

	state_change: process(clk_in, rst)
	begin
		if (rising_edge(clk_in)) then
		 if(rst='1') then current_state <= s0;
		 else current_state <= next_state;
		 end if;
		end if;
	end process state_change;
	
	next_state_outputs: process(x_jugar, current_state, pg, num1_res,
	num2_res, num3_res, rst)
	
	begin		
	case current_state is
	when s0 =>   
	if (x_jugar='1') then 
		next_state <= s1 ;
		num1 <= '1';
		num2 <= '0';
		num3 <= '0';
	else
		next_state <= s0 ;
		num1 <= '0';
		num2 <= '0';
		num3 <= '0';
	end if;
	when s1 =>   
	if (x_jugar='1') then 
		next_state <= s2;
		num1 <= '1';
		num2 <= '1';
		num3 <= '0';
	else
		next_state <= s1;
		num1 <= '1';
		num2 <= '0';
		num3 <= '0';
	end if;
	when s2 =>   
	if (x_jugar='1') then 
		next_state <= s3 ;
		num1 <= '1';
		num2 <= '1';
		num3 <= '1';
	else
		next_state <= s2;
		num1 <= '1';
		num2 <= '1';
		num3 <= '0';
	end if;
	when s3 =>   
	if (x_jugar='1') then 
		next_state <= s0 ;
		num1 <= '0';
		num2 <= '0';
		num3 <= '0';
	else
		next_state <= s3;
		num1 <= '1';
		num2 <= '1';
		num3 <= '1';
	end if;
	when others => null;
	end case;
	
	end process next_state_outputs;
	
	salida_premio: process(num1_res, num2_res, num3_res, pg, pm, current_state,
	x_jugar)
	begin
	case current_state is
	when s2 => if (x_jugar='1') then 
	pg <= To_Std_Logic((num1_res=num2_res) and (num2_res=num3_res));
	pm <= (not pg and To_Std_Logic((num1_res=num2_res)or(num1_res=num3_res)or
	(num3_res=num2_res)));
	else pg<='0'; pm<='0';
	end if;
	when s3 => 
	pg <= To_Std_Logic((num1_res=num2_res) and (num2_res=num3_res));
	pm <= (not pg and To_Std_Logic((num1_res=num2_res)or(num1_res=num3_res)or
	(num3_res=num2_res)));
	when others => pg<='0'; pm<='0';
	end case;
	end process salida_premio;
end Behavioral;

