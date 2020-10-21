--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:16:59 10/13/2020
-- Design Name:   
-- Module Name:   C:/xilinx_proj/p1/upcount_tb.vhd
-- Project Name:  p1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: upcount
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY upcount_tb IS
END upcount_tb;
 
ARCHITECTURE behavior OF upcount_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT upcount
    PORT(
         Clock : IN  std_logic;
         Resetn : IN  std_logic;
         Enable : IN  std_logic;
         Q : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal Resetn : std_logic := '0';
   signal Enable : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: upcount PORT MAP (
          Clock => Clock,
          Resetn => Resetn,
          Enable => Enable,
          Q => Q
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
