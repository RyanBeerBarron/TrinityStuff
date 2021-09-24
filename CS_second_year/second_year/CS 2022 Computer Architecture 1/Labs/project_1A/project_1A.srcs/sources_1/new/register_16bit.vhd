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
            load, Clk : in std_logic;
            Q : out std_logic_vector(15 downto 0));
end register_16bit;

architecture Behavioral of register_16bit is
begin
process(Clk)
    begin
        if(rising_edge(Clk))then
            if load = '1' then
                Q <= D;
            end if;
        end if;
    end process;
end Behavioral;
