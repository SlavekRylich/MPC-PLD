--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--------------------------------------------------------------------------------
ENTITY stopwatch_fsm IS
  PORT (
    CLK                 : IN    STD_LOGIC;
    BTN_S_S             : IN    STD_LOGIC;
    BTN_L_C             : IN    STD_LOGIC;
    CNT_RESET           : OUT   STD_LOGIC;
    CNT_ENABLE          : OUT   STD_LOGIC;
    DISP_ENABLE         : OUT   STD_LOGIC
  );
END ENTITY stopwatch_fsm;
--------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF stopwatch_fsm IS
--------------------------------------------------------------------------------

signal cnt_reset_sig  : std_logic;
signal cnt_enable_sig  : std_logic;
signal disp_enable_sig  : std_logic;

signal cnt_reset_sig_out  : std_logic;
signal cnt_enable_sig_out  : std_logic;
signal disp_enable_sig_out  : std_logic;

signal next_st      : unsigned (2 downto 0) := (others => '0');
signal pres_st      : unsigned (2 downto 0) := (others => '0');

--------------------------------------------------------------------------------
BEGIN
--------------------------------------------------------------------------------
    --- REG 1
    PROCESS (CLK) BEGIN
        if rising_edge(CLK) then
            pres_st <= next_st;
    
        end if;
    END PROCESS;
    
        --- REG 2
    PROCESS (CLK) BEGIN
        if rising_edge(CLK) then
            cnt_reset_sig_out <= cnt_reset_sig;
            cnt_enable_sig_out <= cnt_enable_sig;
            disp_enable_sig_out <= disp_enable_sig;
    
        end if;
    END PROCESS;
    
    --- next state logic
    PROCESS (pres_st, BTN_S_S, BTN_L_C) BEGIN
        case pres_st is 
            when "000" =>    -- Idle
                if BTN_L_C = '0' and BTN_S_S = '1' then
                    next_st <= "001"; --> to RUN
                else
                    next_st <= pres_st;
                    
                end if;
            
            when "001" =>    -- Run
                if BTN_L_C = '0' and BTN_S_S = '1' then
                    next_st <= "100"; --> to Stop
                    
                elsif BTN_L_C = '1' and BTN_S_S = '0' then
                    next_st <= "010"; --> to Lap
                else
                    next_st <= pres_st;
                    
                end if;
            
            when "010" =>    -- Lap
                if BTN_L_C = '0' and BTN_S_S = '1' then
                    next_st <= "001"; --> to Run
                    
                elsif BTN_L_C = '1' and BTN_S_S = '0' then
                    next_st <= "011"; --> to Refresh
                else
                    next_st <= pres_st;
                    
                end if;
                
            when "011" =>    -- Refresh
                    next_st <= "010"; --> to Lap
                    
                
            when "100" =>    -- Stop
                if BTN_L_C = '0' and BTN_S_S = '1' then
                    next_st <= "001"; --> to Run
                    
                elsif BTN_L_C = '1' and BTN_S_S = '0' then
                    next_st <= "000"; --> to Idle
                else
                    next_st <= pres_st;
                end if;
                
            when others =>  -- Default
                next_st <= "010";   --> to Lap
            end case;
        
    END PROCESS;
    
    --- out logic
    PROCESS (pres_st) BEGIN
        case pres_st is 
            when "000" =>    -- Idle
                cnt_reset_sig   <= '1';
                cnt_enable_sig  <= '0';
                disp_enable_sig <= '1';
            
            when "001" =>    -- Run
                cnt_reset_sig   <= '0';
                cnt_enable_sig  <= '1';
                disp_enable_sig <= '1';
            
            when "010" =>    -- Lap
                cnt_reset_sig   <= '0';
                cnt_enable_sig  <= '1';
                disp_enable_sig <= '0';
                
            when "011" =>    -- Refresh
                cnt_reset_sig   <= '0';
                cnt_enable_sig  <= '1';
                disp_enable_sig <= '1';
                
            when "100" =>    -- Stop
                cnt_reset_sig   <= '0';
                cnt_enable_sig  <= '0';
                disp_enable_sig <= '1';
            
            
            when others =>  -- same as Idle
                cnt_reset_sig   <= '0';
                cnt_enable_sig  <= '1';
                disp_enable_sig <= '0';
            end case;
    END PROCESS;
    
    
    
    
CNT_RESET <= cnt_reset_sig_out;
CNT_ENABLE <= cnt_enable_sig_out;
DISP_ENABLE <= disp_enable_sig_out;
--------------------------------------------------------------------------------
END ARCHITECTURE Behavioral;
--------------------------------------------------------------------------------
