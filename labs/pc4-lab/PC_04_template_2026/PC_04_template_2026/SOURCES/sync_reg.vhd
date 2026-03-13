----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
ENTITY sync_reg IS
  PORT(
    CLK                 : IN    STD_LOGIC;
    SIG_IN              : IN    STD_LOGIC;
    SIG_OUT             : OUT   STD_LOGIC
  );
END ENTITY sync_reg;
----------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF sync_reg IS
----------------------------------------------------------------------------------
SIGNAL sig_reg : std_logic;
SIGNAL sig_out_s : std_logic;

---- For Xilinx FPGAs place the following code right below the signal declaration:
--attribute ASYNC_REG : string;
--attribute ASYNC_REG of sig_reg : signal is "TRUE";
--attribute ASYNC_REG of sig_out : signal is "TRUE";

---- For Xilinx FPGAs place the following code right below the signal declaration:
--attribute SHREG_EXTRACT : string;
--attribute SHREG_EXTRACT of sig_reg : signal is "NO";
--attribute SHREG_EXTRACT of sig_out : signal is "NO";


----------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------
--- 1st state sequential
PROCESS (CLK) BEGIN
    if rising_edge(CLK) then
        sig_reg <= SIG_IN;
        sig_out_s <= sig_reg;
    end if;
END PROCESS;

----- 2nd state sequential
    --PROCESS (CLK) BEGIN
    --if rising_edge(clk) then
    --    sig_out <= sig_reg;
    --end if;
--END PROCESS;

SIG_OUT <= sig_out_s;
----------------------------------------------------------------------------------
END ARCHITECTURE Behavioral;
----------------------------------------------------------------------------------
