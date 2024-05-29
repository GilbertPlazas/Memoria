library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity output_ports is
    Port (
        clock : in std_logic;
        reset : in std_logic;
        address : in std_logic_vector(7 downto 0);
        writen : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        port_out_00 : out std_logic_vector(7 downto 0);
        port_out_01 : out std_logic_vector(7 downto 0)
    );
end output_ports;

architecture output_ports_arch of output_ports is
begin

    U3 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_00 <= x"00";
        elsif (rising_edge(clock)) then
            if (address = x"E0" and writen = '1') then
                port_out_00 <= data_in;
            end if;
        end if;
    end process;

    U4 : process (clock, reset)
    begin
        if (reset = '0') then
            port_out_01 <= x"00";
        elsif (rising_edge(clock)) then
            if (address = x"E1" and writen = '1') then
                port_out_01 <= data_in;
            end if;
        end if;
    end process;

end output_ports_arch;