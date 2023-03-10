LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY adder_tb IS
END adder_tb;

ARCHITECTURE adder_tb_arch OF adder_tb IS

  COMPONENT adder IS
    PORT (
      tot : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      amount : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      sum : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT adder;

  SIGNAL tot : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL amount : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL sum : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

  callAdder : adder PORT MAP(
    tot => tot,
    amount => amount,
    sum => sum
  );

  PROCESS
  BEGIN
    tot <= b"00000000";
    amount <= b"00000000";

    WAIT FOR 20 ns;

    tot <= b"00000100";
    amount <= b"00000010";

    WAIT FOR 20 ns;

    WAIT;

  END PROCESS;

END ARCHITECTURE adder_tb_arch;
