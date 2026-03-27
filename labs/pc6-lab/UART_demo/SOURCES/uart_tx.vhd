----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2026 08:56:24 AM
-- Design Name: 
-- Module Name: uart_tx - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_tx is
    Port ( CLK          : in STD_LOGIC;
           CLK_EN       : in STD_LOGIC;  --- 115,2 kHz ~ 115 200 Bd
           TX_START     : in STD_LOGIC;
           DATA_IN      : in STD_LOGIC_VECTOR (7 downto 0);
           UART_TXD     : out STD_LOGIC;
           TX_BUSY      : out STD_LOGIC);
end uart_tx;

architecture Behavioral of uart_tx is
--- enum
TYPE t_state is (st_idle, st_store, st_wait,
 st_startb, st_bit_0, st_bit_1, st_bit_2, st_bit_3, 
 st_bit_4, st_bit_5, st_bit_6, st_bit_7, st_stopb);

--- signals
signal sig_tx_busy  : STD_LOGIC := '0';
signal pres_state   : t_state := st_idle;
signal next_state   : t_state;
signal output_c     : STD_LOGIC := '1';
signal outputs      : STD_LOGIC := '1';
signal load         : STD_LOGIC := '0';

--- shift register
SIGNAL shreg        : std_logic_vector (9 downto 0) := (others => '1');

begin
--- processes

--- REG 1
process (CLK) begin
    if rising_edge(CLK) then
        pres_state <= next_state;
    end if;
end process;

--- next state logic
process (pres_state, TX_START, CLK_EN) begin
    next_state <= pres_state;    
    
    case pres_state is
        when st_idle =>     if TX_START = '1' then
                                next_state <= st_store; 
                            end if;
                            
        when st_store =>    next_state <= st_wait; 
                            
        when st_wait =>     if CLK_EN = '1' then
                                next_state <= st_startb; 
                            end if;
                            
        when st_startb  =>  if CLK_EN = '1' then
                                next_state <= st_bit_1;
                            end if;
        when st_bit_1   =>  if CLK_EN = '1' then
                                next_state <= st_bit_2;
                            end if;
        when st_bit_2   =>  if CLK_EN = '1' then
                                next_state <= st_bit_3;
                            end if;
        when st_bit_3   =>  if CLK_EN = '1' then
                                next_state <= st_bit_4;
                            end if;
        when st_bit_4   =>  if CLK_EN = '1' then
                                next_state <= st_bit_5;
                            end if;
        when st_bit_5   =>  if CLK_EN = '1' then
                                next_state <= st_bit_6;
                            end if;
        when st_bit_6   =>  if CLK_EN = '1' then
                                next_state <= st_bit_7;
                            end if;
        when st_bit_7   =>  if CLK_EN = '1' then
                                next_state <= st_stopb;
                            end if;
        when st_stopb   =>  if CLK_EN = '1' then
                                next_state <= st_idle;
                            end if;
        when others     =>   next_state <= st_idle;         
   end case;
end process;

--- out logic
PROCESS (pres_state) BEGIN
    sig_tx_busy <= '1';
    load <= '0';
    
    case pres_state is 
        when st_idle =>     sig_tx_busy <= '0';
        when st_store =>    load <= '1';                            
--        when st_wait =>     load <= '0';                                         
--        when st_startb =>   load <= '0';
--        when st_bit_1 =>    load <= '0';
--        when st_bit_2 =>    load <= '0';
--        when st_bit_3 =>    load <= '0';
--        when st_bit_4 =>    load <= '0';
--        when st_bit_5 =>    load <= '0';
--        when st_bit_6 =>    load <= '0';
--        when st_bit_7 =>    load <= '0';
--        when st_stopb =>    load <= '0';           
        when others   =>   null;
        
    end case;
end process;


--- REG 2
process (CLK) begin
    if rising_edge(CLK) then
        if load = '1' then
            shreg <= DATA_IN & "01";
        end if;
         
        if CLK_EN = '1' then
            shreg <= '1' & shreg(shreg'high downto 1);
        end if;
    end if;
end process;

UART_TXD    <= shreg(0);    --- může se přiřazovat z registru
TX_BUSY     <= sig_tx_busy;

end Behavioral;
