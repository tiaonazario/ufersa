LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY comparator IS
  PORT (
    tot : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    price : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

    totLessThanPrice : OUT STD_LOGIC
  );
END comparator;

ARCHITECTURE comparator_arch OF comparator IS

BEGIN

  PROCESS (tot, price)
  BEGIN
    IF tot < price THEN
      totLessThanPrice <= '1';
    ELSE
      totLessThanPrice <= '0';
    END IF;
  END PROCESS;

END ARCHITECTURE comparator_arch;
