library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;


entity Complementer2s is
    port(
        input_1_comp : IN std_logic_vector(31 downto 0);
        output_1_comp : OUT std_logic_vector(31 downto 0)
    );
end entity Complementer2s;

architecture logic_1 of Complementer2s is

    component Noter is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    component adder_signed is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;

    constant plus_1 : std_logic_vector(31 downto 0) := "00000000000000000000000000000001";
    signal temp_not_input : std_logic_vector(31 downto 0);
    signal temp_not_output : std_logic_vector(31 downto 0);
    signal temp_add_output : std_logic_vector(31 downto 0);


    begin
        -- instantiate the components
        --Not
        Noter_1 : Noter
            port map(
                input_1 => input_1_comp,
                output_1 => temp_not_output
            );
        --Adder
        adder_signed_1 : adder_signed
            port map(
                input_1 => temp_not_output,
                input_2 => plus_1,
                output_1 => output_1_comp
            );

end architecture logic_1;


