--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:32:12 10/13/2020
-- Design Name:   
-- Module Name:   C:/xilinx_proj/p1/debouncer_tb.vhd
-- Project Name:  p1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: debouncer
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
 
ENTITY debouncer_tb IS
END debouncer_tb;
 
ARCHITECTURE behavior OF debouncer_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT debouncer
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         x : IN  std_logic;
         xDeb : OUT  std_logic;
         xDebFallingEdge : OUT  std_logic;
         xDebRisingEdge : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal x : std_logic := '0';

 	--Outputs
   signal xDeb : std_logic;
   signal xDebFallingEdge : std_logic;
   signal xDebRisingEdge : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: debouncer PORT MAP (
          rst => rst,
          clk => clk,
          x => x,
          xDeb => xDeb,
          xDebFallingEdge => xDebFallingEdge,
          xDebRisingEdge => xDebRisingEdge
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
