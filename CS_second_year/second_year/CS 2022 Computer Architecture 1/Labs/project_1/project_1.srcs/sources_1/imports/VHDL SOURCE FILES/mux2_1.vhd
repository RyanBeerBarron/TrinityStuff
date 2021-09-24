----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 05:43:46 PM
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

entity mux2_1 is
    port (  B, S0, S1 : in std_logic;
            Bout : out std_logic);
end mux2_1;

architecture Behavioral of mux2_1 is

begin
    with B select Bout  <=
        S1 after 1 ns when '0', 
        S0 after 1 ns when '1',
        'X' after 1 ns when others;

end Behavioral;
