----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2018 05:14:20 PM
-- Design Name: 
-- Module Name: mux2_1 - Behavioral
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

entity mux2_1_16bit is
    port ( s : in std_logic;
           In0 : in std_logic_vector(15 downto 0);
           In1 : in std_logic_vector(15 downto 0);
           Z : out std_logic_vector(15 downto 0));
end mux2_1_16bit;

architecture Behavioral of mux2_1_16bit is

begin
    with s select Z <=
         In0 when '0',
         In1 when '1',
         "XXXXXXXXXXXXXXXX" when others;
end Behavioral;
