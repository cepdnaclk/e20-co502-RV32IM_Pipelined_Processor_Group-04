library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity branch_fwd is
    port(
        INST_EX, INST_MEM : in std_logic_vector(31 downto 0);      -- 2 separate 32-bit inputs
        SEL1              : out std_logic;                         -- 1-bit selection signal
        SEL2              : out std_logic;                         -- 1-bit selection signal
        RST               : in std_logic                          -- reset signal
    );
end branch_fwd;

architecture fwd_arch of branch_fwd is
    signal MEM_Rd  : std_logic_vector(4 downto 0);
    signal EX_Rs1  : std_logic_vector(4 downto 0);
    signal EX_Rs2  : std_logic_vector(4 downto 0);
begin
    process(INST_EX, INST_MEM, RST, MEM_Rd, EX_Rs1, EX_Rs2)
    begin
        SEL1  <= '0';
        SEL2  <= '0';
        if RST = '1' then
            SEL1  <= '0';
            SEL2  <= '0';
        else
            MEM_Rd  <= INST_MEM(11 downto 7); -- Destination register in MEM stage
            EX_Rs1  <= INST_EX(19 downto 15); -- Source register 1 in EX stage
            EX_Rs2  <= INST_EX(24 downto 20); -- Source register 2 in EX stage

            if EX_Rs1 /= "00000" then
                if (EX_Rs1 = MEM_Rd) then
                    SEL1  <= '1'; -- ALU FWD
                end if;
                if (EX_Rs2 = MEM_Rd) then
                    SEL2  <= '1'; -- ALU FWD
                end if;
            end if;
        end if;
    end process;
end fwd_arch;
