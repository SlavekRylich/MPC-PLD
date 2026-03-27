----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
ENTITY debouncer IS
  GENERIC(
    G_DEB_PERIOD        : POSITIVE := 3
  );    
  PORT( 
    CLK                 : IN    STD_LOGIC;
    CE                  : IN    STD_LOGIC;
    BTN_IN              : IN    STD_LOGIC;
    BTN_OUT             : OUT   STD_LOGIC
  );
END ENTITY debouncer;
----------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF debouncer IS
----------------------------------------------------------------------------------
SIGNAL sig_cnt      : integer range 0 to G_DEB_PERIOD :=0;
SIGNAL sig_cnt_next : integer range 0 to G_DEB_PERIOD :=0;
SIGNAL sig          : std_logic;
SIGNAL shreg        : std_logic_vector (G_DEB_PERIOD - 1 downto 0) := (others => '0');

----------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------
--- 1st state sequential
PROCESS (CLK) BEGIN
    if rising_edge(CLK) then
        if CE = '1' then
            --- sig_cnt <= sig_cnt_next;
            shreg <= shreg(shreg'high - 1 downto 0) & BTN_IN;
        end if;
    end if;
END PROCESS;

--- 1st state sequential
PROCESS (shreg) BEGIN
    if shreg = (shreg'range => '1') then
        sig <= '1';
    end if;
    
    if shreg = (shreg'range => '0') then
        sig <= '0';
    end if;
END PROCESS;

BTN_OUT <= sig;
----------------------------------------------------------------------------------
END ARCHITECTURE Behavioral;
----------------------------------------------------------------------------------
