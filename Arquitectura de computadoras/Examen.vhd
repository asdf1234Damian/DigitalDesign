entity  Bit_Compare is
  port (
  a,b,xi,yi: in std_logic;
  xo,yo : out std_logic
  );
end entity;

architecture Bit_Compare_a of Bit_Compare is
  signal cmp_in : std_logic_vector(1 downto 0) := xi&yi;
  signal cmp_out :std_logic_vector(1 downto 0);
begin
  case(cmp_in) is
    when "00" =>
      if a=b then
        cmp_out:="00";
      elsif a>b then
        cmp_out:="10";
      else
        cmp_out:="01";
      end if;
    when "10" =>
      cmp_out:="10";
    when "01" =>
      cmp_out:="01";
    when others =>
      cmp_out:="ZZ";
  end case;
  xo <= cmp_out[1];
  yo <= cmp_out[0];
end architecture;
