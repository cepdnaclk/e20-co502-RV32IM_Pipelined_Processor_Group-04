library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Branch_Jump_Decoder is
    port(
        --inputs
        Branch_in : in std_logic;
        Jump_in : in std_logic;
        Func3_in : in std_logic_vector(2 downto 0);
        Register_1_in : in std_logic_vector(31 downto 0);
        Register_2_in : in std_logic_vector(31 downto 0);
        Next_PC_in : in std_logic_vector(31 downto 0);

        --outputs
        Reset_out : out std_logic;
        Mux_PC_out : out std_logic;
        Write_Enable_out : out std_logic;
        Next_PC_out : out std_logic_vector(31 downto 0)

    );
end entity Branch_Jump_Decoder;

architecture Logic_1 of Branch_Jump_Decoder is
    
    --Components

    --Component for Comparator
    component Comparator is
        port(
            -- inputs
            input_1 : in std_logic_vector(31 downto 0);
            input_2 : in std_logic_vector(31 downto 0);
    
            -- outputs
            output_signed : out std_logic_vector(1 downto 0);
            output_unsigned : out std_logic_vector(1 downto 0)
        );
    end component;

    -- signals
    signal Comparator_output_signed : std_logic_vector(1 downto 0);
    signal Comparator_output_unsigned : std_logic_vector(1 downto 0);

    begin

        -- Instantiate the Comparator
        Comparator_Impl: Comparator
            port map(
                input_1 => Register_1_in,
                input_2 => Register_2_in,
                output_signed => Comparator_output_signed,
                output_unsigned => Comparator_output_unsigned
            );

        process(Branch_in, Jump_in, Func3_in, Comparator_output_signed, Comparator_output_unsigned)
            variable temp : std_logic_vector(31 downto 0):= "11111111111111111111111111111110";
            begin
                if(Branch_in = '1') then

                    -- next pc
                    Next_PC_out <= Next_PC_in;

                    -- beq instruction
                    if(Func3_in = "000") then
                        if(Comparator_output_signed = "00") then
                            Reset_out <= '1';
                            Mux_PC_out <= '1';
                            Write_Enable_out <= '1';
                        else
                            Reset_out <= '0';
                            Mux_PC_out <= '0';
                            Write_Enable_out <= '0';
                        end if;
                    -- bne instruction
                    elsif(Func3_in = "001") then
                        if(Comparator_output_signed = "01" or Comparator_output_signed = "10") then
                            Reset_out <= '1';
                            Mux_PC_out <= '1';
                            Write_Enable_out <= '1';
                        else
                            Reset_out <= '0';
                            Mux_PC_out <= '0';
                            Write_Enable_out <= '0';
                        end if;
                    -- blt instruction
                    elsif(Func3_in = "100") then
                        if (Comparator_output_signed = "10") then
                            Reset_out <= '1';
                            Mux_PC_out <= '1';
                            Write_Enable_out <= '1';
                        else
                            Reset_out <= '0';
                            Mux_PC_out <= '0';
                            Write_Enable_out <= '0';
                        end if;

                    -- bge instruction
                    elsif(Func3_in = "101") then
                        if (Comparator_output_signed = "01" or Comparator_output_signed = "00") then
                            Reset_out <= '1';
                            Mux_PC_out <= '1';
                            Write_Enable_out <= '1';
                        else
                            Reset_out <= '0';
                            Mux_PC_out <= '0';
                            Write_Enable_out <= '0';
                        end if;

                    -- bltu instruction
                    elsif(Func3_in = "110") then
                        if (Comparator_output_unsigned = "10") then
                            Reset_out <= '1';
                            Mux_PC_out <= '1';
                            Write_Enable_out <= '1';
                        else
                            Reset_out <= '0';
                            Mux_PC_out <= '0';
                            Write_Enable_out <= '0';
                        end if;

                    -- bgeu instruction
                    elsif(Func3_in = "111") then
                        if (Comparator_output_unsigned = "00" or Comparator_output_unsigned = "01") then
                            Reset_out <= '1';
                            Mux_PC_out <= '1';
                            Write_Enable_out <= '1';
                        else
                            Reset_out <= '0';
                            Mux_PC_out <= '0';
                            Write_Enable_out <= '0';
                        end if;
                    end if;

                elsif(Jump_in = '1') then
                    
                    -- new pc
                    Next_PC_out <= Next_PC_in and temp;

                    -- jalr instruction
                    -- jal instruction
                    Reset_out <= '1';
                    Mux_PC_out <= '1';
                    Write_Enable_out <= '1';

                else
                    Reset_out <= '0';
                    Mux_PC_out <= '0';
                    Write_Enable_out <= '0';
                end if;

            end process;

end architecture Logic_1;
                        








