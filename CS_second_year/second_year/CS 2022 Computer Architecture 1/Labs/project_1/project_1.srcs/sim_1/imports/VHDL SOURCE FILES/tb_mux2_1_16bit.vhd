----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2018 02:54:09 PM
-- Design Name: 
-- Module Name: tub_mux2_1 - Behavioral
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

entity tb_mux2_1_16bit is
--  Port ( );
end tb_mux2_1_16bit;

architecture Behavioral of tb_mux2_1_16bit is
    constant CLOCK_PERIOD : time := 100 ns;

    Component mux2_1_16bit
        port ( s : in std_logic;
               In0 : in std_logic_vector(15 downto 0);
               In1 : in std_logic_vector(15 downto 0);
               Z : out std_logic_vector(15 downto 0));
    end Component;
    
    signal s : std_logic;
    signal in0, in1, z : std_logic_vector(15 downto 0);               


begin


    dut : mux2_1_16bit PORT MAP(s => s, in0 => in0, in1 => in1, z => z);
    
    simulation : process
    
        procedure test(constant select2 : in std_logic;
                        constant choice1, choice2 : in std_logic_vector(15 downto 0)) is
        begin 
            s <= select2;
            in0 <= choice1;
            in1 <= choice2;
            wait for CLOCK_PERIOD;
        end procedure test;                      
        
    begin
    
    test('0', x"aaaa", x"bbbb");    
    test('0', x"cccc", x"dddd");
    test('0', x"bbbb", x"cccc");
    test('1', x"aaaa", x"bbbb");    
    test('1', x"cccc", x"dddd");
    test('1', x"bbbb", x"cccc");
    
    end process simulation;
    
end Behavioral;
