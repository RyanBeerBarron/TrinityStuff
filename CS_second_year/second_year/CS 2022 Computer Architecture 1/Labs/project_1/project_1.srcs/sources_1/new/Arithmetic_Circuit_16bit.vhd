----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 04:36:02 PM
-- Design Name: 
-- Module Name: Arithmetic_Circuit_16bit - Behavioral
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

entity Arithmetic_Circuit_16bit is
    port (  A, B : in std_logic_vector ( 15 downto 0);
            S0, S1, Cin : in std_logic;
            G : out std_logic_vector ( 15 downto 0);
            Cout, V : out std_logic);
end Arithmetic_Circuit_16bit;

architecture Behavioral of Arithmetic_Circuit_16bit is

    component ripple_carry_adder_16bit
        port (  x, y : in std_logic_vector (15 downto 0);
            C0 : in std_logic;
            Cout, V : out std_logic;
            S : out std_logic_vector (15 downto 0));  
    end component;
    
    component input_logic_16bit
        port (  B : in std_logic_vector ( 15 downto 0);
                S0, S1 : in std_logic;
                Bout : out std_logic_vector ( 15 downto 0));         
    end component;
    
    signal Y, Vout : std_logic_vector( 15 downto 0 );
    signal Carry, Overflow : std_logic;
    
    
begin

    input_logic : input_logic_16bit PORT MAP ( B => B, S0=>S0, S1=>S1, Bout=>Y);
    
    rca : ripple_carry_adder_16bit PORT MAP ( x => A, y => y, C0 => Cin, S => Vout, Cout => Carry, V => Overflow); 

    Cout <= Carry;
    V <= Overflow;
    G <= Vout;
    
    
end Behavioral;
