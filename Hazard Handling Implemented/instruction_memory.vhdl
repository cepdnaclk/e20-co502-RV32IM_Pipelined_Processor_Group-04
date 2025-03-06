library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IMEM is
    port (
        addr   : in  std_logic_vector(31 downto 0); -- Address input from PC
        inst   : out std_logic_vector(31 downto 0); -- Instruction output
   load_hazard : in std_logic                       -- Load use hazard signal
    );
end IMEM;

architecture Behavioral of IMEM is
    -- Memory array for instructions
    type memory_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal imemsig : memory_array := (
        0  => "00000000101000000000001010010011", -- addi r5, r0, 10    r5 = r0 + 10 = 10
        1  => "11111100111000101000000010010011", -- addi r1, r5, -50   r1 = r5 + (-50) = -40
        2  => "01000000010100001000000110110011", -- sub r5, r1, r3     r3 = r1 - r5
        3  => "01000000010100000000000110110011", -- sub r5, r0, r3     r3 = r0 - r5
        4  => "00000010010100001000000110110011", -- mul r5, r1, r3   r3 = r1 * r5 = -400
        5  => "00000010010100011100001110110011", -- div r5, r3, r7   r7 = r3 / r5 = -40
        6  => "00000010010100001110001110110011", -- rem r5, r1, r7   r7 = r1 mod r5 = 0
        7  => "00000000000100000010000000100011", -- SW r1, 0(r0)
        8  => "01000000010100000000000110110011", -- sub r5, r0, r3     r3 = r0 - r5
        9  => "00000000000000000000000000000000", -- NOP
        10 => "00000000000000000000000000000000", -- NOP
        11 => "00000000000000000010001110000011", -- lw r7, 0(r0)
        12 => "00000000000000111000100000110011", -- add r16, r7, r0
        13 => "11111110000000000000111011100011", -- beq r0, r0, -2 compare r0 and r0 and branch 4 half words back if true
        others => (others => '0') -- Initialize unused locations to NOP
    );

begin
    -- Fetch the instruction based on PC address or generate NOP
    process (addr, load_hazard)
    begin
        if load_hazard = '1' then
            inst <= (others => '0') after 1 ns; -- Inject NOP when load hazard occurs
        else
            inst <= imemsig(to_integer(unsigned(addr(6 downto 2))));
        end if;
    end process;
end Behavioral;
