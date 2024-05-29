library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;


entity Test_memory is
   port (
	      address : in std_logic_vector(7 downto 0);
			data_in : in std_logic_vector(7 downto 0);
			writen  : in std_logic;
			clock   : in std_logic;
			reset   : in std_logic;
			port_in_00, port_in_01 : in std_logic_vector(7 downto 0);
			deco2, deco3, deco4, deco5 : out std_logic_vector(6 downto 0);
			port_out_00 : out std_logic_vector(7 downto 0));
			
end Test_memory;


architecture architecture_Test_memory of Test_memory is 


component memory is

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

end component;


component Displays7Seg4bits is
port  (
	    abcd : in std_logic_vector(3 downto 0) ;
	    salida: out std_logic_vector(6 downto 0));
	
end component;

	signal direccion : std_logic_vector(7 downto 0);
   signal deco1direccion, deco2direccion, data_out1, data_out2 : std_logic_vector(3 downto 0);
	signal senal_data_out : std_logic_vector(7 downto 0);
	
	
   begin
	   
	   direccion <= address;
	   
		paso1 : memory port map (address => direccion, data_in => data_in, writen => writen, port_in_00 => port_in_00, port_in_01 => port_in_01, clock => clock, reset => reset, data_out => senal_data_out, port_out_00 => port_out_00);
		
		deco1direccion <= direccion(7 downto 4);
		deco2direccion <= direccion(3 downto 0);
		
		paso2 : displays7Seg4bits port map (abcd => deco1direccion, salida => deco2);
		paso5 : displays7Seg4bits port map (abcd => deco2direccion, salida => deco3);
		
		data_out1 <= senal_data_out(7 downto 4);
		data_out2 <= senal_data_out(3 downto 0);
		
		paso6 : displays7Seg4bits port map (abcd => data_out1, salida => deco4);
		paso7 : displays7Seg4bits port map (abcd => data_out2, salida => deco5);
		

end architecture_Test_memory;