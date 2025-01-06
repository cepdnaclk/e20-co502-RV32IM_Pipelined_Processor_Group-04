library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sign_Extender is
    port(
        Instruction_input : IN std_logic_vector(31 downto 0);
        Imm_output : OUT std_logic_vector(31 downto 0)
    );

end entity Sign_Extender;


architecture logic_1 of Sign_Extender is

    begin

        process(Instruction_input)
        variable Imm_Intermediate : std_logic_vector(31 downto 0); 
        begin
            -- I type instruction
            if (Instruction_input(6 downto 0) = "0000011") then
                Imm_Intermediate := (others => Instruction_input(31));
                Imm_output <= (Imm_Intermediate(31 downto 12) & Instruction_input(31 downto 20));

            -- S type instruction
            elsif (Instruction_input(6 downto 0) = "0100011") then
                Imm_Intermediate := (others => Instruction_input(31));
                Imm_output <= (Imm_Intermediate(31 downto 12 ) & Instruction_input(31 downto 25) & Instruction_input(11 downto 7));

            -- B type instruction
            elsif (Instruction_input(6 downto 0) = "1100011") then
                Imm_Intermediate := (others => Instruction_input(31));
                Imm_output <= (Imm_Intermediate(31 downto 13) & Instruction_input(31) & Instruction_input(7) & Instruction_input(30 downto 25) & Instruction_input(11 downto 8)  & '0');

            -- U type instruction
            elsif (Instruction_input(6 downto 0) = "0110111") then
                Imm_Intermediate := (others => '0');
                Imm_output <= (Instruction_input(31 downto 12) & Imm_Intermediate(11 downto 0));
                
            -- J type instruction
            elsif (Instruction_input(6 downto 0) = "1101111") then
                Imm_Intermediate := (others => Instruction_input(31));
                Imm_output <= (Imm_Intermediate(31 downto 21) & Instruction_input(31) & Instruction_input(19 downto 12) & Instruction_input(20) & Instruction_input(30 downto 21) & '0');

            else
                Imm_output <= (others => '0');
            end if;
        end process;

end architecture logic_1;
