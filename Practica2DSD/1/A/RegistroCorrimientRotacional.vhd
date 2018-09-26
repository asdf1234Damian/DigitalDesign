library ieee;
use ieee. std_logic_1164.all;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;

entity corrimientoRotacional is
port(
	shift: in std_logic; -- 0=shift 1=pararell(hold)
	ck:inout std_logic;
	pn:in std_logic_vector(3 downto 0);
	z: out std_logic_vector(3 downto 0)
	);
end entity;

architecture barrShift of corrimientoRotacional is

component ffsr
	PORT( 
	s,r,ck1: in std_logic;
	Q: out std_logic
	);
end component;

component andNor
port(
	na,nb,nc,nd: in std_logic;
	nz: out std_logic
	);
end component;

signal nots: std_logic; 
signal oq :std_logic_vector(3 downto 0);
signal oan :std_logic_vector(3 downto 0);
signal noan :std_logic_vector(3 downto 0);

begin 
	
	nots<=not shift; 
	an0: andNor port map(oq(3),nots,shift,pn(0),oan(0));
	an1: andNor port map(oq(0),nots,shift,pn(1),oan(1));
	an2: andNor port map(oq(1),nots,shift,pn(2),oan(2));
	an3: andNor port map(oq(2),nots,shift,pn(3),oan(3));
	noan<=not oan;
	ff0: ffsr port map(noan(0),oan(0),ck,oq(0)); 
	ff1: ffsr port map(noan(1),oan(1),ck,oq(1)); 
	ff2: ffsr port map(noan(2),oan(2),ck,oq(2)); 
	ff3: ffsr port map(noan(3),oan(3),ck,oq(3)); 
	z<=oq;
	
end architecture;  

 
