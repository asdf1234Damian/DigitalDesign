Library IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY EntPrac1 is
  port(
    a,b:in STD_LOGIC;
    c,d,e,f,g,h,i,j:out STD_LOGIC
  );
END ENTITY
ARCHITECTURE ArchPrac1 of EntPrac1 is
  BEGIN
    c<=a or b;
    d<= and ab
    e<=a nor b
    f<=a nand b
    g<=a xor b
    h<=a xnor b
    i<= not a
    j<= not b
  END;
