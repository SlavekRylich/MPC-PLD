----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
ENTITY bcd_counter IS
  PORT(
    CLK                 : IN    STD_LOGIC;      -- clock signal
    CE_100HZ            : IN    STD_LOGIC;      -- 100 Hz clock enable
    CNT_RESET           : IN    STD_LOGIC;      -- counter reset
    CNT_ENABLE          : IN    STD_LOGIC;      -- counter enable
    DISP_ENABLE         : IN    STD_LOGIC;      -- enable display update
    CNT_0               : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
    CNT_1               : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
    CNT_2               : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0);
    CNT_3               : OUT   STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END ENTITY bcd_counter;
----------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF bcd_counter IS
----------------------------------------------------------------------------------
signal cnt_0_reg        : unsigned (3 DOWNTO 0) := (others => '0');
signal cnt_0_reg_next   : unsigned (3 DOWNTO 0);
signal cnt_1_reg        : unsigned (3 DOWNTO 0) := (others => '0');
signal cnt_1_reg_next   : unsigned (3 DOWNTO 0);
signal cnt_2_reg        : unsigned (3 DOWNTO 0) := (others => '0');
signal cnt_2_reg_next   : unsigned (3 DOWNTO 0);
signal cnt_3_reg        : unsigned (3 DOWNTO 0) := (others => '0');
signal cnt_3_reg_next   : unsigned (3 DOWNTO 0);

-- output register
signal cnt_0_reg_out : unsigned (3 DOWNTO 0) := (others => '0');
signal cnt_1_reg_out : unsigned (3 DOWNTO 0) := (others => '0');
signal cnt_2_reg_out : unsigned (3 DOWNTO 0) := (others => '0');
signal cnt_3_reg_out : unsigned (3 DOWNTO 0) := (others => '0');


----------------------------------------------------------------------------------
BEGIN
----------------------------------------------------------------------------------
  -- BCD counter
  PROCESS (CLK) BEGIN
  if rising_edge(CLK) then
    if CNT_RESET = '1' then
        cnt_0_reg <= (others => '0');
        cnt_1_reg <= (others => '0');
        cnt_2_reg <= (others => '0');
        cnt_3_reg <= (others => '0');
    else
        if CNT_ENABLE = '1' then
            cnt_0_reg <= cnt_0_reg_next;
            cnt_1_reg <= cnt_1_reg_next;
            cnt_2_reg <= cnt_2_reg_next;
            cnt_3_reg <= cnt_3_reg_next;
        end if;
    end if;
  
  end if;
  END PROCESS;
  
  PROCESS (cnt_0_reg, cnt_1_reg, cnt_2_reg, cnt_3_reg, CE_100HZ) BEGIN
    cnt_0_reg_next <= cnt_0_reg;
    cnt_1_reg_next <= cnt_1_reg;
    cnt_2_reg_next <= cnt_2_reg;
    cnt_3_reg_next <= cnt_3_reg;
                  
    if CE_100HZ = '1' then
        cnt_0_reg_next <= cnt_0_reg + 1;
        
        if (cnt_0_reg = X"9") then
            cnt_1_reg_next <= cnt_1_reg + 1;
            cnt_0_reg_next <= (others => '0');
        end if;
        
        if (cnt_1_reg = X"9") and (cnt_0_reg = X"9") then
            cnt_2_reg_next <= cnt_2_reg + 1;
            cnt_1_reg_next <= (others => '0');
        end if;
        
        if (cnt_2_reg = X"9") and (cnt_0_reg = X"9") and (cnt_1_reg = X"9") then
            cnt_3_reg_next <= cnt_3_reg + 1;
            cnt_2_reg_next <= (others => '0');
        end if;
        
        if (cnt_3_reg = X"5") and (cnt_0_reg = X"9") and (cnt_1_reg = X"9") and (cnt_2_reg = X"9") then
            cnt_3_reg_next <= (others => '0');
        end if;
        
        
    else 
        
    end if;  
    
  
  END PROCESS;
  
  --------------------------------------------------------------------------------
  -- Output (display) register
  PROCESS (CLK) BEGIN
  if rising_edge(CLK) then
  
    if (DISP_ENABLE = '1') then
        cnt_0_reg_out <= cnt_0_reg;
        cnt_1_reg_out <= cnt_1_reg;
        cnt_2_reg_out <= cnt_2_reg;
        cnt_3_reg_out <= cnt_3_reg;
    else
        
    end if;
  end if;
  end PROCESS;
----------------------------------------------------------------------------------
CNT_0 <= std_logic_vector(cnt_0_reg_out);
CNT_1 <= std_logic_vector(cnt_1_reg_out);
CNT_2 <= std_logic_vector(cnt_2_reg_out);
CNT_3 <= std_logic_vector(cnt_3_reg_out);


END ARCHITECTURE Behavioral;
----------------------------------------------------------------------------------
