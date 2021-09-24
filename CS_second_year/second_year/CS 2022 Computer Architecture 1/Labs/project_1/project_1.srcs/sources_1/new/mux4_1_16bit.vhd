----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 05:05:51 PM
-- Design Name: 
-- Module Name: mux4_1_16bit - Behavioral
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

entity mux4_1_16bit is
    port (  src : in std_logic_vector(1 downto 0);
            In1, In2, In3, In4 : in std_logic_vector ( 15 downto 0);
            Out1 : out std_logic_vector ( 15 downto 0));
end mux4_1_16bit;

architecture Behavioral of mux4_1_16bit is

begin
    with src select Out1 <=
        In1 after 1 ns when "00",
        In2 after 1 ns when "01",
        In3 after 1 ns when "10",
        In4 after 1 ns when "11",
        "XXXXXXXXXXXXXXXX" after 1 ns when others;

end Behavioral;
