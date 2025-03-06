library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BranchComparator is
    port (
        dataR1 : in  std_logic_vector(31 downto 0); -- Register Source 1 Data
        dataR2 : in  std_logic_vector(31 downto 0); -- Register Source 2 Data
        BrUn   : in  std_logic;                     -- Unsigned comparison (1: unsigned, 0: signed)
        BrEq   : out std_logic;                     -- Branch Equal signal
        BrLT   : out std_logic                      -- Branch Less Than signal
    );
end BranchComparator;

architecture Behavioral of BranchComparator is
begin
    process(dataR1, dataR2, BrUn)
        variable rs1_signed   : signed(31 downto 0);
        variable rs2_signed   : signed(31 downto 0);
        variable rs1_unsigned : unsigned(31 downto 0);
        variable rs2_unsigned : unsigned(31 downto 0);
    begin
        -- Convert inputs to signed/unsigned types
        rs1_signed := signed(dataR1);
        rs2_signed := signed(dataR2);
        rs1_unsigned := unsigned(dataR1);
        rs2_unsigned := unsigned(dataR2);

        -- Determine Branch Equal (BrEq)
        if BrUn = '1' then
            -- Unsigned comparison
            if rs1_unsigned = rs2_unsigned then
                BrEq <= '1';
            else
                BrEq <= '0';
            end if;
        else
            -- Signed comparison
            if rs1_signed = rs2_signed then
                BrEq <= '1';
            else
                BrEq <= '0';
            end if;
        end if;

        -- Determine Branch Less Than (BrLT)
        if BrUn = '1' then
            -- Unsigned comparison
            if rs1_unsigned < rs2_unsigned then
                BrLT <= '1';
            else
                BrLT <= '0';
            end if;
        else
            -- Signed comparison
            if rs1_signed < rs2_signed then
                BrLT <= '1';
            else
                BrLT <= '0';
            end if;
        end if;
    end process;
end Behavioral;
