
architecture archXOR6 of seisEntradas is
  component dosEntradas
    port(
    a,b: in std_logic;
    z: out std_logic
    );
  end component;
  signal s1,s2,s3,s4,s5: std_logic;
begin
  x1:dosEntradas port map(a,b,s1);
  x2:dosEntradas port map (s1,c,s2);
  x3:dosEntradas port map (s2,d,s3);
  x4:dosEntradas port map (s3,e,s4);
  x5:dosEntradas port map (s4,f,z);
  
end architecture;
