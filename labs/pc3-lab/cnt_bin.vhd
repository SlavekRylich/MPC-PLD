----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2026 09:19:30 AM
-- Design Name: 
-- Module Name: cnt_bin - Behavioral
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

entity cnt_bin is
    Port ( CLK : in STD_LOGIC;
           SRST : in STD_LOGIC;
           CE : in STD_LOGIC;
           CNT_LOAD : in STD_LOGIC;
           CNT_UP : in STD_LOGIC;
           CNT : out STD_LOGIC_VECTOR (31 downto 0)
           );         
end cnt_bin;

architecture Behavioral of cnt_bin is
    SIGNAL cnt_sig      : unsigned (31 downto 0) := (others => '0');
    SIGNAL cnt_sig_next : unsigned (31 downto 0);

begin

    --- SEQUENTIAL PART
    PROCESS (CLK) BEGIN
        IF rising_edge(CLK) THEN
            IF SRST = '1' THEN
                --- synchronous reset
                cnt_sig <= (others => '0');
            ELSE
                IF CE = '1' THEN
                --- enable counter
                    cnt_sig <= cnt_sig_next;
                END IF;
            END IF;
        
        --- end rising cond    
        END IF;
    END PROCESS;
    
    --- COMBINATION PART
    PROCESS (cnt_sig, CNT_LOAD, CNT_UP) BEGIN
        cnt_sig_next <= cnt_sig; --- default assignments
        
        IF CNT_LOAD = '1' THEN
        --- static load value
            cnt_sig_next <= X"55555555";
        ELSE
            IF CNT_UP = '1' THEN
            --- do count up 
                cnt_sig_next <= cnt_sig + 1; 
            ELSE 
            --- do count down              
                cnt_sig_next <= cnt_sig - 1;    
            END IF;
        END IF;       
    END PROCESS;
    
    CNT <= std_logic_vector(cnt_sig);
 


end Behavioral;
