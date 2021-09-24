----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2018 02:53:01 PM
-- Design Name: 
-- Module Name: tb_mux8_3 - Behavioral
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

entity tb_mux8_3 is
--  Port ( );
end tb_mux8_3;

architecture Behavioral of tb_mux8_3 is
     constant CLOCK_PERIOD : time := 100 ns;
     
     Component mux8_3_16bit
         port ( src : in std_logic_vector(2 downto 0);
               In0 : in std_logic_vector(15 downto 0);
               In1 : in std_logic_vector(15 downto 0);
               In2 : in std_logic_vector(15 downto 0);
               In3 : in std_logic_vector(15 downto 0);
               In4 : in std_logic_vector(15 downto 0);
               In5 : in std_logic_vector(15 downto 0);
               In6 : in std_logic_vector(15 downto 0);
               In7 : in std_logic_vector(15 downto 0);
               Z0 : out std_logic_vector(15 downto 0));
               
    end component;
    
    signal src : std_logic_vector(2 downto 0);
    signal In0, In1, In2, In3, In4, In5, In6, In7, Z0 : std_logic_vector(15 downto 0);
    
begin

    dut : mux8_3_16bit PORT MAP(src => src, in0 =>in0, in1=>in1, in2=>in2, in3=>in3, in4=>in4, in5=>in5, in6=>in6, in7=>in7, z0=>z0);
    
    simulation : process
    
        procedure test (constant select8 : in std_logic_vector(2 downto 0);
                        constant choice1, choice2, choice3, choice4, choice5, choice6, choice7, choice8  : in std_logic_vector(15 downto 0)) is
        begin
            src <= select8;
            in0 <= choice1;
            in1 <= choice2;
            in2 <= choice3;
            in3 <= choice4;
            in4 <= choice5;
            in5 <= choice6;
            in6 <= choice7;
            in7 <= choice8;
            wait for CLOCK_PERIOD;
        end procedure test;    
    begin
    
    test("000", x"1111", x"2222", x"3333", x"4444", x"5555", x"6666", x"7777", x"8888");                        
    test("001", x"1111", x"2222", x"3333", x"4444", x"5555", x"6666", x"7777", x"8888");
    test("010", x"1111", x"2222", x"3333", x"4444", x"5555", x"6666", x"7777", x"8888");
    test("011", x"1111", x"2222", x"3333", x"4444", x"5555", x"6666", x"7777", x"8888");
    test("100", x"1111", x"2222", x"3333", x"4444", x"5555", x"6666", x"7777", x"8888");
    test("101", x"1111", x"2222", x"3333", x"4444", x"5555", x"6666", x"7777", x"8888");
    test("110", x"1111", x"2222", x"3333", x"4444", x"5555", x"6666", x"7777", x"8888");
    test("111", x"1111", x"2222", x"3333", x"4444", x"5555", x"6666", x"7777", x"8888");

    end process simulation;
    
end Behavioral;
