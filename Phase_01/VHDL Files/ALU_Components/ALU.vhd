-- ALU consists of
-- 1. Main functional Components
-- 2. Supporting functional Components eg : Mux that selects the output of the main functional components based on the ALU_OP input
-- 3. Signals
-- 4. Zero flag that is set when the output of the main functional components is zero. 


-- Functions of ALU
-- 1. ADD  -- Done
-- 2. SUB -- Done
-- 3. SLL -- Done
-- 4. SLT -- Done
-- 5. SLTU -- Done
-- 6. XOR -- Done
-- 7. SRL -- Done
-- 8. SRA -- Done
-- 9. OR -- Done
-- 10. AND -- Done
-- 11. MUL -- Done
-- 12. MULH -- Done
-- 13. MULHSU -- Done
-- 14. MULHU -- Done
-- 15. DIV -- Yet to be done
-- 16. DIVU -- Yet to be done
-- 17. REM -- Yet to be done
-- 18. REMU -- Yet to be done
-- 19. flagZero -- yet to be done


-- There are 18 functions in ALU that need to be selected based on the ALU_OP input
-- Therefore we need ALU_OP to be 5 bits wide

library ieee;
use ieee.std_logic_1164.all;


entity ALU is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        ALU_OP : IN std_logic_vector(5 downto 0);
        output_1 : OUT std_logic_vector(31 downto 0);
        zero : OUT std_logic
    );
end entity ALU;



architecture ALUArchitecture of ALU is
    --/* --------------------------- Declaring Components -------------------------------------*/

    --/* ------------------ Declaring Main functional Components ------------------------------*/
    component adder_signed is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component subtractor is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component ShiftLeftLogical is
        port(
            input_1 : IN std_logic_vector (31 downto 0);
            input_2 : IN std_logic_vector (31 downto 0);
            output_1 : OUT std_logic_vector (31 downto 0)
        );
    
    end component;

    component SetLessThan is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component SetLessThanUnsigned is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component xorer is
        port(
            input_1 : IN std_logic_vector (31 downto 0);
            input_2 : IN std_logic_vector (31 downto 0);
            output_1 : OUT std_logic_vector (31 downto 0)
        );
    end component;

    component ShiftRightLogical is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component ShiftRightArithmetic is
        port(
            input_1 : IN std_logic_vector (31 downto 0);
            input_2 : IN std_logic_vector (31 downto 0);
            output_1 : OUT std_logic_vector (31 downto 0)
        );
    end component;

    component orer is 
        port(
            input_1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            input_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            output_1 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
    end component; 

    component ander is 
        port(
            input_1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            input_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            output_1 : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
    end component;

    component multiplier_signed is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0);
            output_2 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component MUL_Signed_Unsigned is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0);
            output_2 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component multiplier_unsigned is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0);
            output_2 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    


    --/* -------------- Declaring Supporting functional Components ----------------------------*/
    component multiplexter32to1 is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            input_3 : IN std_logic_vector(31 downto 0);
            input_4 : IN std_logic_vector(31 downto 0);
            input_5 : IN std_logic_vector(31 downto 0);
            input_6 : IN std_logic_vector(31 downto 0);
            input_7 : IN std_logic_vector(31 downto 0);
            input_8 : IN std_logic_vector(31 downto 0);
            input_9 : IN std_logic_vector(31 downto 0);
            input_10 : IN std_logic_vector(31 downto 0);
            input_11 : IN std_logic_vector(31 downto 0);
            input_12 : IN std_logic_vector(31 downto 0);
            input_13 : IN std_logic_vector(31 downto 0);
            input_14 : IN std_logic_vector(31 downto 0);
            input_15 : IN std_logic_vector(31 downto 0);
            input_16 : IN std_logic_vector(31 downto 0);
            input_17 : IN std_logic_vector(31 downto 0);
            input_18 : IN std_logic_vector(31 downto 0);
            select_bus : IN std_logic_vector(4 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;


    --/* --------------------------- Declaring Signals ----------------------------------------*/
    signal adder_output , subtractor_output , sllOutput , sltOutput , sltuOutput ,xorOutput , srlOutput ,sraOutput , orOutput, anderOutput, mulLowerBitsOutput, mulHigherBitsOutput, mulSignedUnsignedLowerBitsOutput, mulSignedUnsignedHigherBitsOutput, mulUsignedLowerBitsOutput, mulUnsignedHigherBitsOutput  : std_logic_vector(31 downto 0) ;



    begin
        --/* --------------------------- Instantiating Components -------------------------------*/

        --/* --------------------------- Instantiating Main functional Components ----------------*/

        ADD_Operator : adder_signed
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => adder_output
            );


        SUB_Operator : subtractor
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => subtractor_output
            );

        SLL_Operator : ShiftLeftLogical
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => sllOutput
            );
        
        SLT_Operator : SetLessThan
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => sltOutput
            );

        SLTU_Operator : SetLessThanUnsigned
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => sltuOutput
            );

        XOR_Operator : xorer
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => xorOutput
            );

        SRL_Operator : ShiftRightLogical
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => srlOutput
            );

        SRA_Operator : ShiftRightArithmetic
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => sraOutput
            );

        Or_Operator : orer
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => orOutput
            );
        And_Operator : ander
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => anderOutput
            );

        Mul_Signed_Operator : multiplier_signed
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => mulLowerBitsOutput,
                output_2 => mulHigherBitsOutput
            );

        Multiplier_Signed_Unsigned_Operator : MUL_Signed_Unsigned
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => mulSignedUnsignedLowerBitsOutput,
                output_2 => mulSignedUnsignedHigherBitsOutput
            );

        Multiplier_Unsigned_Operator : multiplier_unsigned
            port map(
                input_1 => input_1,
                input_2 => input_2,
                output_1 => mulUsignedLowerBitsOutput,
                output_2 => mulUnsignedHigherBitsOutput
            );
        
        


        --/* --------------------------- Instantiating Supporting functional Components ----------*/

        MUX : multiplexter32to1
            port map(
                input_1 => adder_output,
                input_2 => subtractor_output,
                input_3 => sllOutput,
                input_4 => sltOutput,
                input_5 => sltuOutput,
                input_6 => xorOutput,
                input_7 => srlOutput,
                input_8 => sraOutput,
                input_9 => orOutput,
                input_10 => anderOutput,
                input_11 => mulLowerBitsOutput,
                input_12 => mulHigherBitsOutput,
                input_13 => mulSignedUnsignedHigherBitsOutput,
                input_14 => mulUnsignedHigherBitsOutput,
                input_15 => (others => '0'),
                input_16 => (others => '0'),
                input_17 => (others => '0'),
                input_18 => (others => '0'),
                select_bus => ALU_OP(4 downto 0),
                output_1 => output_1
            );
        

    end architecture ALUArchitecture;