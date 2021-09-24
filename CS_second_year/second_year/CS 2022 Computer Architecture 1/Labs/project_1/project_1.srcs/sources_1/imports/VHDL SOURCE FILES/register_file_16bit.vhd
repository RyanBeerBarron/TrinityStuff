----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2018 06:08:56 PM
-- Design Name: 
-- Module Name: register_file_16bit - Behavioral
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

entity register_file_16bit is
    port   ( select_a, select_b : in std_logic_vector(2 downto 0);
           dest : in std_logic_vector(2 downto 0);
           write_enable : in std_logic;
           data : in std_logic_vector(15 downto 0);
           data_a : out std_logic_vector(15 downto 0);
           data_b : out std_logic_Vector(15 downto 0)); 
end register_file_16bit;


architecture Behavioral of register_file_16bit is
    Component register_16bit
      port ( D : in std_logic_vector(15 downto 0);
              load, write_enable : in std_logic;
              Q : out std_logic_vector(15 downto 0));
    end Component;
    
    Component decoder3_8
     port ( A : in std_logic_vector(2 downto 0);
               Q0 : out std_logic;
               Q1 : out std_logic;
               Q2 : out std_logic;
               Q3 : out std_logic;
               Q4 : out std_logic;
               Q5 : out std_logic;
               Q6 : out std_logic;
               Q7 : out std_logic);
    end Component;           
          
    
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
    end Component;          
    
    signal mux_reg_data : std_logic_vector(15 downto 0);
    
    signal load_reg0, load_reg1, load_reg2, load_reg3, load_reg4, load_reg5, load_reg6, load_reg7 : std_logic;
    
    signal  read_reg0_data, read_reg1_data, read_reg2_data, read_reg3_data, read_reg4_data, 
            read_reg5_data, read_reg6_data, read_reg7_data : std_logic_vector(15 downto 0);
            
    
    begin
    mux_a : mux8_3_16bit PORT MAP(src => select_a, In0 =>read_reg0_data, In1 =>read_reg1_data, In2 =>read_reg2_data, In3 =>read_reg3_data,
                                     In4 =>read_reg4_data, In5 =>read_reg5_data, In6 =>read_reg6_data, In7 =>read_reg7_data, Z0 =>data_a);
    
    mux_b : mux8_3_16bit PORT MAP(  src => select_b,In0 =>read_reg0_data, In1 =>read_reg1_data, In2 =>read_reg2_data, In3 =>read_reg3_data,
                                    In4 =>read_reg4_data, In5 =>read_reg5_data, In6 =>read_reg6_data, In7 =>read_reg7_data, Z0 => data_b);
            
    decoder : decoder3_8 PORT MAP( A => dest, Q0 =>load_reg0, Q1 =>load_reg1, Q2 =>load_reg2, Q3 =>load_reg3, Q4 =>load_reg4, Q5 =>load_reg5, Q6 =>load_reg6, Q7 =>load_reg7);         
    
    register0 : register_16bit PORT MAP(D =>data, load =>load_reg0, write_enable =>write_enable, Q =>read_reg0_data);
    register1 : register_16bit PORT MAP(D =>data, load =>load_reg1, write_enable =>write_enable, Q =>read_reg1_data);
    register2 : register_16bit PORT MAP(D =>data, load =>load_reg2, write_enable =>write_enable, Q =>read_reg2_data);
    register3 : register_16bit PORT MAP(D =>data, load =>load_reg3, write_enable =>write_enable, Q =>read_reg3_data);
    register4 : register_16bit PORT MAP(D =>data, load =>load_reg4, write_enable =>write_enable, Q =>read_reg4_data);
    register5 : register_16bit PORT MAP(D =>data, load =>load_reg5, write_enable =>write_enable, Q =>read_reg5_data);
    register6 : register_16bit PORT MAP(D =>data, load =>load_reg6, write_enable =>write_enable, Q =>read_reg6_data);
    register7 : register_16bit PORT MAP(D =>data, load =>load_reg7, write_enable =>write_enable, Q =>read_reg7_data);
    

end Behavioral;
