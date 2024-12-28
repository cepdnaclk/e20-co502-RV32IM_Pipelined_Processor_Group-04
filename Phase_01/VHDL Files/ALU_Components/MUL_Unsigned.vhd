library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multiplier_unsigned is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        output_1 : OUT std_logic_vector(31 downto 0);
        output_2 : OUT std_logic_vector(31 downto 0)
    );
end entity multiplier_unsigned;


architecture Logic_1 of multiplier_unsigned is

    -- /* ***************** Declaring Components ***************************** */
    component SignExtender32Bit is
        port(
            input_1 : IN std_logic ;
            output_1 : OUT std_logic_vector(31 downto 0)
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

    component adder_unsigned_64_bit is
        port(
            input_1 : IN std_logic_vector(63 downto 0);
            input_2 : IN std_logic_vector(63 downto 0);
            output_1 : OUT std_logic_vector(63 downto 0)
        );
    end component;

    -- /* *****************signals ***************************** */

    -- signal signExtenderOutput_bit0 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit1 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit2 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit3 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit4 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit5 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit6 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit7 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit8 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit9 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit10 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit11 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit12 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit13 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit14 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit15 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit16 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit17 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit18 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit19 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit20 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit21 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit22 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit23 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit24 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit25 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit26 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit27 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit28 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit29 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit30 : std_logic_vector(63 downto 0);
    -- signal signExtenderOutput_bit31 : std_logic_vector(63 downto 0);

    signal signExtenderOutput_bit0, signExtenderOutput_bit1, signExtenderOutput_bit2, signExtenderOutput_bit3, signExtenderOutput_bit4, signExtenderOutput_bit5, signExtenderOutput_bit6, signExtenderOutput_bit7, signExtenderOutput_bit8, signExtenderOutput_bit9, signExtenderOutput_bit10, signExtenderOutput_bit11, signExtenderOutput_bit12, signExtenderOutput_bit13, signExtenderOutput_bit14, signExtenderOutput_bit15, signExtenderOutput_bit16, signExtenderOutput_bit17, signExtenderOutput_bit18, signExtenderOutput_bit19, signExtenderOutput_bit20, signExtenderOutput_bit21, signExtenderOutput_bit22, signExtenderOutput_bit23, signExtenderOutput_bit24, signExtenderOutput_bit25, signExtenderOutput_bit26, signExtenderOutput_bit27, signExtenderOutput_bit28, signExtenderOutput_bit29, signExtenderOutput_bit30, signExtenderOutput_bit31 : std_logic_vector(31 downto 0);

    signal anderOutput_bit0 , anderOutput_bit1 , anderOutput_bit2 , anderOutput_bit3 , anderOutput_bit4 , anderOutput_bit5 , anderOutput_bit6 , anderOutput_bit7 , anderOutput_bit8 , anderOutput_bit9 , anderOutput_bit10 , anderOutput_bit11 , anderOutput_bit12 , anderOutput_bit13 , anderOutput_bit14 , anderOutput_bit15 , anderOutput_bit16 , anderOutput_bit17 , anderOutput_bit18 , anderOutput_bit19 , anderOutput_bit20 , anderOutput_bit21 , anderOutput_bit22 , anderOutput_bit23 , anderOutput_bit24 , anderOutput_bit25 , anderOutput_bit26 , anderOutput_bit27 , anderOutput_bit28 , anderOutput_bit29 , anderOutput_bit30 , anderOutput_bit31 : std_logic_vector(31 downto 0); 
    
    signal zeroExtenderOutput_bit0 , zeroExtenderOutput_bit1 , zeroExtenderOutput_bit2 , zeroExtenderOutput_bit3 , zeroExtenderOutput_bit4 , zeroExtenderOutput_bit5 , zeroExtenderOutput_bit6 , zeroExtenderOutput_bit7 , zeroExtenderOutput_bit8 , zeroExtenderOutput_bit9 , zeroExtenderOutput_bit10 , zeroExtenderOutput_bit11 , zeroExtenderOutput_bit12 , zeroExtenderOutput_bit13 , zeroExtenderOutput_bit14 , zeroExtenderOutput_bit15 , zeroExtenderOutput_bit16 , zeroExtenderOutput_bit17 , zeroExtenderOutput_bit18 , zeroExtenderOutput_bit19 , zeroExtenderOutput_bit20 , zeroExtenderOutput_bit21 , zeroExtenderOutput_bit22 , zeroExtenderOutput_bit23 , zeroExtenderOutput_bit24 , zeroExtenderOutput_bit25 , zeroExtenderOutput_bit26 , zeroExtenderOutput_bit27 , zeroExtenderOutput_bit28 , zeroExtenderOutput_bit29 , zeroExtenderOutput_bit30 , zeroExtenderOutput_bit31 : std_logic_vector(63 downto 0);
    
    signal adder64bitOutput_0 , adder64bitOutput_1 , adder64bitOutput_2 , adder64bitOutput_3 , adder64bitOutput_4 , adder64bitOutput_5 , adder64bitOutput_6 , adder64bitOutput_7 , adder64bitOutput_8 , adder64bitOutput_9 , adder64bitOutput_10 , adder64bitOutput_11 , adder64bitOutput_12 , adder64bitOutput_13 , adder64bitOutput_14 , adder64bitOutput_15 , adder64bitOutput_16 , adder64bitOutput_17 , adder64bitOutput_18 , adder64bitOutput_19 , adder64bitOutput_20 , adder64bitOutput_21 , adder64bitOutput_22 , adder64bitOutput_23 , adder64bitOutput_24 , adder64bitOutput_25 , adder64bitOutput_26 , adder64bitOutput_27 , adder64bitOutput_28 , adder64bitOutput_29 , adder64bitOutput_30 , adder64bitOutput_31 : std_logic_vector(63 downto 0);

    --signal input_sign_extend_32_bit : std_logic_vector(31 downto 0) ;


    -- /* ***************** BIGIN IN ARCHITECTURE ***************************** */
    begin
        -- getting input_2 into input_sign_extend_32_bit  (step 0)

        --input_sign_extend_32_bit <= input_2;

        -- /* *****************Initializing the compenets ***************************** */

        -- 32 sign extenders for 32 bit input_1(step 1)
        SignExtender32Bit_0 : SignExtender32Bit
            port map(
                input_1 => input_2(0),
                output_1 => signExtenderOutput_bit0
            );

        SignExtender32Bit_1 : SignExtender32Bit
            port map(
                input_1 => input_2(1),
                output_1 => signExtenderOutput_bit1
            );

        SignExtender32Bit_2 : SignExtender32Bit
            port map(
                input_1 => input_2(2),
                output_1 => signExtenderOutput_bit2
            );
        
        SignExtender32Bit_3 : SignExtender32Bit
            port map(
                input_1 => input_2(3),
                output_1 => signExtenderOutput_bit3
            );
        
        SignExtender32Bit_4 : SignExtender32Bit
            port map(
                input_1 => input_2(4),
                output_1 => signExtenderOutput_bit4
            );

        SignExtender32Bit_5 : SignExtender32Bit
            port map(
                input_1 => input_2(5),
                output_1 => signExtenderOutput_bit5
            );

        SignExtender32Bit_6 : SignExtender32Bit
            port map(
                input_1 => input_2(6),
                output_1 => signExtenderOutput_bit6
            );
        
        SignExtender32Bit_7 : SignExtender32Bit
            port map(
                input_1 => input_2(7),
                output_1 => signExtenderOutput_bit7
            );

        SignExtender32Bit_8 : SignExtender32Bit
            port map(
                input_1 => input_2(8),
                output_1 => signExtenderOutput_bit8
            );
        
        SignExtender32Bit_9 : SignExtender32Bit
            port map(
                input_1 => input_2(9),
                output_1 => signExtenderOutput_bit9
            );

        SignExtender32Bit_10 : SignExtender32Bit
            port map(
                input_1 => input_2(10),
                output_1 => signExtenderOutput_bit10
            );
        
        SignExtender32Bit_11 : SignExtender32Bit
            port map(
                input_1 => input_2(11),
                output_1 => signExtenderOutput_bit11
            );
        
        SignExtender32Bit_12 : SignExtender32Bit
            port map(
                input_1 => input_2(12),
                output_1 => signExtenderOutput_bit12
            );
        
        SignExtender32Bit_13 : SignExtender32Bit
            port map(
                input_1 => input_2(13),
                output_1 => signExtenderOutput_bit13
            );

        SignExtender32Bit_14 : SignExtender32Bit
            port map(
                input_1 => input_2(14),
                output_1 => signExtenderOutput_bit14
            );

        SignExtender32Bit_15 : SignExtender32Bit
            port map(
                input_1 => input_2(15),
                output_1 => signExtenderOutput_bit15
            );

        SignExtender32Bit_16 : SignExtender32Bit
            port map(
                input_1 => input_2(16),
                output_1 => signExtenderOutput_bit16
            );

        SignExtender32Bit_17 : SignExtender32Bit
            port map(
                input_1 => input_2(17),
                output_1 => signExtenderOutput_bit17
            );

        SignExtender32Bit_18 : SignExtender32Bit
            port map(
                input_1 => input_2(18),
                output_1 => signExtenderOutput_bit18
            );
        
        SignExtender32Bit_19 : SignExtender32Bit
            port map(
                input_1 => input_2(19),
                output_1 => signExtenderOutput_bit19
            );

        SignExtender32Bit_20 : SignExtender32Bit
            port map(
                input_1 => input_2(20),
                output_1 => signExtenderOutput_bit20
            );

        SignExtender32Bit_21 : SignExtender32Bit
            port map(
                input_1 => input_2(21),
                output_1 => signExtenderOutput_bit21
            );

        SignExtender32Bit_22 : SignExtender32Bit
            port map(
                input_1 => input_2(22),
                output_1 => signExtenderOutput_bit22
            );
        
        SignExtender32Bit_23 : SignExtender32Bit
            port map(
                input_1 => input_2(23),
                output_1 => signExtenderOutput_bit23
            );

        SignExtender32Bit_24 : SignExtender32Bit
            port map(
                input_1 => input_2(24),
                output_1 => signExtenderOutput_bit24
            );

        SignExtender32Bit_25 : SignExtender32Bit
            port map(
                input_1 => input_2(25),
                output_1 => signExtenderOutput_bit25
            );

        SignExtender32Bit_26 : SignExtender32Bit
            port map(
                input_1 => input_2(26),
                output_1 => signExtenderOutput_bit26
            );

        SignExtender32Bit_27 : SignExtender32Bit
            port map(
                input_1 => input_2(27),
                output_1 => signExtenderOutput_bit27
            );

        SignExtender32Bit_28 : SignExtender32Bit
            port map(
                input_1 => input_2(28),
                output_1 => signExtenderOutput_bit28
            );

        SignExtender32Bit_29 : SignExtender32Bit
            port map(
                input_1 => input_2(29),
                output_1 => signExtenderOutput_bit29
            );

        SignExtender32Bit_30 : SignExtender32Bit
            port map(
                input_1 => input_2(30),
                output_1 => signExtenderOutput_bit30
            );

        SignExtender32Bit_31 : SignExtender32Bit
            port map(
                input_1 => input_2(31),
                output_1 => signExtenderOutput_bit31
            );

        -- 32 and gates for 32 bit input_1 to create each immediate adding(yet to add) value(step 2)
        Ander_0 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit0,
                output_1 => anderOutput_bit0
            );

        Ander_1 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit1,
                output_1 => anderOutput_bit1
            );
        
        Ander_2 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit2,
                output_1 => anderOutput_bit2
            );

        Ander_3 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit3,
                output_1 => anderOutput_bit3
            );


        Ander_4 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit4,
                output_1 => anderOutput_bit4
            );

        Ander_5 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit5,
                output_1 => anderOutput_bit5
            );

        Ander_6 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit6,
                output_1 => anderOutput_bit6
            );

        Ander_7 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit7,
                output_1 => anderOutput_bit7
            );

        Ander_8 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit8,
                output_1 => anderOutput_bit8
            );

        Ander_9 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit9,
                output_1 => anderOutput_bit9
            );

        Ander_10 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit10,
                output_1 => anderOutput_bit10
            );

        Ander_11 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit11,
                output_1 => anderOutput_bit11
            );

        Ander_12 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit12,
                output_1 => anderOutput_bit12
            );

        Ander_13 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit13,
                output_1 => anderOutput_bit13
            );

        Ander_14 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit14,
                output_1 => anderOutput_bit14
            );
        
        Ander_15 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit15,
                output_1 => anderOutput_bit15
            );

        Ander_16 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit16,
                output_1 => anderOutput_bit16
            );

        Ander_17 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit17,
                output_1 => anderOutput_bit17
            );

        Ander_18 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit18,
                output_1 => anderOutput_bit18
            );

        Ander_19 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit19,
                output_1 => anderOutput_bit19
            );

        Ander_20 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit20,
                output_1 => anderOutput_bit20
            );

        Ander_21 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit21,
                output_1 => anderOutput_bit21
            );

        Ander_22 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit22,
                output_1 => anderOutput_bit22
            );

        Ander_23 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit23,
                output_1 => anderOutput_bit23
            );

        Ander_24 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit24,
                output_1 => anderOutput_bit24
            );

        Ander_25 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit25,
                output_1 => anderOutput_bit25
            );

        Ander_26 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit26,
                output_1 => anderOutput_bit26
            );

        Ander_27 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit27,
                output_1 => anderOutput_bit27
            );

        Ander_28 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit28,
                output_1 => anderOutput_bit28
            );

        Ander_29 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit29,
                output_1 => anderOutput_bit29
            );

        Ander_30 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit30,
                output_1 => anderOutput_bit30
            );

        Ander_31 : ander
            port map(
                input_1 => input_1,
                input_2 => signExtenderOutput_bit31,
                output_1 => anderOutput_bit31
            );


        --extending 32 bits of annedOutputs to 64 bits (step 3)
        --Shifting 32 bits to left by based on the position of the bit(step 4)
        ZeroExtenderAndShifter_0 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit0,
                input_2 => "00000000000000000000000000000000",
                output_1 => zeroExtenderOutput_bit0
            );

        ZeroExtenderAndShifter_1 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit1,
                input_2 => "00000000000000000000000000000001",
                output_1 => zeroExtenderOutput_bit1
            );
        
        ZeroExtenderAndShifter_2 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit2,
                input_2 => "00000000000000000000000000000010",
                output_1 => zeroExtenderOutput_bit2
            );
        
        ZeroExtenderAndShifter_3 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit3,
                input_2 => "00000000000000000000000000000011",
                output_1 => zeroExtenderOutput_bit3
            );
        
        ZeroExtenderAndShifter_4 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit4,
                input_2 => "00000000000000000000000000000100",
                output_1 => zeroExtenderOutput_bit4
            );

        ZeroExtenderAndShifter_5 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit5,
                input_2 => "00000000000000000000000000000101",
                output_1 => zeroExtenderOutput_bit5
            );

        ZeroExtenderAndShifter_6 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit6,
                input_2 => "00000000000000000000000000000110",
                output_1 => zeroExtenderOutput_bit6
            );

        ZeroExtenderAndShifter_7 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit7,
                input_2 => "00000000000000000000000000000111",
                output_1 => zeroExtenderOutput_bit7
            );
        
        ZeroExtenderAndShifter_8 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit8,
                input_2 => "00000000000000000000000000001000",
                output_1 => zeroExtenderOutput_bit8
            );

        ZeroExtenderAndShifter_9 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit9,
                input_2 => "00000000000000000000000000001001",
                output_1 => zeroExtenderOutput_bit9
            );

        ZeroExtenderAndShifter_10 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit10,
                input_2 => "00000000000000000000000000001010",
                output_1 => zeroExtenderOutput_bit10
            );

        ZeroExtenderAndShifter_11 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit11,
                input_2 => "00000000000000000000000000001011",
                output_1 => zeroExtenderOutput_bit11
            );

        ZeroExtenderAndShifter_12 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit12,
                input_2 => "00000000000000000000000000001100",
                output_1 => zeroExtenderOutput_bit12
            );

        ZeroExtenderAndShifter_13 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit13,
                input_2 => "00000000000000000000000000001101",
                output_1 => zeroExtenderOutput_bit13
            );

        ZeroExtenderAndShifter_14 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit14,
                input_2 => "00000000000000000000000000001110",
                output_1 => zeroExtenderOutput_bit14
            );

        ZeroExtenderAndShifter_15 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit15,
                input_2 => "00000000000000000000000000001111",
                output_1 => zeroExtenderOutput_bit15
            );

        ZeroExtenderAndShifter_16 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit16,
                input_2 => "00000000000000000000000000010000",
                output_1 => zeroExtenderOutput_bit16
            );

        ZeroExtenderAndShifter_17 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit17,
                input_2 => "00000000000000000000000000010001",
                output_1 => zeroExtenderOutput_bit17
            );

        ZeroExtenderAndShifter_18 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit18,
                input_2 => "00000000000000000000000000010010",
                output_1 => zeroExtenderOutput_bit18
            );

        ZeroExtenderAndShifter_19 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit19,
                input_2 => "00000000000000000000000000010011",
                output_1 => zeroExtenderOutput_bit19
            );

        ZeroExtenderAndShifter_20 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit20,
                input_2 => "00000000000000000000000000010100",
                output_1 => zeroExtenderOutput_bit20
            );

        ZeroExtenderAndShifter_21 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit21,
                input_2 => "00000000000000000000000000010101",
                output_1 => zeroExtenderOutput_bit21
            );

        ZeroExtenderAndShifter_22 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit22,
                input_2 => "00000000000000000000000000010110",
                output_1 => zeroExtenderOutput_bit22
            );

        ZeroExtenderAndShifter_23 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit23,
                input_2 => "00000000000000000000000000010111",
                output_1 => zeroExtenderOutput_bit23
            );

        ZeroExtenderAndShifter_24 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit24,
                input_2 => "00000000000000000000000000011000",
                output_1 => zeroExtenderOutput_bit24
            );

        ZeroExtenderAndShifter_25 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit25,
                input_2 => "00000000000000000000000000011001",
                output_1 => zeroExtenderOutput_bit25
            );

        ZeroExtenderAndShifter_26 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit26,
                input_2 => "00000000000000000000000000011010",
                output_1 => zeroExtenderOutput_bit26
            );

        ZeroExtenderAndShifter_27 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit27,
                input_2 => "00000000000000000000000000011011",
                output_1 => zeroExtenderOutput_bit27
            );

        ZeroExtenderAndShifter_28 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit28,
                input_2 => "00000000000000000000000000011100",
                output_1 => zeroExtenderOutput_bit28
            );

        ZeroExtenderAndShifter_29 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit29,
                input_2 => "00000000000000000000000000011101",
                output_1 => zeroExtenderOutput_bit29
            );

        ZeroExtenderAndShifter_30 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit30,
                input_2 => "00000000000000000000000000011110",
                output_1 => zeroExtenderOutput_bit30
            );

        ZeroExtenderAndShifter_31 : ZeroExtenderAndShifter
            port map(
                input_1 => anderOutput_bit31,
                input_2 => "00000000000000000000000000011111",
                output_1 => zeroExtenderOutput_bit31
            );

        --Adding all the 64 bit outputs of zeroExtenderAndShifter in bitwise order (step 5)

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