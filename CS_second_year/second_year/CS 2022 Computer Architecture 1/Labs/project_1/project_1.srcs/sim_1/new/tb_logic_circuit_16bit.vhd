----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 05:29:19 PM
-- Design Name: 
-- Module Name: tb_logic_circuit_16bit - Behavioral
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

entity tb_logic_circuit_16bit is
--  Port ( );
end tb_logic_circuit_16bit;

architecture Behavioral of tb_logic_circuit_16bit is

    constant CLOCK_PERIOD : time := 150 ns;
    
    Component logic_circuit_16bit
        port (  A, B : In std_logic_vector ( 15 downto 0);
               S0, S1 : in std_logic;
               G : out std_logic_vector (15 downto 0));
    end component;
    
    signal A, B, G : std_logic_vector ( 15 downto 0);
    signal S0, S1 : std_logic;          
    
begin

    dut : logic_circuit_16bit PORT MAP ( A =>A, B=>B, G=>G, S0=>S0, S1=>S1);
    
    simulation : process
        procedure test (    constant Vector0, Vector1 : std_logic_vector( 15 downto 0);
                            constant In1, In2 : std_logic) is 
        begin
            A <= Vector0;
            B <= Vector1;
            S0 <= in1;
            S1 <= in2;
            wait for CLOCK_PERIOD;
        end procedure test;
        
                
    begin
        
        test( "0101010101010101", "0000000011111111", '0', '0');
        test( "0101010101010101", "0000000011111111", '1', '0');
        test( "1111111100000000", "0000000011111111", '0', '1');
        test( "0101010101010101", "----------------", '1', '1');
    
    end process simulation;
    
end Behavioral;
