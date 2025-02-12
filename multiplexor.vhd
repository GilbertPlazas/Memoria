library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity multiplexor is

	port (
	      address : in std_logic_vector(7 downto 0);
	      rom_data_out : in std_logic_vector(7 downto 0);
			rw_data_out : in std_logic_vector(7 downto 0);
			port_in_00 : in std_logic_vector(7 downto 0);
			port_in_01 : in std_logic_vector(7 downto 0);
			data_out   :out std_logic_vector(7 downto 0));

end multiplexor;

architecture arch_multiplexor of multiplexor is

begin 

     MUX1 : process (address, rom_data_out, rw_data_out, port_in_00, port_in_01)

        begin
          if ( (to_integer(unsigned(address)) >= 0) and
               (to_integer(unsigned(address)) <= 127)) then
                data_out <= rom_data_out;
             elsif ( (to_integer(unsigned(address)) >= 128) and
               (to_integer(unsigned(address)) <= 223)) then
                    data_out <= rw_data_out;
             elsif (address = x"F0") then data_out <= port_in_00;
             elsif (address = x"F1") then data_out <= port_in_01;

             else data_out <= x"00";
          end if;
      end process;

end arch_multiplexor;
