
----------------------------------------------------------------------------------
-- Company:          ITESM - IRS 2024
-- Authors:          Tomás Pérez Vera, Ulises Carrizalez Lerín
-- Create Date:      21/04/2024
-- Design Name:      ShiftRow_tb
-- Module Name:      ShiftRow Testbench
-- Target Devices:   DE10-Lite
-- Description:      ShiftRow Component for the AES Encryptor
--
-- Version 2.0 - File Creation
----------------------------------------------------------------------------------

-- Commonly used libraries
library ieee; 
use ieee.std_logic_1164.all;
-- Packages use for arithmetic operations
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Testbench entity does not include any Port definition
entity ShiftRow_tb is
end entity ShiftRow_tb;

architecture testbench of ShiftRow_tb is
     -- Component to be simulated declaration
     -- Use exactly the same names used in the entity section
    component ShiftRow
        Port (
            clk    : in  std_logic;
            rst    : in  std_logic;
            enable : in  std_logic;
            finish : out std_logic;
            DataIn : in  std_logic_vector(127 downto 0);
            DataOut: out std_logic_vector(127 downto 0)
        );
    end component;

    -- Declare the input, output and clock signals used to instantiate the DUT
     -- Input Signals for test bench
    signal clk_tb     : std_logic := '0';
    signal rst_tb     : std_logic := '0';
    signal enable_tb  : std_logic := '0';
    signal DataIn_tb  : std_logic_vector(127 downto 0) := (others => '0');
   
    -- Output Signals for test bench
    signal finish_tb  : std_logic;
    signal DataOut_tb : std_logic_vector(127 downto 0);
     
     -- Clock period definitions
    constant clk_period : time := 100 ns;

begin
    -- Instantiate the ShiftRows component
    uut : ShiftRow
        port map (
            clk     => clk_tb,
            rst     => rst_tb,
            enable  => enable_tb,
            finish  => finish_tb,
            DataIn  => DataIn_tb,
            DataOut => DataOut_tb
        );

   -- Clock process to define its waveform, no sensitivity list
   clk_process: process
   begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
   end process;

    -- Stimulus process (test cases)
    process
    begin
       -- hold reset state for 100 ns.
        rst_tb    <= '1';
      wait for clk_period;
		
      -- Input data, case 1
		-- BEGIN: Case 1
        DataIn_tb <= x"D4E0B81E27BFB44111985D52AEF1E530";
        rst_tb    <= '0';
        enable_tb <= '1'; -- Signal from Master FSM to start transfomation
      wait for 200 ns;
          
        -- Master FSM sends an acknowledge signal to send finish signal back to '0'
        enable_tb <= '0';
        wait for 100 ns;

      wait; -- Continue until end of simulation time
		--End: Case 1
		
--		-- Input data, case 2
--		-- BEGIN: Case 2
--        DataIn_tb <= x"0123456789ABCDEF0123456789ABCDEF";
--        rst_tb    <= '0';
--        enable_tb <= '1'; -- Signal from Master FSM to start transfomation
--      wait for 200 ns;
--          
--        -- Master FSM sends an acknowledge signal to send finish signal back to '0'
--        enable_tb <= '0';
--        wait for 100 ns;
--
--      wait; -- Continue until end of simulation time
--		--End: Case 2
		
		-- Input data, case 3
--		-- BEGIN: Case 3
--        DataIn_tb <= x"FEDCBA9876543210FEDCBA9876543210";
--        rst_tb    <= '0';
--        enable_tb <= '1'; -- Signal from Master FSM to start transfomation
--      wait for 200 ns;
--          
--        -- Master FSM sends an acknowledge signal to send finish signal back to '0'
--        enable_tb <= '0';
--        wait for 100 ns;
--
--      wait; -- Continue until end of simulation time
--		--End: Case 3
		
		-- Input data, case 4
--		-- BEGIN: Case 4
--        DataIn_tb <= x"ABCDEF0123456789ABCDEF0123456789";
--        rst_tb    <= '0';
--        enable_tb <= '1'; -- Signal from Master FSM to start transfomation
--      wait for 200 ns;
--          
--        -- Master FSM sends an acknowledge signal to send finish signal back to '0'
--        enable_tb <= '0';
--        wait for 100 ns;
--
--      wait; -- Continue until end of simulation time
--		--End: Case 4
		
		-- Input data, case 5
--		-- BEGIN: Case 4
--        DataIn_tb <= x"0246813579ACEBDF0246813579ACEBDF";
--        rst_tb    <= '0';
--        enable_tb <= '1'; -- Signal from Master FSM to start transfomation
--      wait for 200 ns;
--          
--        -- Master FSM sends an acknowledge signal to send finish signal back to '0'
--        enable_tb <= '0';
--        wait for 100 ns;
--
--      wait; -- Continue until end of simulation time
--		--End: Case 5

    end process;

end architecture testbench;
