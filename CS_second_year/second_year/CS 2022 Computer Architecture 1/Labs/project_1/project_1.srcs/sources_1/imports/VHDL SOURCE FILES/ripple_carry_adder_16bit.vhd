----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 03:50:56 PM
-- Design Name: 
-- Module Name: ripple_carry_adder_16bit - Behavioral
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

entity ripple_carry_adder_16bit is
port (  x, y : in std_logic_vector (15 downto 0);
        C0 : in std_logic;
        Cout, V : out std_logic;
        S : out std_logic_vector (15 downto 0));        
end ripple_carry_adder_16bit;

architecture Behavioral of ripple_carry_adder_16bit is

component full_adder 
    port (  x : in std_logic;
        y : in std_logic;
        cin : in std_logic;
        cout : out std_logic;
        sum : out std_logic);
end component;        

signal C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16 : std_logic;
signal S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15 : std_logic;


begin

fa0 : full_adder PORT MAP ( x => x(0), y => y(0), Cin => C0, Cout => C1, sum => S0);
fa1 : full_adder PORT MAP ( x => x(1), y => y(1), Cin => C1, Cout => C2, sum => S1);
fa2 : full_adder PORT MAP ( x => x(2), y => y(2), Cin => C2, Cout => C3, sum => S2);
fa3 : full_adder PORT MAP ( x => x(3), y => y(3), Cin => C3, Cout => C4, sum => S3);
fa4 : full_adder PORT MAP ( x => x(4), y => y(4), Cin => C4, Cout => C5, sum => S4);
fa5 : full_adder PORT MAP ( x => x(5), y => y(5), Cin => C5, Cout => C6, sum => S5);
fa6 : full_adder PORT MAP ( x => x(6), y => y(6), Cin => C6, Cout => C7, sum => S6);
fa7 : full_adder PORT MAP ( x => x(7), y => y(7), Cin => C7, Cout => C8, sum => S7);
fa8 : full_adder PORT MAP ( x => x(8), y => y(8), Cin => C8, Cout => C9, sum => S8);
fa9 : full_adder PORT MAP ( x => x(9), y => y(9), Cin => C9, Cout => C10, sum => S9);
fa10 : full_adder PORT MAP ( x => x(10), y => y(10), Cin => C10, Cout => C11, sum => S10);
fa11 : full_adder PORT MAP ( x => x(11), y => y(11), Cin => C11, Cout => C12, sum => S11);
fa12 : full_adder PORT MAP ( x => x(12), y => y(12), Cin => C12, Cout => C13, sum => S12);
fa13 : full_adder PORT MAP ( x => x(13), y => y(13), Cin => C13, Cout => C14, sum => S13);
fa14 : full_adder PORT MAP ( x => x(14), y => y(14), Cin => C14, Cout => C15, sum => S14);
fa15 : full_adder PORT MAP ( x => x(15), y => y(15), Cin => C15, Cout => C16, sum => S15);

V <= C16 xor C15;
Cout <= C16;
S(0) <= S0;
S(1) <= S1;
S(2) <= S2;
S(3) <= S3;
S(4) <= S4;
S(5) <= S5;
S(6) <= S6;
S(7) <= S7;
S(8) <= S8;
S(9) <= S9;
S(10) <= S10;
S(11) <= S11;
S(12) <= S12;
S(13) <= S13;
S(14) <= S14;
S(15) <= S15;






end Behavioral;
