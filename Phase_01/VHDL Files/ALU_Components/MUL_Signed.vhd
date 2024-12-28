library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multiplier_signed is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        output_1 : OUT std_logic_vector(31 downto 0);
        output_2 : OUT std_logic_vector(31 downto 0)
    );
end entity multiplier_signed;


architecture Logic_1 of multiplier_signed is

    -- /* ***************** Declaring Components ***************************** */
    component SignExtender32Bit is
        port(
            input_1 : IN std_logic ;
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component xor1Bit is
        port(
            input_1 : IN std_logic;
            input_2 : IN std_logic;
            output_1 : OUT std_logic
        );
    end component;

    component ander1Bit is
        port(
            input_1 : IN std_logic;
            input_2 : IN std_logic;
            output_1 : OUT std_logic
        );
    end component;

    component ander is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component ZeroExtenderAndShifter is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(63 downto 0)
        );
    end component;

    component ZeroOrSignExtenderAndShifter is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            input_3 : IN std_logic_vector(1 downto 0);
            output_1 : OUT std_logic_vector(63 downto 0)
        );
    end component;

    component adder_unsigned_64_bit is
        port(
            input_1 : IN std_logic_vector(63 downto 0);
            input_2 : IN std_logic_vector(63 downto 0);
            output_1 : OUT std_logic_vector(63 downto 0)
        );
    end component;

    component Complementer2s is
        port(
            input_1_comp : IN std_logic_vector(31 downto 0);
            output_1_comp : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component SignExtender64BitFrom32Bit is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(63 downto 0)
        );
    end component;
    
    component mux4to1_64Bit is
        port(
            input_1 : IN std_logic_vector(63 downto 0);
            input_2 : IN std_logic_vector(63 downto 0);
            input_3 : IN std_logic_vector(63 downto 0);
            input_4 : IN std_logic_vector(63 downto 0);
            sel : IN std_logic_vector(1 downto 0);
            output_1 : OUT std_logic_vector(63 downto 0)
        );
    end component;

    component mux2to1_32Bit is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            sel : IN std_logic;
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component  Bit2InputsTo2BitBus is
        port(
            input_1 : IN std_logic;
            input_2 : IN std_logic;
            output_1 : OUT std_logic_vector(1 downto 0)
        );
    end component;



    -- /* *****************signals ***************************** */

    

    signal signExtenderOutput_bit0, signExtenderOutput_bit1, signExtenderOutput_bit2, signExtenderOutput_bit3, signExtenderOutput_bit4, signExtenderOutput_bit5, signExtenderOutput_bit6, signExtenderOutput_bit7, signExtenderOutput_bit8, signExtenderOutput_bit9, signExtenderOutput_bit10, signExtenderOutput_bit11, signExtenderOutput_bit12, signExtenderOutput_bit13, signExtenderOutput_bit14, signExtenderOutput_bit15, signExtenderOutput_bit16, signExtenderOutput_bit17, signExtenderOutput_bit18, signExtenderOutput_bit19, signExtenderOutput_bit20, signExtenderOutput_bit21, signExtenderOutput_bit22, signExtenderOutput_bit23, signExtenderOutput_bit24, signExtenderOutput_bit25, signExtenderOutput_bit26, signExtenderOutput_bit27, signExtenderOutput_bit28, signExtenderOutput_bit29, signExtenderOutput_bit30, signExtenderOutput_bit31 : std_logic_vector(31 downto 0);

    signal anderOutput_bit0 , anderOutput_bit1 , anderOutput_bit2 , anderOutput_bit3 , anderOutput_bit4 , anderOutput_bit5 , anderOutput_bit6 , anderOutput_bit7 , anderOutput_bit8 , anderOutput_bit9 , anderOutput_bit10 , anderOutput_bit11 , anderOutput_bit12 , anderOutput_bit13 , anderOutput_bit14 , anderOutput_bit15 , anderOutput_bit16 , anderOutput_bit17 , anderOutput_bit18 , anderOutput_bit19 , anderOutput_bit20 , anderOutput_bit21 , anderOutput_bit22 , anderOutput_bit23 , anderOutput_bit24 , anderOutput_bit25 , anderOutput_bit26 , anderOutput_bit27 , anderOutput_bit28 , anderOutput_bit29 , anderOutput_bit30 , anderOutput_bit31 : std_logic_vector(31 downto 0); 
    
    signal zeroExtenderOutput_bit0 , zeroExtenderOutput_bit1 , zeroExtenderOutput_bit2 , zeroExtenderOutput_bit3 , zeroExtenderOutput_bit4 , zeroExtenderOutput_bit5 , zeroExtenderOutput_bit6 , zeroExtenderOutput_bit7 , zeroExtenderOutput_bit8 , zeroExtenderOutput_bit9 , zeroExtenderOutput_bit10 , zeroExtenderOutput_bit11 , zeroExtenderOutput_bit12 , zeroExtenderOutput_bit13 , zeroExtenderOutput_bit14 , zeroExtenderOutput_bit15 , zeroExtenderOutput_bit16 , zeroExtenderOutput_bit17 , zeroExtenderOutput_bit18 , zeroExtenderOutput_bit19 , zeroExtenderOutput_bit20 , zeroExtenderOutput_bit21 , zeroExtenderOutput_bit22 , zeroExtenderOutput_bit23 , zeroExtenderOutput_bit24 , zeroExtenderOutput_bit25 , zeroExtenderOutput_bit26 , zeroExtenderOutput_bit27 , zeroExtenderOutput_bit28 , zeroExtenderOutput_bit29 , zeroExtenderOutput_bit30 , zeroExtenderOutput_bit31 : std_logic_vector(63 downto 0);
    
    signal adder64bitOutput_0 , adder64bitOutput_1 , adder64bitOutput_2 , adder64bitOutput_3 , adder64bitOutput_4 , adder64bitOutput_5 , adder64bitOutput_6 , adder64bitOutput_7 , adder64bitOutput_8 , adder64bitOutput_9 , adder64bitOutput_10 , adder64bitOutput_11 , adder64bitOutput_12 , adder64bitOutput_13 , adder64bitOutput_14 , adder64bitOutput_15 , adder64bitOutput_16 , adder64bitOutput_17 , adder64bitOutput_18 , adder64bitOutput_19 , adder64bitOutput_20 , adder64bitOutput_21 , adder64bitOutput_22 , adder64bitOutput_23 , adder64bitOutput_24 , adder64bitOutput_25 , adder64bitOutput_26 , adder64bitOutput_27 , adder64bitOutput_28 , adder64bitOutput_29 , adder64bitOutput_30 , adder64bitOutput_31 : std_logic_vector(63 downto 0);
    
    signal complementerOutput_0 , complementerOutput_1 : std_logic_vector(31 downto 0);

    
    signal mux4to1Output : std_logic_vector(63 downto 0);

    signal mux2to1Output_0 , mux2to1Output_1 : std_logic_vector(31 downto 0);

    signal mux2to1SelectionBit : std_logic;

    signal bit2InputsTo2BitBusOutput : std_logic_vector(1 downto 0);
    
    --signal input_sign_extend_32_bit : std_logic_vector(31 downto 0) ;


    -- /* ***************** BIGIN IN ARCHITECTURE ***************************** */
    begin
        -- getting input_2 into input_sign_extend_32_bit  (step 0)

        --input_sign_extend_32_bit <= input_2;

        -- /* *****************Initializing the compenets ***************************** */

        --Check input_1 and input_2 are negative
        --if both are negative then
        Complemeter2s_0 : Complementer2s
            port map(
                input_1_comp => input_1,
                output_1_comp => complementerOutput_0
            );

        Complemeter2s_1 : Complementer2s
            port map(
                input_1_comp => input_2,
                output_1_comp => complementerOutput_1
            );

        -- select the input based on the sign of the input_1 and input_2
        AndGate_For2to1Mux_0 : ander1Bit
            port map(
                input_1 => input_1(31),
                input_2 => input_2(31),
                output_1 => mux2to1SelectionBit
            );

        Mux2to1_0 : mux2to1_32Bit
            port map(
                input_1 => input_1,
                input_2 => complementerOutput_0,
                sel => mux2to1SelectionBit,
                output_1 => mux2to1Output_0
            );

        Mux2to1_1 : mux2to1_32Bit
            port map(
                input_1 => input_2,
                input_2 => complementerOutput_1,
                sel => mux2to1SelectionBit,
                output_1 => mux2to1Output_1
            );

        -- 32 sign extenders for 32 bit input_2(step 1) --- for both positive inputs and negative inputs
        SignExtender32Bit_0 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(0),
                output_1 => signExtenderOutput_bit0
            );

        SignExtender32Bit_1 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(1),
                output_1 => signExtenderOutput_bit1
            );

        SignExtender32Bit_2 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(2),
                output_1 => signExtenderOutput_bit2
            );
        
        SignExtender32Bit_3 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(3),
                output_1 => signExtenderOutput_bit3
            );
        
        SignExtender32Bit_4 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(4),
                output_1 => signExtenderOutput_bit4
            );

        SignExtender32Bit_5 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(5),
                output_1 => signExtenderOutput_bit5
            );

        SignExtender32Bit_6 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(6),
                output_1 => signExtenderOutput_bit6
            );
        
        SignExtender32Bit_7 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(7),
                output_1 => signExtenderOutput_bit7
            );

        SignExtender32Bit_8 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(8),
                output_1 => signExtenderOutput_bit8
            );
        
        SignExtender32Bit_9 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(9),
                output_1 => signExtenderOutput_bit9
            );

        SignExtender32Bit_10 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(10),
                output_1 => signExtenderOutput_bit10
            );
        
        SignExtender32Bit_11 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(11),
                output_1 => signExtenderOutput_bit11
            );
        
        SignExtender32Bit_12 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(12),
                output_1 => signExtenderOutput_bit12
            );
        
        SignExtender32Bit_13 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(13),
                output_1 => signExtenderOutput_bit13
            );

        SignExtender32Bit_14 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(14),
                output_1 => signExtenderOutput_bit14
            );

        SignExtender32Bit_15 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(15),
                output_1 => signExtenderOutput_bit15
            );

        SignExtender32Bit_16 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(16),
                output_1 => signExtenderOutput_bit16
            );

        SignExtender32Bit_17 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(17),
                output_1 => signExtenderOutput_bit17
            );

        SignExtender32Bit_18 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(18),
                output_1 => signExtenderOutput_bit18
            );
        
        SignExtender32Bit_19 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(19),
                output_1 => signExtenderOutput_bit19
            );

        SignExtender32Bit_20 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(20),
                output_1 => signExtenderOutput_bit20
            );

        SignExtender32Bit_21 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(21),
                output_1 => signExtenderOutput_bit21
            );

        SignExtender32Bit_22 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(22),
                output_1 => signExtenderOutput_bit22
            );
        
        SignExtender32Bit_23 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(23),
                output_1 => signExtenderOutput_bit23
            );

        SignExtender32Bit_24 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(24),
                output_1 => signExtenderOutput_bit24
            );

        SignExtender32Bit_25 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(25),
                output_1 => signExtenderOutput_bit25
            );

        SignExtender32Bit_26 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(26),
                output_1 => signExtenderOutput_bit26
            );

        SignExtender32Bit_27 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(27),
                output_1 => signExtenderOutput_bit27
            );

        SignExtender32Bit_28 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(28),
                output_1 => signExtenderOutput_bit28
            );

        SignExtender32Bit_29 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(29),
                output_1 => signExtenderOutput_bit29
            );

        SignExtender32Bit_30 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(30),
                output_1 => signExtenderOutput_bit30
            );

        SignExtender32Bit_31 : SignExtender32Bit
            port map(
                input_1 => mux2to1Output_1(31),
                output_1 => signExtenderOutput_bit31
            );

        -- 32 and gates for 32 bit input_1 to create each immediate adding(yet to add) value(step 2)
        Ander_0 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit0,
                output_1 => anderOutput_bit0
            );

        Ander_1 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit1,
                output_1 => anderOutput_bit1
            );
        
        Ander_2 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit2,
                output_1 => anderOutput_bit2
            );

        Ander_3 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit3,
                output_1 => anderOutput_bit3
            );


        Ander_4 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit4,
                output_1 => anderOutput_bit4
            );

        Ander_5 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit5,
                output_1 => anderOutput_bit5
            );

        Ander_6 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit6,
                output_1 => anderOutput_bit6
            );

        Ander_7 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit7,
                output_1 => anderOutput_bit7
            );

        Ander_8 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit8,
                output_1 => anderOutput_bit8
            );

        Ander_9 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit9,
                output_1 => anderOutput_bit9
            );

        Ander_10 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit10,
                output_1 => anderOutput_bit10
            );

        Ander_11 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit11,
                output_1 => anderOutput_bit11
            );

        Ander_12 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit12,
                output_1 => anderOutput_bit12
            );

        Ander_13 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit13,
                output_1 => anderOutput_bit13
            );

        Ander_14 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit14,
                output_1 => anderOutput_bit14
            );
        
        Ander_15 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit15,
                output_1 => anderOutput_bit15
            );

        Ander_16 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit16,
                output_1 => anderOutput_bit16
            );

        Ander_17 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit17,
                output_1 => anderOutput_bit17
            );

        Ander_18 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit18,
                output_1 => anderOutput_bit18
            );

        Ander_19 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit19,
                output_1 => anderOutput_bit19
            );

        Ander_20 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit20,
                output_1 => anderOutput_bit20
            );

        Ander_21 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit21,
                output_1 => anderOutput_bit21
            );

        Ander_22 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit22,
                output_1 => anderOutput_bit22
            );

        Ander_23 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit23,
                output_1 => anderOutput_bit23
            );

        Ander_24 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit24,
                output_1 => anderOutput_bit24
            );

        Ander_25 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit25,
                output_1 => anderOutput_bit25
            );

        Ander_26 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit26,
                output_1 => anderOutput_bit26
            );

        Ander_27 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit27,
                output_1 => anderOutput_bit27
            );

        Ander_28 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit28,
                output_1 => anderOutput_bit28
            );

        Ander_29 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit29,
                output_1 => anderOutput_bit29
            );

        Ander_30 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit30,
                output_1 => anderOutput_bit30
            );

        Ander_31 : ander
            port map(
                input_1 => mux2to1Output_0,
                input_2 => signExtenderOutput_bit31,
                output_1 => anderOutput_bit31
            );


        --extending 32 bits of annedOutputs to 64 bits (step 3)
        --Shifting 32 bits to left by based on the position of the bit(step 4)

        --initially creating the bus
        Bit2InputsTo2BitBus_0 : Bit2InputsTo2BitBus
            port map(
                input_1 => input_1(31),
                input_2 => input_2(31),
                output_1 => bit2InputsTo2BitBusOutput
            );

        
        ZeroOrSignExtenderAndShifter_0 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit0,
                input_2 => "00000000000000000000000000000000",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit0
            );

        ZeroOrSignExtenderAndShifter_1 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit1,
                input_2 => "00000000000000000000000000000001",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit1
            );
        
        ZeroOrSignExtenderAndShifter_2 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit2,
                input_2 => "00000000000000000000000000000010",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit2
            );
        
        ZeroOrSignExtenderAndShifter_3 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit3,
                input_2 => "00000000000000000000000000000011",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit3
            );
        
        ZeroOrSignExtenderAndShifter_4 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit4,
                input_2 => "00000000000000000000000000000100",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit4
            );

        ZeroOrSignExtenderAndShifter_5 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit5,
                input_2 => "00000000000000000000000000000101",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit5
            );

        ZeroOrSignExtenderAndShifter_6 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit6,
                input_2 => "00000000000000000000000000000110",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit6
            );

        ZeroOrSignExtenderAndShifter_7 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit7,
                input_2 => "00000000000000000000000000000111",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit7
            );
        
        ZeroOrSignExtenderAndShifter_8 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit8,
                input_2 => "00000000000000000000000000001000",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit8
            );

        ZeroOrSignExtenderAndShifter_9 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit9,
                input_2 => "00000000000000000000000000001001",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit9
            );

        ZeroOrSignExtenderAndShifter_10 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit10,
                input_2 => "00000000000000000000000000001010",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit10
            );

        ZeroOrSignExtenderAndShifter_11 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit11,
                input_2 => "00000000000000000000000000001011",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit11
            );

        ZeroOrSignExtenderAndShifter_12 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit12,
                input_2 => "00000000000000000000000000001100",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit12
            );

        ZeroOrSignExtenderAndShifter_13 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit13,
                input_2 => "00000000000000000000000000001101",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit13
            );

        ZeroOrSignExtenderAndShifter_14 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit14,
                input_2 => "00000000000000000000000000001110",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit14
            );

        ZeroOrSignExtenderAndShifter_15 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit15,
                input_2 => "00000000000000000000000000001111",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit15
            );

        ZeroOrSignExtenderAndShifter_16 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit16,
                input_2 => "00000000000000000000000000010000",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit16
            );

        ZeroOrSignExtenderAndShifter_17 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit17,
                input_2 => "00000000000000000000000000010001",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit17
            );

        ZeroOrSignExtenderAndShifter_18 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit18,
                input_2 => "00000000000000000000000000010010",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit18
            );

        ZeroOrSignExtenderAndShifter_19 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit19,
                input_2 => "00000000000000000000000000010011",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit19
            );

        ZeroOrSignExtenderAndShifter_20 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit20,
                input_2 => "00000000000000000000000000010100",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit20
            );

        ZeroOrSignExtenderAndShifter_21 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit21,
                input_2 => "00000000000000000000000000010101",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit21
            );

        ZeroOrSignExtenderAndShifter_22 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit22,
                input_2 => "00000000000000000000000000010110",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit22
            );

        ZeroOrSignExtenderAndShifter_23 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit23,
                input_2 => "00000000000000000000000000010111",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit23
            );

        ZeroOrSignExtenderAndShifter_24 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit24,
                input_2 => "00000000000000000000000000011000",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit24
            );

        ZeroOrSignExtenderAndShifter_25 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit25,
                input_2 => "00000000000000000000000000011001",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit25
            );

        ZeroOrSignExtenderAndShifter_26 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit26,
                input_2 => "00000000000000000000000000011010",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit26
            );

        ZeroOrSignExtenderAndShifter_27 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit27,
                input_2 => "00000000000000000000000000011011",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit27
            );

        ZeroOrSignExtenderAndShifter_28 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit28,
                input_2 => "00000000000000000000000000011100",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit28
            );

        ZeroOrSignExtenderAndShifter_29 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit29,
                input_2 => "00000000000000000000000000011101",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit29
            );

        ZeroOrSignExtenderAndShifter_30 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit30,
                input_2 => "00000000000000000000000000011110",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit30
            );

        ZeroOrSignExtenderAndShifter_31 : ZeroOrSignExtenderAndShifter
            port map(
                input_1 => anderOutput_bit31,
                input_2 => "00000000000000000000000000011111",
                input_3 => bit2InputsTo2BitBusOutput,
                output_1 => zeroExtenderOutput_bit31
            );

        --Adding all the 64 bit outputs of zeroExtenderAnd Shifter in bitwise order (step 5)

        Adder_unsigned_64_bit_0_and_1 : adder_unsigned_64_bit
            port map(
                input_1 => zeroExtenderOutput_bit0,
                input_2 => zeroExtenderOutput_bit1,
                output_1 => adder64bitOutput_0
            );
        
        Adder_unsigned_64_Immediate_0_and_bit_2 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_0,
                input_2 => zeroExtenderOutput_bit2,
                output_1 => adder64bitOutput_1
            );

        Adder_unsigned_64_Immediate_1_and_bit_3 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_1,
                input_2 => zeroExtenderOutput_bit3,
                output_1 => adder64bitOutput_2
            );

        Adder_unsigned_64_Immediate_2_and_bit_4 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_2,
                input_2 => zeroExtenderOutput_bit4,
                output_1 => adder64bitOutput_3
            );

        Adder_unsigned_64_Immediate_3_and_bit_5 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_3,
                input_2 => zeroExtenderOutput_bit5,
                output_1 => adder64bitOutput_4
            );

        Adder_unsigned_64_Immediate_4_and_bit_6 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_4,
                input_2 => zeroExtenderOutput_bit6,
                output_1 => adder64bitOutput_5
            );

        Adder_unsigned_64_Immediate_5_and_bit_7 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_5,
                input_2 => zeroExtenderOutput_bit7,
                output_1 => adder64bitOutput_6
            );

        Adder_unsigned_64_Immediate_6_and_bit_8 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_6,
                input_2 => zeroExtenderOutput_bit8,
                output_1 => adder64bitOutput_7
            );

        Adder_unsigned_64_Immediate_7_and_bit_9 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_7,
                input_2 => zeroExtenderOutput_bit9,
                output_1 => adder64bitOutput_8
            );

        Adder_unsigned_64_Immediate_8_and_bit_10 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_8,
                input_2 => zeroExtenderOutput_bit10,
                output_1 => adder64bitOutput_9
            );

        Adder_unsigned_64_Immediate_9_and_bit_11 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_9,
                input_2 => zeroExtenderOutput_bit11,
                output_1 => adder64bitOutput_10
            );

        Adder_unsigned_64_Immediate_10_and_bit_12 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_10,
                input_2 => zeroExtenderOutput_bit12,
                output_1 => adder64bitOutput_11
            );

        Adder_unsigned_64_Immediate_11_and_bit_13 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_11,
                input_2 => zeroExtenderOutput_bit13,
                output_1 => adder64bitOutput_12
            );


        Adder_unsigned_64_Immediate_12_and_bit_14 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_12,
                input_2 => zeroExtenderOutput_bit14,
                output_1 => adder64bitOutput_13
            );

        Adder_unsigned_64_Immediate_13_and_bit_15 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_13,
                input_2 => zeroExtenderOutput_bit15,
                output_1 => adder64bitOutput_14
            );

        Adder_unsigned_64_Immediate_14_and_bit_16 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_14,
                input_2 => zeroExtenderOutput_bit16,
                output_1 => adder64bitOutput_15
            );

        Adder_unsigned_64_Immediate_15_and_bit_17 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_15,
                input_2 => zeroExtenderOutput_bit17,
                output_1 => adder64bitOutput_16
            );

        Adder_unsigned_64_Immediate_16_and_bit_18 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_16,
                input_2 => zeroExtenderOutput_bit18,
                output_1 => adder64bitOutput_17
            );

        Adder_unsigned_64_Immediate_17_and_bit_19 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_17,
                input_2 => zeroExtenderOutput_bit19,
                output_1 => adder64bitOutput_18
            );

        Adder_unsigned_64_Immediate_18_and_bit_20 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_18,
                input_2 => zeroExtenderOutput_bit20,
                output_1 => adder64bitOutput_19
            );

        Adder_unsigned_64_Immediate_19_and_bit_21 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_19,
                input_2 => zeroExtenderOutput_bit21,
                output_1 => adder64bitOutput_20
            );

        Adder_unsigned_64_Immediate_20_and_bit_22 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_20,
                input_2 => zeroExtenderOutput_bit22,
                output_1 => adder64bitOutput_21
            );

        Adder_unsigned_64_Immediate_21_and_bit_23 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_21,
                input_2 => zeroExtenderOutput_bit23,
                output_1 => adder64bitOutput_22
            );

        Adder_unsigned_64_Immediate_22_and_bit_24 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_22,
                input_2 => zeroExtenderOutput_bit24,
                output_1 => adder64bitOutput_23
            );

        Adder_unsigned_64_Immediate_23_and_bit_25 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_23,
                input_2 => zeroExtenderOutput_bit25,
                output_1 => adder64bitOutput_24
            );

        Adder_unsigned_64_Immediate_24_and_bit_26 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_24,
                input_2 => zeroExtenderOutput_bit26,
                output_1 => adder64bitOutput_25
            );

        Adder_unsigned_64_Immediate_25_and_bit_27 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_25,
                input_2 => zeroExtenderOutput_bit27,
                output_1 => adder64bitOutput_26
            );

        Adder_unsigned_64_Immediate_26_and_bit_28 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_26,
                input_2 => zeroExtenderOutput_bit28,
                output_1 => adder64bitOutput_27
            );

        Adder_unsigned_64_Immediate_27_and_bit_29 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_27,
                input_2 => zeroExtenderOutput_bit29,
                output_1 => adder64bitOutput_28
            );
        
        Adder_unsigned_64_Immediate_28_and_bit_30 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_28,
                input_2 => zeroExtenderOutput_bit30,
                output_1 => adder64bitOutput_29
            );

        Adder_unsigned_64_Immediate_29_and_bit_31 : adder_unsigned_64_bit
            port map(
                input_1 => adder64bitOutput_29,
                input_2 => zeroExtenderOutput_bit31,
                output_1 => adder64bitOutput_30
            );


        -- /* ***************** OUTPUT ASSIGNMENT ***************************** */
        output_1 <= adder64bitOutput_30(31 downto 0);
        output_2 <= adder64bitOutput_30(63 downto 32);
        
        -- process(input_1,input_2)
        --     begin
        --         output_1 <= adder64bitOutput_30(31 downto 0);
        -- end process;

end architecture Logic_1;