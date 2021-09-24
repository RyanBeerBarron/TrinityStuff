----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2018 03:48:38 PM
-- Design Name: 
-- Module Name: register_4bit - Behavioral
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

entity register_16bit is
    port ( D : in std_logic_vector(15 downto 0);
            load, write_enable : in std_logic;
            Q : out std_logic_vector(15 downto 0));
end register_16bit;

architecture Behavioral of register_16bit is

    signal load_enable : std_logic;

begin
    load_enable <= load and write_enable;
    process(load_enable)
    begin
        if (load_enable = '1') then
        Q <= D after 1 ns;
    end if;    
    end process;
end Behavioral;
