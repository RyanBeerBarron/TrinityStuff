----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 05:10:06 PM
-- Design Name: 
-- Module Name: logic_circuit_16bit - Behavioral
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

entity logic_circuit_16bit is
    port (  A, B : In std_logic_vector ( 15 downto 0);
            S0, S1 : in std_logic;
            G : out std_logic_vector (15 downto 0));
end logic_circuit_16bit;

architecture Behavioral of logic_circuit_16bit is

    component mux4_1_16bit
        port (  src : in std_logic_vector(1 downto 0);
                In1, In2, In3, In4 : in std_logic_vector ( 15 downto 0);
                Out1 : out std_logic_vector ( 15 downto 0));
    end component;
    
    signal In1, In2, In3, In4, Out1 : std_logic_vector (15 downto 0);
    signal src : std_logic_vector(1 downto 0);
begin
    src(0) <= S0;
    src(1) <= S1;
    
    In1 <= A and B;
    In2 <= A or B;
    In3 <= A xor B;
    In4 <= not A;
    mux : mux4_1_16bit PORT MAP ( src => src, In1 =>In1, In2 => In2, In3 => In3, In4 => In4, Out1 => Out1);
    
    G <= Out1;
    
end Behavioral;
