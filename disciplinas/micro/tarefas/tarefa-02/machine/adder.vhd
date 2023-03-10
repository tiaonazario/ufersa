LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY adder IS
  PORT (
    tot : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    amount : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

    sum : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END adder;

ARCHITECTURE adder_arch OF adder IS

BEGIN
  sum <= STD_LOGIC_VECTOR(unsigned(tot) + unsigned(amount));

END ARCHITECTURE adder_arch;
