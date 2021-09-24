----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 07:48:45 PM
-- Design Name: 
-- Module Name: tb_shifter_unit_16bit - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_shifter_unit_16bit is
--  Port ( );
end tb_shifter_unit_16bit;

architecture Behavioral of tb_shifter_unit_16bit is

    constant CLOCK_PERIOD : time := 150ns;
    
    component shifter_unit_16bit
        port (  B : in std_logic_vector(15 downto 0);
                S : in std_logic_vector(1 downto 0);
                Ir, Il : in std_logic;
                H : out std_logic_vector(15 downto 0));
    end component;
    
    signal B, H : std_logic_vector (15 downto 0);
    signal S : std_logic_Vector (1 downto 0);
    signal Ir, Il : std_logic;
begin

    dut : shifter_unit_16bit PORT MAP (B => B, S => S, Ir => Ir, Il=> Il, H=>H);    
    
    Ir <= '0';
    Il <= '0';
    simulation : process
        
        procedure test ( constant selector : std_logic_vector(1 downto 0);
                         constant input : std_logic_vector(15 downto 0)) is
            begin
                S <= selector;
                B <= input;
                wait for CLOCK_PERIOD;
        end procedure test;
                                
    begin
        L1 : for index0 in 0 to 3 loop
            test(std_logic_vector(to_unsigned(index0, 2)), "1111011111010110");
        end loop L1;
    end process simulation;
        
end Behavioral;
