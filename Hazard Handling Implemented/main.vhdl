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
    signal EX_PCSel      : std_logic;
    signal MEM_PCSel     : std_logic;
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
    signal Asel    : std_logic_vector(1 downto 0);
    signal Bsel    : std_logic_vector(1 downto 0);
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
    signal BR_S1 : std_logic;
    signal BR_CMP_IN1 : std_logic_vector(31 downto 0);
    signal BR_S2 : std_logic;
    signal BR_CMP_IN2 : std_logic_vector(31 downto 0);
    signal LOAD_USE : std_logic;
begin
    -- Instantiating the Load Use Hazard Detection Unit
    LOAD_USE_UNIT: entity work.load_use
        port map(
            instr_ID => INST_ID_EX,
            instr_IF => inst,
            hazard   => LOAD_USE
        );

    -- Instantiating the Branch FW Sel Mux 2
    BR_FWD_MUX2: entity work.mux2x32
        port map(
            IN0 => dataR2, 
            IN1 => ALUR_MEM,
            SEL => BR_S2,
            DATA_OUT => BR_CMP_IN2
        );

    -- Instantiating the Branch FW Sel Mux 1
    BR_FWD_MUX1: entity work.mux2x32
        port map(
            IN0 => dataR1, 
            IN1 => ALUR_MEM,
            SEL => BR_S1,
            DATA_OUT => BR_CMP_IN1
        );

    -- Instantiating the Branch FWDUnit
    Branch_FWD: entity work.branch_fwd
        port map(
            INST_EX => INST_EX_MEM,
            INST_MEM => INST_MEM_WB,
            SEL1 => BR_S1,
            SEL2 => BR_S2,
            RST => reset
        );

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
            pc_out => pc_adder_res2,
       load_hazard => '0'
        );
    -- Instantiating the MEM WB Register
    EX_MEM_Register: entity work.EX_MEM_Register
        port map(
            clk => clk,
            reset => reset,
            EX_PC => PC_EX_MEM,
            MEM_PC => PC_MEM,
            EX_PCSel => EX_PCSel,
            MEM_PCSel => MEM_PCSel, 
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
            WB_Inst => INST_WB,
            MEM_Inst => INST_MEM_WB,
            EX_BrUn => BrUn,
            EX_BrEq => BrEq,
            EX_BrL => BrLT,
            EX_BSel => Bsel,
            EX_ASel => Asel,
            EX_PCSel => EX_PCSel,
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
            EX_Instr => INST_EX_MEM,
            EX_PCSel => EX_PCSel   
        );
    -- Instantiating the IF ID Register
    IF_ID_Register: entity work.IF_ID_Register
        port map(
            clk => clk,     
            reset => reset,
            pc_sel => EX_PCSel,
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
            ALUFWD => ALUR_MEM,
            DMEMFWD => WB_RegWD,
            SEL => Asel,
            DATA_OUT => Aselres
        );

    -- Instantiating the A Select
    B_SELECTOR: entity work.bsel_mux
        port map(
            IN0 => EX_Reg2,
            IN1 => imm,
            ALUFWD => ALUR_MEM,
            DMEMFWD => WB_RegWD,
            SEL => Bsel,
            DATA_OUT => Bselres
        );

    -- Instantiating the Branch Comparator
    BRANCH_COMP: entity work.BranchComparator
        port map(
            dataR1 => BR_CMP_IN1,
            dataR2 => BR_CMP_IN2,
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
            inst => inst,
            load_hazard => LOAD_USE
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
            pc_out => pc_adder_res,
       load_hazard => LOAD_USE
        );

    -- Instantiating the Program Counter Selector
    PC_SEL: entity work.pcsel_mux
        port map(
            IN0 => pc_adder_res,
            IN1 => alu_result,
            SEL => EX_PCSel,
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
        wait for 3000 ns;
        wait;
    end process;

end arch;
