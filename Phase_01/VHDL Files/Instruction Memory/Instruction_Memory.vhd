library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Instruction_Memory is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        input_1 : in std_logic_vector (31 downto 0);
        output_1 : out std_logic_vector (31 downto 0)
    );
end Instruction_Memory;

architecture Logic_01 of Instruction_Memory is

    -- Create a memory to store the instructions
    type instruction_mem is array ( 0 to 399 ) of std_logic_vector(7 downto 0);

    begin
        process(clk, reset)

        variable reg_collecting_4_bytes : std_logic_vector(31 downto 0) ;

        -- Initialize the memory with the instructions
        -- Done by manually writing the instructions
        variable reg_instruction_mem : instruction_mem := (
            0 => "00000000",
            1 => "00000000",
            2 => "00000000",
            3 => "00000000",
            4 => "00000000",
            5 => "00000000",
            6 => "00000000",
            7 => "00000001",
            8 => "00000000",
            9 => "00000000",
            10 => "00000000",
            11 => "00000010",
            12 => "00000000",
            13 => "00000000",
            14 => "00000000",
            15 => "00000011",
            16 => "00000000",
            17 => "00000000",
            18 => "00000000",
            19 => "00000100",
            20 => "00000000",
            21 => "00000000",
            22 => "00000000",
            23 => "00000101",
            others => "00000000"   
        );
        begin
            if reset = '1' then
                output_1  <= (others => '0');
            elsif rising_edge(clk) then
                -- Collect the 4 bytes of the instruction
                reg_collecting_4_bytes := reg_instruction_mem(to_integer(unsigned(input_1))) & reg_instruction_mem(to_integer(unsigned(input_1))+1) & reg_instruction_mem(to_integer(unsigned(input_1))+2) & reg_instruction_mem(to_integer(unsigned(input_1))+3);
                --output_1  <= instruction_mem(input_1);
                output_1  <= reg_collecting_4_bytes;
            end if;

        end process;

end Logic_01;


