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

entity mux8_3_16bit is
    port ( src : in std_logic_vector(2 downto 0);
           In0 : in std_logic_vector(15 downto 0);
           In1 : in std_logic_vector(15 downto 0);
           In2 : in std_logic_vector(15 downto 0);
           In3 : in std_logic_vector(15 downto 0);
           In4 : in std_logic_vector(15 downto 0);
           In5 : in std_logic_vector(15 downto 0);
           In6 : in std_logic_vector(15 downto 0);
           In7 : in std_logic_vector(15 downto 0);
           Z0 : out std_logic_vector(15 downto 0));
end mux8_3_16bit;

architecture Behavioral of mux8_3_16bit is

begin
    with src select Z0 <=
        In0 after 1 ns when "000",
        In1 after 1 ns when "001",
        In2 after 1 ns when "010",
        In3 after 1 ns when "011",
        In4 after 1 ns when "100",
        In5 after 1 ns when "101",
        In6 after 1 ns when "110",
        In7 after 1 ns when "111",
        "XXXXXXXXXXXXXXXX" after 1 ns when others;
end Behavioral;
