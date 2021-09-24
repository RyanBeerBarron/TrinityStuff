----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 07:22:14 PM
-- Design Name: 
-- Module Name: mux3_1 - Behavioral
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

entity mux3_1 is
    port (  In1, In2, In3 : in std_logic;
            S : in std_logic_vector (1 downto 0);
            H : out std_logic); 
end mux3_1;

architecture Behavioral of mux3_1 is


begin
    with S select H <=
        In1 after 1 ns when "00",
        In2 after 1 ns when "01",
        In3 after 1 ns when "10",
        'X' after 1 ns when others;

end Behavioral;
