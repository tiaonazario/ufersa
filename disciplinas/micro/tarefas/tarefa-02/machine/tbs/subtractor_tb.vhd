LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY subtractor_tb IS
END subtractor_tb;

ARCHITECTURE subtractor_tb_arch OF subtractor_tb IS

  COMPONENT subtractor IS
    PORT (
      tot : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      price : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      sub : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT subtractor;

  SIGNAL tot : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL price : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL sub : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

  call : subtractor PORT MAP(
    tot => tot,
    price => price,
    sub => sub
  );

  PROCESS
  BEGIN
    tot <= b"00000000";
    price <= b"00000000";

    WAIT FOR 20 ns;

    tot <= b"00000100";
    price <= b"00000011";

    WAIT FOR 20 ns;

    WAIT;

  END PROCESS;

END ARCHITECTURE subtractor_tb_arch;
