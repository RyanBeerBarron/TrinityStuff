----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 03:03:07 PM
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
port (  x : in std_logic;
        y : in std_logic;
        cin : in std_logic;
        cout : out std_logic;
        sum : out std_logic);
end full_adder;

architecture Behavioral of full_adder is

signal carryS, sumS : std_logic; 

begin

sumS <= x XOR y XOR cin after 1 ns;
carryS <= ( X AND Y ) OR ( X AND Cin ) OR ( Y AND Cin ) after 1 ns;

sum <= sumS;
Cout <= carryS;
end Behavioral;
