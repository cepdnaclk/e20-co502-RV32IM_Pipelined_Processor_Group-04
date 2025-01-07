--- Instruction     DMEMOP     
--- lb              000
--- lh              001
--- lw              010
--- lbu             011
--- lhu             100
--- sb              101
--- sh              110
--- sw              111

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Data_Memory is
    port(
        --input control signals
        Clock : in std_logic;
        Reset : in std_logic;
        DMEMOP : in std_logic_vector(2 downto 0);
        MemRead : in std_logic;
        MemWrite : in std_logic;

        --Inpud Addresses
        MemReadAddress : in std_logic_vector(31 downto 0);

        --Input Data
        MemDataInput : in std_logic_vector(31 downto 0);

        --Output Data
        MemDataOutput : out std_logic_vector(31 downto 0)
    );

end entity;



architecture Logic_01 of Data_Memory is

    -- Defing the Data memory - 1024 Bytes memory
    type DataMemory is Array (0 to 1023) of std_logic_vector(7 downto 0);

    begin

        process(Clock , Reset, DMEMOP, MemRead, MemWrite, MemReadAddress, MemDataInput)
            variable DataMem : DataMemory := (others => (others => 'X'));
            variable signExtend : std_logic_vector(31 downto 0) := (others => '0');
            begin

                if rising_edge(Clock) then
                    if Reset = '1' then
                        DataMem := (others => (others => 'X'));
                    else
                        if MemRead = '1' then
                            if DMEMOP = "000" then
                                --lb instruction
                                signExtend := (others => DataMem(to_integer(unsigned(MemReadAddress)))(7));
                                MemDataOutput <= signExtend(31 downto 8) & DataMem(to_integer(unsigned(MemReadAddress)));
                            
                            elsif DMEMOP = "001" then
                                --lh instruction
                                signExtend := (others => DataMem(to_integer(unsigned(MemReadAddress)))(7));
                                MemDataOutput <= signExtend(31 downto 16) & DataMem(to_integer(unsigned(MemReadAddress))) & DataMem(to_integer(unsigned(MemReadAddress) + 1));

                            elsif DMEMOP = "010" then
                                --lw Instruction
                                MemDataOutput <= DataMem(to_integer(unsigned(MemReadAddress))) & DataMem(to_integer(unsigned(MemReadAddress) + 1)) & DataMem(to_integer(unsigned(MemReadAddress) + 2)) & DataMem(to_integer(unsigned(MemReadAddress) + 3));
                            
                            elsif DMEMOP = "011" then
                                --lbu instruction
                                MemDataOutput <= signExtend(31 downto 8) & DataMem(to_integer(unsigned(MemReadAddress)));

                            elsif DMEMOP = "100" then
                                --lhu instruction
                                MemDataOutput <= signExtend(31 downto 16) & DataMem(to_integer(unsigned(MemReadAddress))) & DataMem(to_integer(unsigned(MemReadAddress) + 1));

                            end if;

                            --MemDataOutput <= DataMem(to_integer(unsigned(MemReadAddress)));
                        elsif MemWrite = '1' then

                            if DMEMOP = "101" then
                                --sb instruction
                                DataMem(to_integer(unsigned(MemReadAddress))) := MemDataInput(7 downto 0);

                            elsif DMEMOP = "110" then
                                --sh instruction
                                DataMem(to_integer(unsigned(MemReadAddress))) := MemDataInput(15 downto 8);
                                DataMem(to_integer(unsigned(MemReadAddress) + 1)) := MemDataInput(7 downto 0);

                            elsif DMEMOP = "111" then
                                --sw instruction
                                DataMem(to_integer(unsigned(MemReadAddress))) := MemDataInput(31 downto 24);
                                DataMem(to_integer(unsigned(MemReadAddress) + 1)) := MemDataInput(23 downto 16);
                                DataMem(to_integer(unsigned(MemReadAddress) + 2)) := MemDataInput(15 downto 8);
                                DataMem(to_integer(unsigned(MemReadAddress) + 3)) := MemDataInput(7 downto 0);

                            end if;
                            --DataMem(to_integer(unsigned(MemReadAddress))) := MemDataInput;

                        end if;
                    end if; 

                end if;

            end process;
end architecture;
