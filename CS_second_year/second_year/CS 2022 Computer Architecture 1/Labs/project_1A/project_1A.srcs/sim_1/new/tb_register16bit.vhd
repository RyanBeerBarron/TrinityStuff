----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2018 08:11:11 PM
-- Design Name: 
-- Module Name: tb_register16bit - Behavioral
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

entity tb_register16bit is
--  Port ( );
end tb_register16bit;

architecture Behavioral of tb_register16bit is

    CONSTANT CLOCK_PERIOD : TIME := 100 ns;
    
    Component register_16bit
             port ( D : in std_logic_vector(15 downto 0);
                   load, Clk : in std_logic;
                   Q : out std_logic_vector(15 downto 0));
        end Component;
    
    signal D, Q : std_logic_vector(15 downto 0);
    signal load, clk : std_logic;
               
begin
    dut : register_16bit PORT MAP(D=>D,Q=>Q,load=>load,clk=>clk);
    
    clk_generation : process
    begin
        CLK <= '1';
        wait for CLOCK_PERIOD/2;
        CLK <= '0';
        wait for CLOCK_PERIOD/2;
    end process clk_generation;
    
    
    simulation : process
        procedure test(constant in1 : in std_logic_vector(15 downto 0);
                        constant l : in std_logic) is
        begin
            D <= in1;
            load <= l;
            wait for CLOCK_PERIOD;
        end procedure test;    
            
    begin
        load <= '0';
        D <= (others =>'0');
        wait for CLOCK_PERIOD;
        test("0000000000000000", '0');
        test("0000010100110010", '1');
        test("1111111111111111", '0');
        test("1111111111111111", '1');
        
     end process simulation;   
    
end Behavioral;
