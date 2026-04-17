----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE std.textio.ALL;
----------------------------------------------------------------------------------
entity FIR_50k_TB is
end FIR_50k_TB;
----------------------------------------------------------------------------------
architecture tb of FIR_50k_TB is
----------------------------------------------------------------------------------

  COMPONENT FIR_50k_wrapper IS
  GENERIC (
    SIM_MODEL                           : BOOLEAN := TRUE
  );
  PORT (
    aclk                                : IN  STD_LOGIC;
    s_axis_data_tvalid                  : IN  STD_LOGIC;
    s_axis_data_tready                  : OUT STD_LOGIC;
    s_axis_data_tdata                   : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid                  : OUT STD_LOGIC;
    m_axis_data_tdata                   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
  END COMPONENT FIR_50k_wrapper;

  -----------------------------------------------------------------------

  SIGNAL sig_SIM_finished               : BOOLEAN := FALSE;     -- assert when all test vectors has been applied

  CONSTANT C_aclk_period                : time := 20 ns;
  SIGNAL aclk                           : STD_LOGIC := '0';

  SIGNAL s_axis_data_tvalid             : STD_LOGIC := '0';
  SIGNAL s_axis_data_tready             : STD_LOGIC;
  SIGNAL s_axis_data_tdata              : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
  SIGNAL m_axis_data_tvalid             : STD_LOGIC;
  SIGNAL m_axis_data_tdata              : STD_LOGIC_VECTOR(15 DOWNTO 0);

----------------------------------------------------------------------------------
begin
----------------------------------------------------------------------------------


  --------------------------------------------------------------------------------
  -- Clock process definitions
  --------------------------------------------------------------------------------

  P_aclk: PROCESS
  BEGIN
    aclk <= '0'; WAIT FOR C_aclk_period/2;
    aclk <= '1'; WAIT FOR C_aclk_period/2;
    IF sig_SIM_finished THEN WAIT; END IF;
  END PROCESS P_aclk;


  -----------------------------------------------------------------------
  -- Instantiate the DUT
  -----------------------------------------------------------------------

  FIR_50k_wrapper_i : FIR_50k_wrapper
  GENERIC MAP(
    SIM_MODEL           => FALSE
  )
  PORT MAP(
    aclk                => aclk,
    s_axis_data_tvalid  => s_axis_data_tvalid,
    s_axis_data_tready  => s_axis_data_tready,
    s_axis_data_tdata   => s_axis_data_tdata,
    m_axis_data_tvalid  => m_axis_data_tvalid,
    m_axis_data_tdata   => m_axis_data_tdata
  );

  -----------------------------------------------------------------------
  -- FIR input
  --    read FIR_data_in.txt
  --    feed the FIR filter with the data from file
  -----------------------------------------------------------------------
  read_txt: PROCESS
    FILE        File_ID     : TEXT;
    VARIABLE    line_in     : LINE;
    VARIABLE    v_number    : INTEGER;
  BEGIN
    FILE_OPEN(File_ID, "..\..\..\..\SOURCES\FIR_data\FIR_data_in.txt", READ_MODE);
    WHILE NOT ENDFILE(File_ID) LOOP
        WAIT UNTIL falling_edge(aclk);      -- synchronization
        if s_axis_data_tready = '0' then
            WAIT UNTIL s_axis_data_tready = '1';
        else
            READLINE(File_ID, line_in);
            READ(line_in, v_number);
            s_axis_data_tdata <= STD_LOGIC_VECTOR(TO_SIGNED(v_number, 16));
            s_axis_data_tvalid <= '1'; WAIT FOR C_aclk_period * 1;
            s_axis_data_tvalid <= '0'; WAIT FOR C_aclk_period * 3;
            
        end if;
    END LOOP;
    FILE_CLOSE(File_ID);
    WAIT FOR C_aclk_period * 30;
    sig_SIM_finished <= TRUE;
    WAIT;
 END PROCESS read_txt;

  -----------------------------------------------------------------------
  -- FIR output data check
  --    read reference data from FIR_data_out.txt
  --    compare the reference and actual data
  --    report any discrepancy (both a text LOG file and simulator console)
  --    report overall test result
  -----------------------------------------------------------------------
  write_txt: PROCESS
    FILE        File_ID         : TEXT;
    VARIABLE    line_in         : LINE;
    VARIABLE    v_number        : INTEGER;
    
    FILE        LOG_File_ID     : TEXT;
    VARIABLE    err_count       : INTEGER := 0;
    VARIABLE    text_line       : LINE;
    
    VARIABLE    OUT_actual      : STD_LOGIC_VECTOR(15 DOWNTO 0)   := (others => '0');
    VARIABLE    OUT_expected    : STD_LOGIC_VECTOR(15 DOWNTO 0)   := (others => '0');

  BEGIN
    FILE_OPEN(File_ID, "..\..\..\..\SOURCES\FIR_data\FIR_data_out.txt", READ_MODE);
    FILE_OPEN(LOG_File_ID, "..\..\..\..\SOURCES\FIR_data\FIR_sim_log.txt", WRITE_MODE);
    WHILE NOT sig_SIM_finished LOOP
        WAIT UNTIL falling_edge(aclk);      -- synchronization
        
        if m_axis_data_tvalid = '0' then
        
            WAIT UNTIL m_axis_data_tvalid = '1' or sig_SIM_finished;
        else
        --if m_axis_data_tvalid = '1' then 
            READLINE(File_ID, line_in);
            READ(line_in, v_number);
            
            OUT_actual      := m_axis_data_tdata;
            OUT_expected    := STD_LOGIC_VECTOR(TO_SIGNED(v_number, 16));
             
            if (OUT_expected /= OUT_actual) then
                err_count := err_count + 1;
                WRITE(text_line, STRING'("Output error at " & TIME'image(NOW)));
                WRITE(text_line, STRING'(". Expected data: "));
                WRITE(text_line, TO_INTEGER(SIGNED(OUT_expected)));
                WRITE(text_line, STRING'(". Actual data: "));
                WRITE(text_line, TO_INTEGER(SIGNED(OUT_actual)));
                
                
                REPORT text_line.ALL SEVERITY NOTE;
                WRITELINE(LOG_File_ID, text_line);
            end if;
        end if;
    END LOOP;
    FILE_CLOSE(File_ID);
    FILE_CLOSE(LOG_File_ID);
    
    ------------------------------------------------------------------------------
    -- final report
    IF err_count = 0 THEN
      REPORT LF &
             "================================================================" & LF &
             "Simulation PASSED (no erros)!" & LF &
             "================================================================" & LF
             SEVERITY NOTE;
    ELSE
      REPORT LF &
             "================================================================" & LF &
             "Simulation FAILED, " & INTEGER'IMAGE(err_count) & " errors detected." & LF &
             "================================================================" & LF
      		 SEVERITY ERROR;
    END IF;
    WAIT;
 END PROCESS write_txt;



----------------------------------------------------------------------------------
end tb;
----------------------------------------------------------------------------------
