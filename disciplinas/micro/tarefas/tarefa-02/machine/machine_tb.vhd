LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY machine_tb IS
END machine_tb;

ARCHITECTURE machine_tb_arch OF machine_tb IS

  COMPONENT machine IS
    PORT (
      reset : IN STD_LOGIC;
      clock : IN STD_LOGIC;

      coin : IN STD_LOGIC;
      amount : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      price : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      detect : OUT STD_LOGIC
    );
  END COMPONENT machine;

  SIGNAL reset : STD_LOGIC;
  SIGNAL clock : STD_LOGIC;
  SIGNAL coin : STD_LOGIC;
  SIGNAL amount : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL price : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL detect : STD_LOGIC;

BEGIN

  call : machine PORT MAP(
    reset => reset,
    clock => clock,
    coin => coin,
    amount => amount,
    price => price,
    detect => detect
  );

  PROCESS
  BEGIN
    -- resetando os valores
    reset <= '1';
    clock <= '0';
    coin <= '0';
    amount <= b"00000000";
    price <= b"00000101";

    WAIT FOR 10 ns;

    reset <= '0';
    clock <= NOT clock;

    WAIT FOR 10 ns;

    amount <= b"00000001";
    clock <= NOT clock;

    WAIT FOR 10 ns;

    WAIT;

  END PROCESS;

END ARCHITECTURE machine_tb_arch;
