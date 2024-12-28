library ieee;
use ieee.std_logic_1164.all;

entity MUL_Signed_Unsigned is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        output_1 : OUT std_logic_vector(31 downto 0);
        output_2 : OUT std_logic_vector(31 downto 0)
    );
end entity MUL_Signed_Unsigned;



architecture Logic_1 of MUL_Signed_Unsigned is
    
    -- /* ***************** Declaring Components ***************************** */
    component SignExtender64Bit is
        port(
            input_1 : IN std_logic ;
            output_1 : OUT std_logic_vector(63 downto 0)
        );
    end component;

    component ZeroExtender64BitFrom32Bit is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(63 downto 0)
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


    -- /* ***************** Declaring Signals ***************************** */
    signal extended_input_1 ,extended_input_2 : std_logic_vector(63 downto 0);
    
    --32 signals for each bit of input_2
    signal signExtender64Bit_output_0 , signExtender64Bit_output_1 , signExtender64Bit_output_2 , signExtender64Bit_output_3 , signExtender64Bit_output_4 , signExtender64Bit_output_5 , signExtender64Bit_output_6 , signExtender64Bit_output_7 , signExtender64Bit_output_8 , signExtender64Bit_output_9 , signExtender64Bit_output_10 , signExtender64Bit_output_11 , signExtender64Bit_output_12 , signExtender64Bit_output_13 , signExtender64Bit_output_14 , signExtender64Bit_output_15 , signExtender64Bit_output_16 , signExtender64Bit_output_17 , signExtender64Bit_output_18 , signExtender64Bit_output_19 , signExtender64Bit_output_20 , signExtender64Bit_output_21 , signExtender64Bit_output_22 , signExtender64Bit_output_23 , signExtender64Bit_output_24 , signExtender64Bit_output_25 , signExtender64Bit_output_26 , signExtender64Bit_output_27 , signExtender64Bit_output_28 , signExtender64Bit_output_29 , signExtender64Bit_output_30 , signExtender64Bit_output_31 : std_logic_vector(63 downto 0);

    -- 64 signals for each output bit
    signal and1Bit_output_0 , xor1Bit_output_1 , xor1Bit_output_2 , xor1Bit_output_3 , xor1Bit_output_4 , xor1Bit_output_5 , xor1Bit_output_6 , xor1Bit_output_7 , xor1Bit_output_8 , xor1Bit_output_9 , xor1Bit_output_10 , xor1Bit_output_11 , xor1Bit_output_12 , xor1Bit_output_13 , xor1Bit_output_14 , xor1Bit_output_15 , xor1Bit_output_16 , xor1Bit_output_17 , xor1Bit_output_18 , xor1Bit_output_19 , xor1Bit_output_20 , xor1Bit_output_21 , xor1Bit_output_22 , xor1Bit_output_23 , xor1Bit_output_24 , xor1Bit_output_25 , xor1Bit_output_26 , xor1Bit_output_27 , xor1Bit_output_28 , xor1Bit_output_29 , xor1Bit_output_30 , xor1Bit_output_31 , xor1Bit_output_32 , xor1Bit_output_33 , xor1Bit_output_34 , xor1Bit_output_35 , xor1Bit_output_36 , xor1Bit_output_37 , xor1Bit_output_38 , xor1Bit_output_39 , xor1Bit_output_40 , xor1Bit_output_41 , xor1Bit_output_42 , xor1Bit_output_43 , xor1Bit_output_44 , xor1Bit_output_45 , xor1Bit_output_46 , xor1Bit_output_47 , xor1Bit_output_48 , xor1Bit_output_49 , xor1Bit_output_50 , xor1Bit_output_51 , xor1Bit_output_52 , xor1Bit_output_53 , xor1Bit_output_54 , xor1Bit_output_55 , xor1Bit_output_56 , xor1Bit_output_57 , xor1Bit_output_58 , xor1Bit_output_59 , xor1Bit_output_60 , xor1Bit_output_61 , xor1Bit_output_62 , xor1Bit_output_63 : std_logic;

    --signal to get the output 
    signal outputtingSignal : std_logic_vector(63 downto 0);

    begin
    -- /* ***************** Instantiating Components ***************************** */

    --Signextender for input_1
    SignExtender64BitFrom32Bit_0_input_1 : SignExtender64BitFrom32Bit
        port map(
            input_1 => input_1,
            output_1 => extended_input_1
        );

    --ZeroExtend input_2
    ZeroExtender64BitFrom32Bit_0_input_1 : ZeroExtender64BitFrom32Bit
        port map(
            input_1 => input_2,
            output_1 => extended_input_2
        );


    --sign extending each bit of input_2
    -- SignExtender64Bit_0_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(0),
    --         output_1 => signExtender64Bit_output_0
    --     );

    -- SignExtender64Bit_1_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(1),
    --         output_1 => signExtender64Bit_output_1
    --     );

    -- SignExtender64Bit_2_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(2),
    --         output_1 => signExtender64Bit_output_2
    --     );

    -- SignExtender64Bit_3_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(3),
    --         output_1 => signExtender64Bit_output_3
    --     );

    -- SignExtender64Bit_4_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(4),
    --         output_1 => signExtender64Bit_output_4
    --     );
    
    -- SignExtender64Bit_5_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(5),
    --         output_1 => signExtender64Bit_output_5
    --     );

    -- SignExtender64Bit_6_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(6),
    --         output_1 => signExtender64Bit_output_6
    --     );
        
    -- SignExtender64Bit_7_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(7),
    --         output_1 => signExtender64Bit_output_7
    --     );

    -- SignExtender64Bit_8_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(8),
    --         output_1 => signExtender64Bit_output_8
    --     );

    -- SignExtender64Bit_9_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(9),
    --         output_1 => signExtender64Bit_output_9
    --     );

    -- SignExtender64Bit_10_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(10),
    --         output_1 => signExtender64Bit_output_10
    --     );

    -- SignExtender64Bit_11_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(11),
    --         output_1 => signExtender64Bit_output_11
    --     );

    -- SignExtender64Bit_12_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(12),
    --         output_1 => signExtender64Bit_output_12
    --     );

    -- SignExtender64Bit_13_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(13),
    --         output_1 => signExtender64Bit_output_13
    --     );

    -- SignExtender64Bit_14_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(14),
    --         output_1 => signExtender64Bit_output_14
    --     );
    
    -- SignExtender64Bit_15_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(15),
    --         output_1 => signExtender64Bit_output_15
    --     );

    -- SignExtender64Bit_16_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(16),
    --         output_1 => signExtender64Bit_output_16
    --     );

    -- SignExtender64Bit_17_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(17),
    --         output_1 => signExtender64Bit_output_17
    --     );

    -- SignExtender64Bit_18_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(18),
    --         output_1 => signExtender64Bit_output_18
    --     );

    -- SignExtender64Bit_19_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(19),
    --         output_1 => signExtender64Bit_output_19
    --     );

    -- SignExtender64Bit_20_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(20),
    --         output_1 => signExtender64Bit_output_20
    --     );

    -- SignExtender64Bit_21_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(21),
    --         output_1 => signExtender64Bit_output_21
    --     );

    -- SignExtender64Bit_22_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(22),
    --         output_1 => signExtender64Bit_output_22
    --     );

    -- SignExtender64Bit_23_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(23),
    --         output_1 => signExtender64Bit_output_23
    --     );

    -- SignExtender64Bit_24_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(24),
    --         output_1 => signExtender64Bit_output_24
    --     );

    -- SignExtender64Bit_25_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(25),
    --         output_1 => signExtender64Bit_output_25
    --     );

    -- SignExtender64Bit_26_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(26),
    --         output_1 => signExtender64Bit_output_26
    --     );

    -- SignExtender64Bit_27_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(27),
    --         output_1 => signExtender64Bit_output_27
    --     );

    -- SignExtender64Bit_28_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(28),
    --         output_1 => signExtender64Bit_output_28
    --     );

    -- SignExtender64Bit_29_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(29),
    --         output_1 => signExtender64Bit_output_29
    --     );

    -- SignExtender64Bit_30_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(30),
    --         output_1 => signExtender64Bit_output_30
    --     );

    -- SignExtender64Bit_31_input_2 : SignExtender64Bit
    --     port map(
    --         input_1 => input_2(31),
    --         output_1 => signExtender64Bit_output_31
    --     );

    --Anding the lsb bits of input_1 and input_2 for output's lsb bit
    Ander1Bit_0 : ander1Bit
        port map(
            input_1 => extended_input_1(0),
            input_2 => extended_input_2(0),
            output_1 => outputtingSignal(0)
            --output_1 => and1Bit_output_0
        );

    

    --XORing each bit of input_2's with input_1's bits
    --Xoring to 63 bits resulting 63 xor gates
    Xor1Bit_1 : xor1Bit
        port map(
            input_1 => extended_input_1(1),
            input_2 => extended_input_2(1),
            output_1 => outputtingSignal(1)
        );

    Xor1Bit_2 : xor1Bit
        port map(
            input_1 => extended_input_1(2),
            input_2 => extended_input_2(2),
            output_1 => outputtingSignal(2)
        );

    Xor1Bit_3 : xor1Bit
        port map(
            input_1 => extended_input_1(3),
            input_2 => extended_input_2(3),
            output_1 => outputtingSignal(3)
        );

    Xor1Bit_4 : xor1Bit
        port map(
            input_1 => extended_input_1(4),
            input_2 => extended_input_2(4),
            output_1 => outputtingSignal(4)
        );
    
    Xor1Bit_5 : xor1Bit
        port map(
            input_1 => extended_input_1(5),
            input_2 => extended_input_2(5),
            output_1 => outputtingSignal(5)
        );

    Xor1Bit_6 : xor1Bit
        port map(
            input_1 => extended_input_1(6),
            input_2 => extended_input_2(6),
            output_1 => outputtingSignal(6)
        );

    Xor1Bit_7 : xor1Bit
        port map(
            input_1 => extended_input_1(7),
            input_2 => extended_input_2(7),
            output_1 => outputtingSignal(7)
        );

    Xor1Bit_8 : xor1Bit
        port map(
            input_1 => extended_input_1(8),
            input_2 => extended_input_2(8),
            output_1 => outputtingSignal(8)
        );

    Xor1Bit_9 : xor1Bit
        port map(
            input_1 => extended_input_1(9),
            input_2 => extended_input_2(9),
            output_1 => outputtingSignal(9)
        );

    Xor1Bit_10 : xor1Bit
        port map(
            input_1 => extended_input_1(10),
            input_2 => extended_input_2(10),
            output_1 => outputtingSignal(10)
        );

    Xor1Bit_11 : xor1Bit
        port map(
            input_1 => extended_input_1(11),
            input_2 => extended_input_2(11),
            output_1 => outputtingSignal(11)
        );

    Xor1Bit_12 : xor1Bit
        port map(
            input_1 => extended_input_1(12),
            input_2 => extended_input_2(12),
            output_1 => outputtingSignal(12)
        );

    Xor1Bit_13 : xor1Bit
        port map(
            input_1 => extended_input_1(13),
            input_2 => extended_input_2(13),
            output_1 => outputtingSignal(13)
        );

    Xor1Bit_14 : xor1Bit
        port map(
            input_1 => extended_input_1(14),
            input_2 => extended_input_2(14),
            output_1 => outputtingSignal(14)
        );

    Xor1Bit_15 : xor1Bit
        port map(
            input_1 => extended_input_1(15),
            input_2 => extended_input_2(15),
            output_1 => outputtingSignal(15)
        );

    Xor1Bit_16 : xor1Bit
        port map(
            input_1 => extended_input_1(16),
            input_2 => extended_input_2(16),
            output_1 => outputtingSignal(16)
        );

    Xor1Bit_17 : xor1Bit
        port map(
            input_1 => extended_input_1(17),
            input_2 => extended_input_2(17),
            output_1 => outputtingSignal(17)
        );

    Xor1Bit_18 : xor1Bit
        port map(
            input_1 => extended_input_1(18),
            input_2 => extended_input_2(18),
            output_1 => outputtingSignal(18)
        );


    Xor1Bit_19 : xor1Bit
        port map(
            input_1 => extended_input_1(19),
            input_2 => extended_input_2(19),
            output_1 => outputtingSignal(19)
        );

    Xor1Bit_20 : xor1Bit
        port map(
            input_1 => extended_input_1(20),
            input_2 => extended_input_2(20),
            output_1 => outputtingSignal(20)
        );

    Xor1Bit_21 : xor1Bit
        port map(
            input_1 => extended_input_1(21),
            input_2 => extended_input_2(21),
            output_1 => outputtingSignal(21)
        );

    Xor1Bit_22 : xor1Bit
        port map(
            input_1 => extended_input_1(22),
            input_2 => extended_input_2(22),
            output_1 => outputtingSignal(22)
        );

    Xor1Bit_23 : xor1Bit
        port map(
            input_1 => extended_input_1(23),
            input_2 => extended_input_2(23),
            output_1 => outputtingSignal(23)
        );

    Xor1Bit_24 : xor1Bit
        port map(
            input_1 => extended_input_1(24),
            input_2 => extended_input_2(24),
            output_1 => outputtingSignal(24)
        );

    Xor1Bit_25 : xor1Bit
        port map(
            input_1 => extended_input_1(25),
            input_2 => extended_input_2(25),
            output_1 => outputtingSignal(25)
        );

    Xor1Bit_26 : xor1Bit
        port map(
            input_1 => extended_input_1(26),
            input_2 => extended_input_2(26),
            output_1 => outputtingSignal(26)
        );

    Xor1Bit_27 : xor1Bit
        port map(
            input_1 => extended_input_1(27),
            input_2 => extended_input_2(27),
            output_1 => outputtingSignal(27)
        );

    Xor1Bit_28 : xor1Bit
        port map(
            input_1 => extended_input_1(28),
            input_2 => extended_input_2(28),
            output_1 => outputtingSignal(28)
        );


    Xor1Bit_29 : xor1Bit
        port map(
            input_1 => extended_input_1(29),
            input_2 => extended_input_2(29),
            output_1 => outputtingSignal(29)
        );

    Xor1Bit_30 : xor1Bit
        port map(
            input_1 => extended_input_1(30),
            input_2 => extended_input_2(30),
            output_1 => outputtingSignal(30)
        );

    Xor1Bit_31 : xor1Bit
        port map(
            input_1 => extended_input_1(31),
            input_2 => extended_input_2(31),
            output_1 => outputtingSignal(31)
        );

    Xor1Bit_32 : xor1Bit
        port map(
            input_1 => extended_input_1(32),
            input_2 => extended_input_2(32),
            output_1 => outputtingSignal(32)
        );

    Xor1Bit_33 : xor1Bit
        port map(
            input_1 => extended_input_1(33),
            input_2 => extended_input_2(33),
            output_1 => outputtingSignal(33)
        );

    Xor1Bit_34 : xor1Bit
        port map(
            input_1 => extended_input_1(34),
            input_2 => extended_input_2(34),
            output_1 => outputtingSignal(34)
        );

    Xor1Bit_35 : xor1Bit
        port map(
            input_1 => extended_input_1(35),
            input_2 => extended_input_2(35),
            output_1 => outputtingSignal(35)
        );

    Xor1Bit_36 : xor1Bit
        port map(
            input_1 => extended_input_1(36),
            input_2 => extended_input_2(36),
            output_1 => outputtingSignal(36)
        );  

    Xor1Bit_37 : xor1Bit
        port map(
            input_1 => extended_input_1(37),
            input_2 => extended_input_2(37),
            output_1 => outputtingSignal(37)
        );

    Xor1Bit_38 : xor1Bit
        port map(
            input_1 => extended_input_1(38),
            input_2 => extended_input_2(38),
            output_1 => outputtingSignal(38)
        );

    Xor1Bit_39 : xor1Bit
        port map(
            input_1 => extended_input_1(39),
            input_2 => extended_input_2(39),
            output_1 => outputtingSignal(39)
        );

    Xor1Bit_40 : xor1Bit
        port map(
            input_1 => extended_input_1(40),
            input_2 => extended_input_2(40),
            output_1 => outputtingSignal(40)
        );

    Xor1Bit_41 : xor1Bit
        port map(
            input_1 => extended_input_1(41),
            input_2 => extended_input_2(41),
            output_1 => outputtingSignal(41)
        );

    Xor1Bit_42 : xor1Bit
        port map(
            input_1 => extended_input_1(42),
            input_2 => extended_input_2(42),
            output_1 => outputtingSignal(42)
        );

    Xor1Bit_43 : xor1Bit
        port map(
            input_1 => extended_input_1(43),
            input_2 => extended_input_2(43),
            output_1 => outputtingSignal(43)
        );


    Xor1Bit_44 : xor1Bit
        port map(
            input_1 => extended_input_1(44),
            input_2 => extended_input_2(44),
            output_1 => outputtingSignal(44)
        );

    Xor1Bit_45 : xor1Bit
        port map(
            input_1 => extended_input_1(45),
            input_2 => extended_input_2(45),
            output_1 => outputtingSignal(45)
        );

    Xor1Bit_46 : xor1Bit
        port map(
            input_1 => extended_input_1(46),
            input_2 => extended_input_2(46),
            output_1 => outputtingSignal(46)
        );     

    Xor1Bit_47 : xor1Bit
        port map(
            input_1 => extended_input_1(47),
            input_2 => extended_input_2(47),
            output_1 => outputtingSignal(47)
        );

    Xor1Bit_48 : xor1Bit
        port map(
            input_1 => extended_input_1(48),
            input_2 => extended_input_2(48),
            output_1 => outputtingSignal(48)
        );

    Xor1Bit_49 : xor1Bit
        port map(
            input_1 => extended_input_1(49),
            input_2 => extended_input_2(49),
            output_1 => outputtingSignal(49)
        );

    Xor1Bit_50 : xor1Bit
        port map(
            input_1 => extended_input_1(50),
            input_2 => extended_input_2(50),
            output_1 => outputtingSignal(50)
        );

    Xor1Bit_51 : xor1Bit
        port map(
            input_1 => extended_input_1(51),
            input_2 => extended_input_2(51),
            output_1 => outputtingSignal(51)
        );

    Xor1Bit_52 : xor1Bit
        port map(
            input_1 => extended_input_1(52),
            input_2 => extended_input_2(52),
            output_1 => outputtingSignal(52)
        );

    Xor1Bit_53 : xor1Bit
        port map(
            input_1 => extended_input_1(53),
            input_2 => extended_input_2(53),
            output_1 => outputtingSignal(53)
        );

    Xor1Bit_54 : xor1Bit
        port map(
            input_1 => extended_input_1(54),
            input_2 => extended_input_2(54),
            output_1 => outputtingSignal(54)
        );

    Xor1Bit_55 : xor1Bit
        port map(
            input_1 => extended_input_1(55),
            input_2 => extended_input_2(55),
            output_1 => outputtingSignal(55)
        );

    Xor1Bit_56 : xor1Bit
        port map(
            input_1 => extended_input_1(56),
            input_2 => extended_input_2(56),
            output_1 => outputtingSignal(56)
        );

    Xor1Bit_57 : xor1Bit
        port map(
            input_1 => extended_input_1(57),
            input_2 => extended_input_2(57),
            output_1 => outputtingSignal(57)
        );

    Xor1Bit_58 : xor1Bit
        port map(
            input_1 => extended_input_1(58),
            input_2 => extended_input_2(58),
            output_1 => outputtingSignal(58)
        );

    Xor1Bit_59 : xor1Bit
        port map(
            input_1 => extended_input_1(59),
            input_2 => extended_input_2(59),
            output_1 => outputtingSignal(59)
        );

    Xor1Bit_60 : xor1Bit
        port map(
            input_1 => extended_input_1(60),
            input_2 => extended_input_2(60),
            output_1 => outputtingSignal(60)
        );

    Xor1Bit_61 : xor1Bit
        port map(
            input_1 => extended_input_1(61),
            input_2 => extended_input_2(61),
            output_1 => outputtingSignal(61)
        );

    Xor1Bit_62 : xor1Bit
        port map(
            input_1 => extended_input_1(62),
            input_2 => extended_input_2(62),
            output_1 => outputtingSignal(62)
        );

    Xor1Bit_63 : xor1Bit
        port map(
            input_1 => extended_input_1(63),
            input_2 => extended_input_2(63),
            output_1 => outputtingSignal(63)
        );

    
    --outputting the result
    output_1 <= outputtingSignal(31 downto 0);
    output_2 <= outputtingSignal(63 downto 32);


    end architecture Logic_1;