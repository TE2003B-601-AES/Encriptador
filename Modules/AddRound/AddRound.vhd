----------------------------------------------------------------------------------
-- Company:				ITESM - IRS 2024
-- 
-- Create Date: 		16/04/2024
-- Design Name: 		Add Round
-- Module Name:		Add Round Module
-- Target Devices: 	DE10-Lite
-- Description: 		Add Round Module
--
-- Version 0.0 - File Creation
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AddRound is
    Port (
        -- Input ports
        DataIn : in std_logic_vector(127 downto 0);
        DataKey : in std_logic_vector(127 downto 0);
		  clk : in std_logic;
		  start : in std_logic;
		  reset : in std_logic;
        -- Output ports
        DataOut: out std_logic_vector(127 downto 0);
		  finish : out std_logic);
end AddRound;

architecture Behavioral of AddRound is
    -- Internal signals
	 -- Temporary Variable used for the transformation
    shared variable InternalData : std_logic_vector(127 downto 0);
	 
	 -- FSM signals
  type state_values is (St0,St1,St2);
  signal next_state, present_state : state_values;

begin

	-- Section 1: Communications with the Master FSM
	-- State Register Process
	-- Holds the current state of the FSM
	statereg: process (clk, reset)
	begin
    -- Asynchronous Reset
    if reset = '1' then
       present_state <= St0;
     elsif rising_edge(clk) then
       present_state <= next_state;
     end if;
  end process statereg;
  
  -- Define the Next-State Logic Process
  -- Will obtain the next state based on the inputs and current state
  fsm: process (present_state, start)
  begin
    case present_state is
      when St0 => 
          if start = '0' then
            next_state <= St0;
          else
            next_state <= St1; 
          end if;
      when St1 =>
            next_state <= St2;
      when St2 =>
          if start = '0' then
            next_state <= St0;
          else
            next_state <= St2; 
          end if;
      when others =>
            next_state <= St0;
     end case;
  end process fsm;
  
  -- The output of a Moore Machine is determined by the present_state only
  output: process (present_state)
  begin
    case present_state is
       when St0 =>
          finish <= '0';
       when St1 =>
          finish <= '0';
       when St2 =>
          finish <= '1';
      when others =>
          finish <= '0';
    end case;
  end process output;
	
	
	-- Process for AddRoundKeys operation

	operation : process(clk, present_state)
	begin
		if (rising_edge(clk) and present_state = St1) then
	 
		-- XOR operation between DataIn and DataKey, store result in InternalData
		InternalData := DataIn xor DataKey;
		end if;
		-- Sent transformation to the output.
		DataOut <= InternalData;
	end process operation;

end architecture Behavioral;