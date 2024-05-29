LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memory is

port (
	   address : in std_logic_vector(7 downto 0);
		data_in : in std_logic_vector(7 downto 0);
		writen : in std_logic;
		port_in_00 : in std_logic_vector(7 downto 0);
		port_in_01 : in std_logic_vector(7 downto 0);
		clock : in std_logic;
		reset : in std_logic;
		port_out_00 : out std_logic_vector(7 downto 0);
		port_out_01 : out std_logic_vector(7 downto 0);
		data_out : out std_logic_vector(7 downto 0));

end memory;


architecture memory_arch of memory is

component rom_128x8_sync is

port (
     address : in std_logic_vector(7 downto 0);
	  clock : in std_logic;
	  salidaROM : out std_logic_vector(7 downto 0));

end component;

component rw_96x8_sync is
	port( address  : in std_logic_vector(7 downto 0);
			data_in  : in std_logic_vector(7 downto 0);
			clock      : in  std_logic;
			writen    : in std_logic;
			salidaRAM : out std_logic_vector(7 downto 0));
end component;

component output_ports is
    Port (
        clock : in std_logic;
        reset : in std_logic;
        address : in std_logic_vector(7 downto 0);
        writen : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        port_out_00 : out std_logic_vector(7 downto 0);
        port_out_01 : out std_logic_vector(7 downto 0));
end component;

component multiplexor is

	port (
	      address : in std_logic_vector(7 downto 0);
	      rom_data_out : in std_logic_vector(7 downto 0);
			rw_data_out : in std_logic_vector(7 downto 0);
			port_in_00 : in std_logic_vector(7 downto 0);
			port_in_01 : in std_logic_vector(7 downto 0);
			data_out   :out std_logic_vector(7 downto 0));

end component;

		signal rrom_data_out : std_logic_vector(7 downto 0);
		signal rrw_data_out : std_logic_vector(7 downto 0);


begin

paso1 : rom_128x8_sync port map (clock => clock, address => address, salidaROM => rrom_data_out);
paso2 : rw_96x8_sync port map (clock => clock, address => address, data_in => data_in, writen => writen, salidaRam => rrw_data_out);
paso3 : output_ports port map (clock => clock, address => address, data_in => data_in, reset => reset, writen => writen, port_out_00 => port_out_00, port_out_01 => port_out_01);
paso4 : multiplexor port map (address => address, rom_data_out => rrom_data_out, rw_data_out => rrw_data_out, port_in_00 => port_in_00, port_in_01 => port_in_01, data_out => data_out);
	

end memory_arch;