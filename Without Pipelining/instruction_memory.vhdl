library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IMEM is
    port (
        addr : in  std_logic_vector(31 downto 0); -- Address input from PC
        inst : out std_logic_vector(31 downto 0)  -- Instruction output
    );
end IMEM;

architecture Behavioral of IMEM is
    -- Memory array for instructions
    type memory_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal imemsig : memory_array := (
        0  => "00000000101000000000001010010011",  -- addi r5, r0, 10   r5 = r0 + 10 = 10
        1  => "11111100111000000000000010010011",  -- addi r1, r0, -50   r1 = r0 + (-50) = -50
        2  => "00000000111100000000000100010011",  -- addi r2, r0, 15   r2 = r0 + 15 = 15
        3  => "00000000010100001000001110110011",  -- add r5, r1, r7   r7 = r1 + r5 = -40
        4  => "00000010010100001000000110110011",  -- mul r5, r1, r3   r3 = r1 * r5 = -500
        5  => "00000010010100010100000110110011",  -- div r5, r2, r3   r3 = r2 / r5 = 1
        6  => "00000010010100010110000110110011",  -- rem r5, r2, r3   r3 = r2 mod r5 = 5
        7  => "00000000000100000010000000100011",  -- sw r1, 0(r0) store r1 first 4 bytes on 0x00, 0x01, 0x02, 0x03
        8  => "00000000000000000000001110000011",  -- lb r7, 0(r0) store first byte of 0x00 on r7
        9  => "11111110000000000000111011100011",  -- beq r0, r0, -2 compare r0 and r0 and branch 4 half words back if true
        others => (others => '0') -- Initialize unused locations to 0
    );
begin
    -- Fetch the instruction based on PC address
    inst <= imemsig(to_integer(unsigned(addr(6 downto 2))));
end Behavioral;
