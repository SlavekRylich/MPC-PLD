----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
ENTITY edge_detector IS
  PORT(
    CLK                 : IN    STD_LOGIC;
    SIG_IN              : IN    STD_LOGIC;
    EDGE_POS            : OUT   STD_LOGIC;
    EDGE_NEG            : OUT   STD_LOGIC;
    EDGE_ANY            : OUT   STD_LOGIC
  );
END ENTITY edge_detector;
----------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF edge_detector IS
----------------------------------------------------------------------------------
SIGNAL sig_btn      : std_logic;
SIGNAL sig_btn_del  : std_logic;
SIGNAL sig_edge_pos : std_logic;
SIGNAL sig_edge_neg : std_logic;
SIGNAL sig_edge_any : std_logic;

----------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------
PROCESS (clk) BEGIN
if rising_edge(clk) then
    sig_btn <= SIG_IN;
    
    if sig_btn = '1' then
        sig_btn_del <= sig_btn;
    end if;
end if;
END PROCESS;

PROCESS (sig_btn, sig_btn_del) BEGIN

if sig_btn = '1' and sig_btn = '0' then
    sig_edge_pos <= '1';
    sig_edge_any <= '1';
elsif sig_btn = '0' and sig_btn = '1' then 
    sig_edge_neg <= '1';
    sig_edge_any <= '1';
else
    sig_edge_pos <= '0';
    sig_edge_neg <= '1';
    sig_edge_any <= '0';
end if;
END PROCESS;

EDGE_POS <= sig_edge_pos;
EDGE_NEG <= sig_edge_neg;
EDGE_ANY <= sig_edge_any;
----------------------------------------------------------------------------------
END ARCHITECTURE Behavioral;
----------------------------------------------------------------------------------
