----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2018 04:48:57 PM
-- Design Name: 
-- Module Name: decoder3_8 - Behavioral
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

entity decoder3_8 is
    port ( A : in std_logic_vector(2 downto 0);
           Q0 : out std_logic;
           Q1 : out std_logic;
           Q2 : out std_logic;
           Q3 : out std_logic;
           Q4 : out std_logic;
           Q5 : out std_logic;
           Q6 : out std_logic;
           Q7 : out std_logic);
           
end decoder3_8;

architecture Behavioral of decoder3_8 is

begin
    Q0 <= (not A(2)) and (not A(1)) and (not A(0));
    Q1 <= (not A(2)) and (not A(1)) and A(0);
    Q2 <= (not A(2)) and A(1) and (not A(0));
    Q3 <= (not A(2)) and A(1) and A(0);
    Q4 <= A(2) and (not A(1)) and (not A(0));
    Q5 <= A(2) and (not A(1)) and A(0);
    Q6 <= A(2) and A(1) and (not A(0));
    Q7 <= A(2) and A(1) and A(0);
end Behavioral;
