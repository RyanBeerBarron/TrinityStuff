----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2018 05:46:07 PM
-- Design Name: 
-- Module Name: mux4_2 - Behavioral
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

entity mux4_2 is
    port ( src : in std_logic_vector(1 downto 0);
           In0 : in std_logic_vector(3 downto 0);
           In1 : in std_logic_vector(3 downto 0);
           In2 : in std_logic_vector(3 downto 0);
           In3 : in std_logic_vector(3 downto 0);
           Z0 : out std_logic_vector(3 downto 0));
end mux4_2;

architecture Behavioral of mux4_2 is

begin
    with src select Z0 <=
        In0 when "00",
        In1 when "01",
        In2 when "10",
        In3 when "11",
        "XXXX" when others;

end Behavioral;
