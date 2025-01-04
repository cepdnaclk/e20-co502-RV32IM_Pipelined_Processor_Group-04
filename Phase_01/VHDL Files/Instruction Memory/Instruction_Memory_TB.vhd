library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_INS_MEM_TB is
end PC_INS_MEM_TB;

architecture architecture_PC_INS_MEM_TB of PC_INS_MEM_TB is
    signal clk_tb , reset_tb : std_logic := '0';
    signal pc_output_tb , pc_adder_output_tb , ins_mem_output_tb : std_logic_vector (31 downto 0);

    component PC_ADDER is
        Port (
            input_1 : in std_logic_vector (31 downto 0);
            output_1 : out std_logic_vector (31 downto 0)
        );
    end component;

    component PC is
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               input_Address : in STD_LOGIC_VECTOR (31 downto 0);
               output_Address : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    component Instruction_Memory is
        Port (
            clk : in std_logic;
            reset : in std_logic;
            input_1 : in std_logic_vector (31 downto 0);
            output_1 : out std_logic_vector (31 downto 0)
        );
    end component;

 begin

    PC_Adder_IMmpl : PC_ADDER
        port map(
            input_1 => pc_output_tb,
            output_1 => pc_adder_output_tb
        );

    PC_Impl : PC
        port map(
            clk => clk_tb,
            reset => reset_tb,
            input_Address => pc_adder_output_tb,
            output_Address => pc_output_tb 
        );

    Instruction_Memory_Impl : Instruction_Memory
        port map(
            clk => clk_tb,
            reset => reset_tb,
            input_1 => pc_output_tb,
            output_1 => ins_mem_output_tb
        );


    process
        begin 
            reset_tb <= '1';
            wait for 10 ps;
            reset_tb <= '0';
            for i in 0 to 10 loop
                wait for 10 ps;
                clk_tb <= not clk_tb;
                
            end loop;
            wait;
        end process;
    
end architecture_PC_INS_MEM_TB;