library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity main is
end main;

architecture arch of main is
    -- Signals for results from individual components
    signal pc_adder_res  : std_logic_vector(31 downto 0);
    signal alu_result    : std_logic_vector(31 downto 0);
    signal inst          : std_logic_vector(31 downto 0);
    signal pcres         : std_logic_vector(31 downto 0);
    signal PCSel         : std_logic;
    signal pcselres      : std_logic_vector(31 downto 0);
    signal imm     : std_logic_vector(31 downto 0);
    signal ImmSel  : std_logic_vector(2 downto 0);
    signal RegWEn  : std_logic;
    signal dataR1  : std_logic_vector(31 downto 0);
    signal dataR2  : std_logic_vector(31 downto 0);
    signal dataW   : std_logic_vector(31 downto 0);
    signal BrLT    : std_logic;
    signal BrEq    : std_logic;
    signal BrUn    : std_logic;
    signal Bselres : std_logic_vector(31 downto 0);
    signal Aselres : std_logic_vector(31 downto 0);
    signal Asel    : std_logic;
    signal Bsel    : std_logic;
    signal MemRW   : std_logic;
    signal ALUSel  : std_logic_vector(3 downto 0);
    signal mem     : std_logic_vector(31 downto 0);
    signal WBSel   : std_logic_vector(1 downto 0);
    signal clk     : std_logic;
    signal reset   : std_logic;
begin
    -- Instantiating the ALU
    ALU: entity work.alu
        port map(
            A => Aselres,
            B => Bselres,
            ALU_RESULT => alu_result,
            ALU_SEL => ALUSel
        );

    -- Instantiating the A Select
    A_SELECTOR: entity work.asel_mux
        port map(
            IN0 => dataR1,
            IN1 => pcres,
            SEL => Asel,
            DATA_OUT => Aselres
        );

    -- Instantiating the A Select
    B_SELECTOR: entity work.bsel_mux
        port map(
            IN0 => dataR2,
            IN1 => imm,
            SEL => Bsel,
            DATA_OUT => Bselres
        );

    -- Instantiating the Branch Comparator
    BRANCH_COMP: entity work.BranchComparator
        port map(
            dataR1 => dataR1,
            dataR2 => dataR2,
            BrUn => BrUn,
            BrEq => BrEq,
            BrLT => BrLT
        );

    -- Instantiating the DMEM
    DMEM: entity work.DMEM
        port map(
            clk => clk,
            addr => alu_result,
            dataW => dataR2,
            dataR => mem,
            memRW => MemRW,
            func3 => inst(14 downto 12)
        );

    -- Instantiating the Write Back Selector
    WB_MUX: entity work.wbmux
        port map(
            IN0 => mem,
            IN1 => alu_result,
            IN2 => pc_adder_res,
            SEL => WBSel,
            DATA_OUT => dataW
        );

    -- Instantiating the Immediate Generator
    IMM_GEN: entity work.ImmGen
        port map(
            inst => inst,
            ImmSel => ImmSel,
            imm => imm
        );

    -- Instantiating the Register File
    REG_FILE: entity work.register_file
        port map(
            dataR1 => dataR1,
            dataR2 => dataR2,
            rsR1 => inst(19 downto 15),
            rsR2 => inst(24 downto 20),
            rsW => inst(11 downto 7),
            dataW => dataW,
            writeEnable => RegWEn,
            clk => clk
        );

    -- Instantiating the Instruction Memory
    IMEM: entity work.IMEM
        port map(
            addr => pcres,
            inst => inst
        );

    -- Instantiating the Program Counter
    PC: entity work.PC
        port map(
            clk => clk,
            reset => reset,
            pc_in => pcselres,
            pc_out => pcres
        );

    -- Instantiating the Program Counter Adder
    PC_ADDER: entity work.PC_Adder
        port map(
            pc_in => pcres,
            pc_out => pc_adder_res
        );

    -- Instantiating the Program Counter Selector
    PC_SEL: entity work.pcsel_mux
        port map(
            IN0 => pc_adder_res,
            IN1 => alu_result,
            SEL => PCSel,
            DATA_OUT => pcselres
        );

    -- Instantiating the Control Unit
    CONTROL_UNIT: entity work.control_unit
        port map(
            INST => inst,
            RegWEn => RegWEn,
            ALUSel => ALUSel,
            BSel => Bsel,
            WBSel => WBSel,
            MemRW => MemRW,
            ImmSel => ImmSel,
            PCSel => PCSel,
            BrUn => BrUn,
            BrEq => BrEq,
            BrLT => BrLT,
            ASel => Asel
        );

    -- Instantiating the Clock Unit
    CLOCK: entity work.clock_unit
        port map(
            clk_out => clk
        );


    test_process: process
    begin
        reset <= '1';
        wait for 2 ns;
        reset <= '0';
        wait for 1000 ns;
        wait;
    end process;

end arch;
