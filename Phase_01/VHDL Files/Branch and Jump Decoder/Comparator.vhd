--Comparator outputs

--Signed
-- input1 and input2 relation   output      in name
-- input1 = input2              00          1 equal 2 
-- input1 > input2              01          1 greater 2
-- input1 < input2              10          1 less 2

--Unsigned
-- input1 and input2 relation   output      in name
-- input1 = input2              00          1 equal 2
-- input1 > input2              01          1 greater 2
-- input1 < input2              10          1 less 2


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Comparator is
    port(
        -- inputs
        input_1 : in std_logic_vector(31 downto 0);
        input_2 : in std_logic_vector(31 downto 0);

        -- outputs
        output_signed : out std_logic_vector(1 downto 0);
        output_unsigned : out std_logic_vector(1 downto 0)
    );
end entity Comparator;


architecture Logic_1 of Comparator is

    signal adder_Input_1 : std_logic_vector(31 downto 0);
    signal adder_Input_2 : std_logic_vector(31 downto 0);
    signal adder_Output_1 : std_logic_vector(31 downto 0);
    signal Noter_Output_1 : std_logic_vector(31 downto 0);

    component adder_signed is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end  component;

    component Noter is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    begin
        -- Signed Comparison Process
        process(input_1, input_2)
        begin
            if (to_integer(signed(input_1)) = to_integer(signed(input_2))) then
                output_signed <= "00"; -- Equal
            elsif (to_integer(signed(input_1)) > to_integer(signed(input_2))) then
                output_signed <= "01"; -- Greater
            else
                output_signed <= "10"; -- Less
            end if;
        end process;
    
        -- Unsigned Comparison Process
        process(input_1, input_2)
        variable temp_1 : std_logic_vector(32 downto 0);
        variable temp_2 : std_logic_vector(32 downto 0);
        begin
            if (to_integer(signed(input_1)) = to_integer(signed(input_2))) then
                output_unsigned <= "00"; -- Equal

            elsif (input_1(31)='0' and input_2(31) = '0' ) then
                if (to_integer(signed(input_1)) = to_integer(signed(input_2))) then
                    output_unsigned <= "00"; -- Equal
                elsif (to_integer(signed(input_1)) > to_integer(signed(input_2))) then
                    output_unsigned <= "01"; -- Greater
                else
                    output_unsigned <= "10"; -- Less
                end if;
                
            elsif (input_1(31)='1' and input_2(31)='0') then
                output_unsigned <= "01"; -- Greater
            elsif (input_1(31)='0' and input_2(31)='1') then
                output_unsigned <= "10"; -- Less
            else
                if(adder_Output_1(31)='0') then
                    output_unsigned <= "01"; -- Greater
                else
                    output_unsigned <= "10"; -- Less
                end if;
            end if;
        end process;


        --Instance of noter
        Noter_Operation : Noter
            port map(
                input_1 => input_2,
                output_1 => Noter_Output_1
            );

        -- Instantiate the 32-bit adder for add 1 to input_2
        ADD_Operation_for_2s_complemet : adder_signed
            port map(
                input_1 => Noter_Output_1,
                input_2 => "00000000000000000000000000000001",
                output_1 => adder_input_2
            );


        -- Instantiate the 32-bit adder
        ADD_Operation : adder_signed
            port map(
                input_1 => input_1,
                input_2 => adder_input_2,
                output_1 => adder_Output_1
            );


    end architecture Logic_1;
    