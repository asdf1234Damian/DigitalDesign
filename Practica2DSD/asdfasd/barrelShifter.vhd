library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity corrimientoRotacional is
port(
	shift: in std_logic; -- 0=shift 1=pararell
	clk0:in std_logic;
	pn:in std_logic_vector(3 downto 0);
	z: out std_logic_vector(3 downto 0)
	);
end entity;

architecture barrShift of corrimientoRotacional is

component ffsr
	PORT( 
	s,r,clk1: in std_logic;
	Q, Qn: out std_logic
	);
end component;

component andNor
port(
	ca,cb,cc,cd: in std_logic;
	cz: out std_logic
	);
end component;

component andOr
port(
	ca,cb,cc,cd: in std_logic;
	cz: out std_logic
	);
end component;
 
signal nots,oao: std_logic; 
signal oq :std_logic_vector(3 downto 0);
signal oan :std_logic_vector(3 downto 0);
signal noan :std_logic_vector(3 downto 0);
begin 
	nots<=not shift; 
	ao : andOr port map(nots,clk0,shift,clk0,oao);
	an0: andNor port map(oq(3),nots,Shift,pn(0),oan(0));
	an1: andNor port map(oq(0),nots,Shift,pn(1),oan(1));
	an2: andNor port map(oq(1),nots,Shift,pn(2),oan(2));
	an3: andNor port map(oq(2),nots,Shift,pn(3),oan(3));
	noan<= not oan;
	ff0: ffsr port map(noan(0),oan(0),oao,oq(0),open); 
	ff1: ffsr port map(noan(1),oan(1),oao,oq(1),open); 
	ff2: ffsr port map(noan(2),oan(2),oao,oq(2),open); 
	ff3: ffsr port map(noan(3),oan(3),oao,oq(3),open);
	
	if (clk0'event and clk0='1')then 
	z<="1111";
	else
	z<=oq;
	end if;
end architecture;  

 
