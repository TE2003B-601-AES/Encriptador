----------------------------------------------------------------------------------
-- Company:				ITESM - IRS 2024
-- 
-- Create Date: 		16/04/2024
-- Design Name: 		Mix Column
-- Module Name:		Mix Column Module
-- Target Devices: 	DE10-Lite
-- Description: 		Mix Column Module
--
-- Version 0.0 - File Creation
-- Additional Comments: 
--
----------------------------------------------------------------------------------

-- Commonly used libraries
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Entity declaration
entity MixColumn is
    Port (
        -- Input ports
        input_port_1 : in std_logic;
        input_port_2 : in std_logic;
        -- Output ports
        output_port_1 : out std_logic;
        output_port_2 : out std_logic
    );
end MixColumn;

-- Architecture definition
architecture Behavioral of MixColumn is

    -- Internal signals
    signal internal_signal : std_logic;

begin
    -- Concurrent statements
    output_port_1 <= input_port_1 and input_port_2;
    output_port_2 <= input_port_1 or input_port_2;

    -- Sequential process
    process (input_port_1, input_port_2)
    begin
        if input_port_1 = '1' then
            internal_signal <= '1';
        else
            internal_signal <= '0';
        end if;
    end process;

end Behavioral;