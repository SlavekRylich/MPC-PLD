----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/27/2026 09:36:45 AM
-- Design Name: 
-- Module Name: simple_adder_tb - Behavioral
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

entity simple_adder_tb is
--  Port ( );
end simple_adder_tb;

architecture Behavioral of simple_adder_tb is

--- vytáhnu svoji testovanou entitu jakoby ze skladu, akorát místo entity nazvu component a na konec "COMPONENT" taky
COMPONENT simple_adder_src is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0);
           C : out STD_LOGIC;
           Z : out STD_LOGIC);
end COMPONENT simple_adder_src;

--- deklarace signálů - signály jsou jako propojení na pracovní desce v labu
SIGNAL a_sig : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL b_sig : STD_LOGIC_VECTOR (3 downto 0); 
SIGNAL y_sig : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL c_sig : STD_LOGIC;                    
SIGNAL z_sig : STD_LOGIC;  
SIGNAL y_ref : STD_LOGIC_VECTOR (4 downto 0);
                 
begin
--- Component instantiation - mohl bych vytvořít více instancí samozřejmě s unikátním názvem
--- UUT - Unit Under Test 
--- port map = piny součástky
simple_adder_i : simple_adder_src
Port Map( 
A => a_sig,
B => b_sig,
Y => y_sig,
C => c_sig,
Z => z_sig
);


--- stimulus generator, může být i více processů zaráz
--- každý process je jakoby jiný generátor a jiný měřák
PROCESS
variable temp_j : integer := 0;
variable temp_k : integer := 0;
BEGIN 
--- podobně jako sekvenční kód vyhodnocováno krok za krokem 
    --- stejné zápisy, protože čistě 1 je INT,což se musí konvertovat přes signed nebo unsigned    
    
    a_sig <= std_logic_vector(to_unsigned(1,4));
    a_sig <= std_logic_vector(to_unsigned(1,a_sig'length));
    a_sig <= "0001";
    a_sig <= X"1";
    b_sig <= X"1";
    WAIT FOR 10 ns; --- nechám mu chvilku času aby vše stihl
    
    
    
    b_sig <= X"5";
    
    loop_1: for j in 1 to 16 loop
        temp_j := temp_j + j;
        a_sig <= std_logic_vector ( to_unsigned(j, 4) );
        
        WAIT FOR 5 ns;
        loop_2: for k in 1 to 16 loop
            temp_k := temp_k + k;
            b_sig <= std_logic_vector ( to_unsigned(k, 4) );
            WAIT FOR 5 ns;
        end loop loop_2;
        
    end loop loop_1;
    
    --- zastavení kódu aby neběžel opakovaně do konce limitu pro simulaci 
    WAIT;
    --- nebo Reportem
    REPORT "Simulation finished!" severity FAILURE;

END PROCESS;
--- po konci processu se dále opakuje, proto musím ukončít na posledním řádku pomocí WAIT;

-- Output Checker 
--- do argumentů se dává sensitive list, což jsou trigerry, které vyvolají spuštění svojí změnou
--- ! Pozor zde se sensistivity list chová trochu jinak v tb než v src
--- PROCESS(a_sig, b_sig) -> místo toho wait on a wait for x ns;

PROCESS 
--- proměnnou nelze zobrazit v simulátoru, ale lze ji reportovat
    variable cnt_err : integer := 0;
begin

    WAIT on a_sig, b_sig;
    y_ref <= std_logic_vector ( "00000" + unsigned(a_sig) + unsigned(b_sig) );
    
    WAIT FOR 1 ns; -- ochrana pro odložené přiřazení, které se ve skutečnosti neději přesně v době kdy je to napsané na řádku
    --- ? y_sig = y_ref
    
    --- ASSERT policajt v kódu k zachycení chyb, generuje mi zprávy v tcl konzoli
    ASSERT  y_sig = y_ref report "Error in addition" severity ERROR; 
    --- SEVERITY - NOTE, WARNING, ERROR, FAILURE
    
    IF NOT (y_sig = y_ref) then
        --- u proměnných se používá přiřazení a signálů zase <= 
        cnt_err := cnt_err + 1;
--        report "Error in addiiton! Expected Y: " & STD_LOGIC_VECTOR'image(unsigned(y_ref)) & ", actual Y = " & STD_LOGIC_VECTOR'image(y_sig)
        report "Error in addiiton - expected Y: " &
            integer'image((unsigned(y_sig)))  
--            ", actual Y = " & 
--            (y_sig) 
            severity ERROR;
    end if;
    
    report "Error in addiiton! Current error count: " & integer'image(cnt_err) 
    severity ERROR;
END PROCESS;

end Behavioral;
