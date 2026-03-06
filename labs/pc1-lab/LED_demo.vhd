----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2026 09:21:46 AM
-- Design Name: 
-- Module Name: simple_adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity <entity_name> is
	--- here define pors of component
	Port ( <in/out name> : <direction in/out> <type> [(<dimensions>)]; --- comma
		A: in STD_LOGIC;
		B: in STD_LOGIC_VECTOR (3 downto 0);
		C: out STD_LOGIC;
		D: out STD_LOGIC_VECTOR (3 downto 0) --- last without comma!
		);
end <entity_name>;

architecture Behavioral of <entity_name> is 
--- first declaration signals (use for inside logic)
	SIGNAL <signal_name appropriate to in/out of comp.> : <type_(un)signed> <dimensions>; ---comma
	SIGNAL a_uns : unsigned (A'range); --- you can use ATTRIBUTES of objects like 'range for same dimensions
	SIGNAL b_uns : unsigned (B'range);
	SIGNAL y_uns : unsigned (Y'range);
	SIGNAL res_uns : unsigned (4 downto 0);
	
BEGIN
--- Behavioral inside of component
	--- first assignment input to inside signals
	a_uns <= unsigned(A);
	b_uns <= unsigned(B);
   		
	--- inside logic with and bettween inside signals
    	res_uns <= ( "0" & a_uns) + b_uns;

	--- last assignment signals result to outputs     
    	Y <= STD_LOGIC_VECTOR (res_uns(3 downto 0));
    	C <= res_uns(4);
    	Z <= '0' WHEN (STD_LOGIC_VECTOR( unsigned( res_uns(3 downto 0)) ) ) = "0000" ELSE '1';
end Behavioral; --- comma
