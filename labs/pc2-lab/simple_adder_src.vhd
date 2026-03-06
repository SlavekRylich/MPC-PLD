----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2026 09:23:14 AM
-- Design Name: 
-- Module Name: simple_adder_src - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simple_adder_src is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0);
           C : out STD_LOGIC;
           Z : out STD_LOGIC);
end simple_adder_src;

architecture Behavioral of simple_adder_src is
--- declaration
SIGNAL a_uns : unsigned (A'range);
SIGNAL b_uns : unsigned (B'range);
SIGNAL y_uns : unsigned (Y'range);
SIGNAL res_uns : unsigned (4 downto 0);


begin
--- Behavioral 
    a_uns <= unsigned(A);
    b_uns <= unsigned(B);
    
    res_uns <= ( "0" & a_uns) + b_uns;
    
    Y <= STD_LOGIC_VECTOR (res_uns(3 downto 0));
    C <= res_uns(4);
    Z <= '0' WHEN (STD_LOGIC_VECTOR( unsigned( res_uns(3 downto 0)) ) ) = "0000" ELSE '1';

end Behavioral;
