----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
ENTITY ce_gen IS
  GENERIC (
    G_DIV_FACT          : POSITIVE := 5
  );
  PORT (
    CLK                 : IN  STD_LOGIC;
    SRST                : IN  STD_LOGIC;
    CE                  : IN  STD_LOGIC;
    CE_O                : OUT STD_LOGIC 
  );
END ENTITY ce_gen;
----------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF ce_gen IS
----------------------------------------------------------------------------------
SIGNAL cnt_div      :   INTEGER RANGE 0 to G_DIV_FACT :=0; ---unsigned (31 downto 0) := (others => '0');
SIGNAL cnt_div_next :   INTEGER RANGE 0 to G_DIV_FACT; --- unsigned (31 downto 0) := (others => '0');
SIGNAL clk_en       :   std_logic;

----------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------
--- sequential part
PROCESS (CLK) BEGIN
IF rising_edge(CLK) then
    if SRST = '1' then
        --- cnt_div <= (others => '0');
        cnt_div <= 0;
    else
        if CE = '1' then
            cnt_div <= cnt_div_next;
        end if;        
    end if;
end if;
END PROCESS;

--- combination part
PROCESS (cnt_div) BEGIN
--- default assignments
cnt_div_next <= cnt_div;

if cnt_div >= (G_DIV_FACT - 1) then
    cnt_div_next <= 0;
    clk_en <= '1';
else
    cnt_div_next <= cnt_div + 1;
    clk_en <= '0';
end if;
END PROCESS;

CE_O <= clk_en;
----------------------------------------------------------------------------------
END Behavioral;
----------------------------------------------------------------------------------
