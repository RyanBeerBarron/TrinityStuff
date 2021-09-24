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
    port ( src : in std_logic_vector(2 downto 0);
           dest : in std_logic_vector(2 downto 0);
           Clk : in std_logic;
           data_src : in std_logic;
           data : in std_logic_vector(15 downto 0);
           reg0 : out std_logic_vector(15 downto 0);
           reg1 : out std_logic_vector(15 downto 0);
           reg2 : out std_logic_vector(15 downto 0);
           reg3 : out std_logic_vector(15 downto 0);
           reg4 : out std_logic_vector(15 downto 0);
           reg5 : out std_logic_vector(15 downto 0);
           reg6 : out std_logic_vector(15 downto 0);
           reg7  : out std_logic_vector(15 downto 0));
end register_file_16bit;


architecture Behavioral of register_file_16bit is
    Component register_16bit
      port ( D : in std_logic_vector(15 downto 0);
              load, Clk : in std_logic;
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
    
    Component mux2_1_16bit
    port ( s : in std_logic;
               In0 : in std_logic_vector(15 downto 0);
               In1 : in std_logic_vector(15 downto 0);
               Z : out std_logic_vector(15 downto 0));
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
            
    signal write_reg_data : std_logic_vector(15 downto 0);
    
    begin
    mux_data : mux8_3_16bit PORT MAP(src => src, In0 =>read_reg0_data, In1 =>read_reg1_data, In2 =>read_reg2_data, In3 =>read_reg3_data,
                                     In4 =>read_reg4_data, In5 =>read_reg5_data, In6 =>read_reg6_data, In7 =>read_reg7_data, Z0 =>mux_reg_data);
            
    decoder : decoder3_8 PORT MAP( A => dest, Q0 =>load_reg0, Q1 =>load_reg1, Q2 =>load_reg2, Q3 =>load_reg3, Q4 =>load_reg4, Q5 =>load_reg5, Q6 =>load_reg6, Q7 =>load_reg7);         
    
    mux_data_src : mux2_1_16bit PORT MAP(s =>data_src, In0 =>data, In1 =>mux_reg_data, Z =>write_reg_data);
    
    register0 : register_16bit PORT MAP(D =>write_reg_data, load =>load_reg0, Clk =>Clk, Q =>read_reg0_data);
    register1 : register_16bit PORT MAP(D =>write_reg_data, load =>load_reg1, Clk =>Clk, Q =>read_reg1_data);
    register2 : register_16bit PORT MAP(D =>write_reg_data, load =>load_reg2, Clk =>Clk, Q =>read_reg2_data);
    register3 : register_16bit PORT MAP(D =>write_reg_data, load =>load_reg3, Clk =>Clk, Q =>read_reg3_data);
    register4 : register_16bit PORT MAP(D =>write_reg_data, load =>load_reg4, Clk =>Clk, Q =>read_reg4_data);
    register5 : register_16bit PORT MAP(D =>write_reg_data, load =>load_reg5, Clk =>Clk, Q =>read_reg5_data);
    register6 : register_16bit PORT MAP(D =>write_reg_data, load =>load_reg6, Clk =>Clk, Q =>read_reg6_data);
    register7 : register_16bit PORT MAP(D =>write_reg_data, load =>load_reg7, Clk =>Clk, Q =>read_reg7_data);
    
    reg0 <= read_reg0_data;
    reg1 <= read_reg1_data;
    reg2 <= read_reg2_data;
    reg3 <= read_reg3_data;
    reg4 <= read_reg4_data;
    reg5 <= read_reg5_data;
    reg6 <= read_reg6_data;
    reg7 <= read_reg7_data;

end Behavioral;
