LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY register_price IS
  PORT (
    reset : IN STD_LOGIC;
    clock : IN STD_LOGIC;

    totLoad : IN STD_LOGIC;
    totClear : IN STD_LOGIC;
    sum : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

    tot : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END register_price;

ARCHITECTURE register_price_arch OF register_price IS
BEGIN

  PROCESS (reset, clock, totLoad, totClear, sum)
  BEGIN
    IF reset = '1' THEN
      tot <= b"00000000";

    ELSIF rising_edge(clock) THEN
      IF totClear = '1' THEN
        tot <= b"00000000";
      ELSIF totLoad = '1' THEN
        tot <= sum;
      END IF;
    END IF;
  END PROCESS;

END ARCHITECTURE register_price_arch;
