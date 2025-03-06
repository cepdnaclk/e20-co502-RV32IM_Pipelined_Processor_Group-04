library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
    port(
        A          : in std_logic_vector(31 downto 0);  -- First operand (rs1)
        B          : in std_logic_vector(31 downto 0);  -- Second operand
        ALU_SEL    : in std_logic_vector(3 downto 0);   -- ALU operation selector
        ALU_RESULT : out std_logic_vector(31 downto 0)  -- ALU result
    );
end alu;

architecture alu_arch of alu is
    -- Signals for results from individual components
    signal add_result   : std_logic_vector(31 downto 0);
    signal sub_result   : std_logic_vector(31 downto 0);
    signal and_result   : std_logic_vector(31 downto 0);
    signal or_result    : std_logic_vector(31 downto 0);
    signal xor_result   : std_logic_vector(31 downto 0);
    signal sll_result   : std_logic_vector(31 downto 0);
    signal srl_result   : std_logic_vector(31 downto 0);
    signal sra_result   : std_logic_vector(31 downto 0);
    signal slt_result   : std_logic_vector(31 downto 0);
    signal mul_result   : std_logic_vector(31 downto 0);
    signal mulh_result  : std_logic_vector(31 downto 0);
    signal mulhu_result : std_logic_vector(31 downto 0);
    signal div_result   : std_logic_vector(31 downto 0);
    signal divu_result  : std_logic_vector(31 downto 0);
    signal rem_result   : std_logic_vector(31 downto 0);
begin
    -- Instantiating the ADD Unit
    ADD_UNIT: entity work.adder_unit
        port map(
            A => A,
            B => B,
            ADD_RESULT => add_result
        );

    -- Instantiating the SUB & SLT Unit
    SUB_UNIT: entity work.subtract_slt_unit
        port map(
            A => A,
            B => B,
            SUB_RESULT => sub_result,
            SLT_RESULT => slt_result
        );

    -- Instantiating the AND Unit
    AND_UNIT: entity work.and_unit
        port map(
            A => A,
            B => B,
            AND_RESULT => and_result
        );

    -- Instantiating the OR Unit
    OR_UNIT: entity work.or_unit
        port map(
            A => A,
            B => B,
            OR_RESULT => or_result
        );

    -- Instantiating the XOR Unit
    XOR_UNIT: entity work.xor_unit
        port map(
            A => A,
            B => B,
            XOR_RESULT => xor_result
        );

    -- Instantiating the SLL Unit
    SLL_UNIT: entity work.sll_unit
        port map(
            A => A,
            B => B,
            SLL_RESULT => sll_result
        );

    -- Instantiating the SRL Unit
    SRL_UNIT: entity work.srl_unit
        port map(
            A => A,
            B => B,
            SRL_RESULT => srl_result
        );

    -- Instantiating the SRA Unit
    SRA_UNIT: entity work.arithmetic_shift_unit
        port map(
            A => A,
            B => B,
            SRA_RESULT => sra_result
        );

    -- Instantiating the MUL Unit
    MUL_UNIT: entity work.mul_unit
        port map(
            A => A,
            B => B,
            MUL_RESULT => mul_result,
            MULH_RESULT => mulh_result,
            MULHU_RESULT => mulhu_result
        );

    -- Instantiating the DIV Unit
    DIV_UNIT: entity work.div_unit
        port map(
            A => A,
            B => B,
            DIV_RESULT => div_result,
            DIVU_RESULT => divu_result,
            REM_RESULT => rem_result
        );

    MUX16x32: entity work.mux16x32
        port map(
            IN0 => add_result,
            IN1 => sub_result,
            IN2 => and_result,
            IN3 => or_result,
            IN4 => xor_result,
            IN5 => sll_result,
            IN6 => srl_result,
            IN7 => sra_result,
            IN8 => slt_result,
            IN9 => mul_result,
            IN10 => mulh_result,
            IN11 => mulhu_result,
            IN12 => B,
            IN13 => div_result,
            IN14 => divu_result,
            IN15 => rem_result,
            SEL => ALU_SEL,
            DATA_OUT => ALU_RESULT
        );
end alu_arch;
