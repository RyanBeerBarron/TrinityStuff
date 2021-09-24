----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 06:07:28 PM
-- Design Name: 
-- Module Name: tb_ALU_16bit - Behavioral
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

entity tb_ALU_16bit is
--  Port ( );
end tb_ALU_16bit;

architecture Behavioral of tb_ALU_16bit is

    component ALU_16bit
        port (  A, B : in std_logic_Vector ( 15 downto 0);
                S0, S1, S2, C0 : in std_logic;
                G : out std_logic_vector( 15 downto 0);
                Cout, V : out std_logic);
    end component;
    
    CONSTANT CLOCK_PERIOD : time := 150ns;
    
    signal A, B, G : std_logic_vector ( 15 downto 0 );
    signal S0, S1, S2, C0, Cout, V : std_logic;
    
begin

    dut : ALU_16bit PORT MAP ( A=>A, B=>B, G=>G, S0=>S0, S1=>S1, S2=>S2, C0=>C0, Cout=>Cout, V=>V);
    
    simulation : process
    
        procedure test(constant Vector0, Vector1 : std_logic_vector (15 downto 0);
                       constant Selector0, Selector1, Selector2, Carry0: std_logic) is
            begin
                A <= Vector0;
                B <= Vector1;
                S0 <= Selector0;
                S1 <= Selector1;
                S2 <= Selector2;                    
                C0 <= Carry0;
                wait for CLOCK_PERIOD;            
            end procedure test;
            
    begin
    
    L1 : for index0 in std_logic range '0' to '1' loop
        L2 : for index1 in std_logic range '0' to '1' loop
            L3 : for index2 in std_logic range '0' to '1' loop
                L4 : for index3 in std_logic range '0' to '1' loop
                    test(x"2222", x"7777", index2, index1, index0, index3);
                end loop L4;
            end loop L3;
        end loop L2;
    end loop L1;                 
    
    end process simulation;
            
end Behavioral;
