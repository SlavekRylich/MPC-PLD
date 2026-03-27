----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2026 10:39:52 AM
-- Design Name: 
-- Module Name: uart_tx_tb - Behavioral
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

entity uart_tx_tb is
--  Port ( );
end uart_tx_tb;

architecture Behavioral of uart_tx_tb is

  COMPONENT ce_gen
  GENERIC (
    G_DIV_FACT          : POSITIVE := 100
  );
  PORT (
    CLK                 : IN  STD_LOGIC;
    SRST                : IN  STD_LOGIC;
    CE                  : IN  STD_LOGIC;
    CE_O                : OUT STD_LOGIC 
  );
  END COMPONENT ce_gen;
  
  COMPONENT uart_tx is
    Port ( CLK          : in STD_LOGIC;
           CLK_EN       : in STD_LOGIC;  --- 115,2 kHz ~ 115 200 Bd
           TX_START     : in STD_LOGIC;
           DATA_IN      : in STD_LOGIC_VECTOR (7 downto 0);
           UART_TXD     : out STD_LOGIC;
           TX_BUSY      : out STD_LOGIC);
  END COMPONENT uart_tx;
  
  CONSTANT C_CLK_PERIOD         : TIME := 20 ns;
  SIGNAL simulation_finished    : BOOLEAN := FALSE;
  
  SIGNAL clk                    : STD_LOGIC := '0';
  SIGNAL ce_100Hz               : STD_LOGIC;
  SIGNAL cnt_enable             : STD_LOGIC := '0';
  
  signal tx_start_sig           : STD_LOGIC := '0';
  signal UART_TXD_sig           : STD_LOGIC;
  signal TX_BUSY_sig            : STD_LOGIC;
  
  signal DATA_IN_sig            : std_logic_vector(7 downto 0);
  
  
begin

 proc_clk_gen: PROCESS BEGIN
    clk <= '0'; WAIT FOR C_CLK_PERIOD/2;
    clk <= '1'; WAIT FOR C_CLK_PERIOD/2;
    IF simulation_finished THEN
      WAIT;
    END IF;
  END PROCESS proc_clk_gen;

 ce_gen_i : ce_gen
  GENERIC MAP(
    G_DIV_FACT                  => 10
  )
  PORT MAP(
    CLK                         => clk,
    SRST                        => '0',
    CE                          => '1',
    CE_O                        => ce_100hz
  );
  
  uart_tx_i : uart_tx 
    PORT MAP ( CLK          => clk,
           CLK_EN           => ce_100Hz, --- 115,2 kHz ~ 115 200 Bd
           TX_START         => tx_start_sig,
           DATA_IN          => DATA_IN_sig,
           UART_TXD         => UART_TXD_sig,
           TX_BUSY          => TX_BUSY_sig
  );

 proc_stim : PROCESS
  BEGIN
    DATA_IN_sig  <= X"0A";
    tx_start_sig <= '0';
    ------------------------------------------------------------------------------
    -- reset of the counter
    ------------------------------------------------------------------------------
    WAIT FOR C_CLK_PERIOD * 2;
    tx_start_sig   <= '1';
    WAIT FOR C_CLK_PERIOD * 2;
    tx_start_sig   <= '0';
    ------------------------------------------------------------------------------
    -- place your own stimuli below
    ------------------------------------------------------------------------------
--    WAIT FOR C_CLK_PERIOD * 2;
--    cnt_reset   <= '0';
--    WAIT FOR C_CLK_PERIOD * 2;
--    cnt_enable   <= '1';
--    WAIT FOR C_CLK_PERIOD * 2;
--    disp_enable   <= '1';


--    WAIT FOR C_CLK_PERIOD * 100;
--    disp_enable   <= '0';    
--    WAIT FOR C_CLK_PERIOD * 10;
--    disp_enable   <= '1';    
--    WAIT FOR C_CLK_PERIOD * 10;

--    cnt_reset   <= '1';
--    WAIT FOR C_CLK_PERIOD * 2;
--    cnt_reset   <= '0';


    ------------------------------------------------------------------------------
    -- end of simulation
    ------------------------------------------------------------------------------
    WAIT FOR C_CLK_PERIOD * 10000000;
    simulation_finished <= TRUE;
    WAIT;
  END PROCESS proc_stim;  



end Behavioral;
