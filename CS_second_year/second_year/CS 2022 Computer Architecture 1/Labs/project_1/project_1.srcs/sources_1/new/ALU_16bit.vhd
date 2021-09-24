----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 05:54:59 PM
-- Design Name: 
-- Module Name: ALU_16bit - Behavioral
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

entity ALU_16bit is
    port (  A, B : in std_logic_Vector ( 15 downto 0);
            S0, S1, S2, C0 : in std_logic;
            G : out std_logic_vector( 15 downto 0);
            Cout, V : out std_logic);
end ALU_16bit;

architecture Behavioral of ALU_16bit is

    component arithmetic_circuit_16bit
         port (  A, B : in std_logic_vector ( 15 downto 0);
               S0, S1, Cin: in std_logic;
               G : out std_logic_vector ( 15 downto 0);
               Cout, V : out std_logic);
    end component;
    
    component logic_circuit_16bit
        port (  A, B : In std_logic_vector ( 15 downto 0);
                S0, S1 : in std_logic;
                G : out std_logic_vector (15 downto 0));
    end component;
    
    component mux2_1_16bit
         port ( s : in std_logic;
              In0 : in std_logic_vector(15 downto 0);
              In1 : in std_logic_vector(15 downto 0);
              Z : out std_logic_vector(15 downto 0));
    end component;
    
    signal AC_out, LC_out, G_ALU : std_logic_vector ( 15 downto 0);
    signal Carry_out, Overflow : std_logic;
    
    
begin

    AC : arithmetic_circuit_16bit PORT MAP ( A => A, B => B, S0 => S0, S1=> S1, Cin=> C0, G => AC_out, Cout => Carry_out, V => Overflow);
    LC : logic_circuit_16bit PORT MAP ( A => A, B => B, S0 => S0, S1 => S1, G => LC_out);
    mux : mux2_1_16bit PORT MAP ( s => S2, In0 => AC_out, In1 => LC_out, Z => G_ALU);
    
    G <= G_ALU;
    Cout <= Carry_out;
    V <= Overflow;
    
end Behavioral;
