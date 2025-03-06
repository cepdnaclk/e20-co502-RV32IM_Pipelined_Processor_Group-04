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
    signal dataW  : std_logic_vector(31 downto 0);
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
    signal PC_ID_EX : std_logic_vector(31 downto 0);
    signal INST_ID_EX : std_logic_vector(31 downto 0);
    signal PC_EX_MEM : std_logic_vector(31 downto 0);
    signal EX_Reg1 : std_logic_vector(31 downto 0);
    signal EX_Reg2 : std_logic_vector(31 downto 0);
    signal INST_EX_MEM : std_logic_vector(31 downto 0);
    signal INST_MEM_WB : std_logic_vector(31 downto 0);
    signal ALUR_MEM : std_logic_vector(31 downto 0);
    signal ALUR_EX_MEM : std_logic_vector(31 downto 0);
    signal PC_MEM : std_logic_vector(31 downto 0);
    signal REG2_MEM : std_logic_vector(31 downto 0);
    signal pc_adder_res2 : std_logic_vector(31 downto 0);
    signal WB_RegWD : std_logic_vector(31 downto 0);
    signal INST_WB : std_logic_vector(31 downto 0);
begin
    -- Instantiating the WB Control Unit
    WB_Control: entity work.WB_Control
        port map(
            reset => reset,
            WB_Inst => INST_WB,
            WB_RegWEn => RegWEn
        );
    -- Instantiating the MEM WB Register
    MEM_WB_Register: entity work.MEM_WB_Register
        port map(
            clk => clk,
            reset => reset,
            MEM_RegWD => dataW,
            WB_RegWD => WB_RegWD,
            MEM_Instr => INST_MEM_WB,
            WB_Instr => INST_WB
        );
    -- Instantiating the MEM Control Unit
    MEM_Control: entity work.MEM_Control
        port map(
            reset => reset,
            MEM_Inst => INST_MEM_WB,
            MEM_MemRW => MemRW,
            MEM_WBSel => WBSel
        );
    -- Instantiating the Program Counter Adder
    PC_ADDER2: entity work.PC_Adder
        port map(
            pc_in => PC_MEM,
            pc_out => pc_adder_res2
        );
    -- Instantiating the MEM WB Register
    EX_MEM_Register: entity work.EX_MEM_Register
        port map(
            clk => clk,
            reset => reset,
            EX_PC => PC_EX_MEM,
            MEM_PC => PC_MEM,
            EX_ALUr => alu_result,
            MEM_ALUr => ALUR_MEM,
            EX_Reg2  => EX_Reg2,
            MEM_Reg2 => REG2_MEM,
            EX_Instr => INST_EX_MEM,
            MEM_Instr => INST_MEM_WB   
        );
    -- Instantiating the EX Control Unit
    EX_Control: entity work.EX_Control
        port map(
            reset => reset,
            EX_Inst => INST_EX_MEM,
            EX_ImmSel => ImmSel,
            EX_BrUn => BrUn,
            EX_BrEq => BrEq,
            EX_BrL => BrLT,
            EX_BSel => Bsel,
            EX_ASel => Asel,
            EX_PCSel => PCSel,
            EX_ALUSel => ALUSel
        );
    -- Instantiating the ID EX Register
    ID_EX_Register: entity work.ID_EX_Register
        port map(
            clk => clk,
            reset => reset,
            ID_PC => PC_ID_EX,
            EX_PC => PC_EX_MEM,
            ID_Reg1 => dataR1,
            EX_Reg1 => EX_Reg1,
            ID_Reg2 => dataR2,
            EX_Reg2 => EX_Reg2,
            ID_Instr => INST_ID_EX,
            EX_Instr => INST_EX_MEM   
        );
    -- Instantiating the IF ID Register
    IF_ID_Register: entity work.IF_ID_Register
        port map(
            clk => clk,     
            reset => reset,
            IF_PC => pcres,
            IF_Instr => inst,
            ID_PC => PC_ID_EX,
            ID_Instr => INST_ID_EX
        );
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
            IN0 => EX_Reg1,
            IN1 => PC_EX_MEM,
            SEL => Asel,
            DATA_OUT => Aselres
        );

    -- Instantiating the A Select
    B_SELECTOR: entity work.bsel_mux
        port map(
            IN0 => EX_Reg2,
            IN1 => imm,
            SEL => Bsel,
            DATA_OUT => Bselres
        );

    -- Instantiating the Branch Comparator
    BRANCH_COMP: entity work.BranchComparator
        port map(
            dataR1 => EX_Reg1,
            dataR2 => EX_Reg2,
            BrUn => BrUn,
            BrEq => BrEq,
            BrLT => BrLT 
        );

    -- Instantiating the DMEM
    DMEM: entity work.DMEM
        port map(
            clk => clk,
            addr => ALUR_MEM,
            dataW => REG2_MEM,
            dataR => mem,
            memRW => MemRW,
            func3 => INST_MEM_WB(14 downto 12)
        );

    -- Instantiating the Write Back Selector
    WB_MUX: entity work.wbmux
        port map(
            IN0 => mem,
            IN1 => ALUR_MEM,
            IN2 => pc_adder_res2,
            SEL => WBSel,
            DATA_OUT => dataW
        );

    -- Instantiating the Immediate Generator
    IMM_GEN: entity work.ImmGen
        port map(
            inst => INST_EX_MEM,
            ImmSel => ImmSel,
            imm => imm
        );

    -- Instantiating the Register File
    REG_FILE: entity work.register_file
        port map(
            dataR1 => dataR1,
            dataR2 => dataR2,
            rsR1 => INST_ID_EX(19 downto 15),
            rsR2 => INST_ID_EX(24 downto 20),
            rsW => INST_WB(11 downto 7),
            dataW => WB_RegWD,
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
