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
      amount : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      price : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      speed : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      fraud : OUT STD_LOGIC;
      change : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      detect : OUT STD_LOGIC
    );
  END COMPONENT machine;

  SIGNAL reset : STD_LOGIC;
  SIGNAL clock : STD_LOGIC;
  SIGNAL coin : STD_LOGIC;
  SIGNAL amount : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL price : STD_LOGIC_VECTOR(1 DOWNTO 0);
  SIGNAL change : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL speed : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL fraud : STD_LOGIC;
  SIGNAL detect : STD_LOGIC;

BEGIN

  rtl : machine PORT MAP(
    reset => reset,
    clock => clock,
    coin => coin,
    amount => amount,
    price => price,
    speed => speed,
    fraud => fraud,
    change => change,
    detect => detect
  );

  PROCESS
  BEGIN
    -- ..................................  
    -- INICIO
    -- resetando os valores
    reset <= '1';
    clock <= '0';
    coin <= '0';
    amount <= b"00";
    price <= b"01";
    speed <= b"00000000";

    WAIT FOR 5 ns;

    reset <= '0';

    -- ..................................
    -- ESPERAR
    WAIT FOR 10 ns;
    clock <= NOT clock; -- subida

    amount <= b"10";
    speed <= b"00001010";
    coin <= '1';

    WAIT FOR 10 ns;
    clock <= NOT clock; -- decida

    -- ..................................
    -- SOMAR
    WAIT FOR 10 ns;
    clock <= NOT clock; -- subida
    WAIT FOR 10 ns;
    clock <= NOT clock; -- decida

    -- ..................................
    -- ESPERAR
    WAIT FOR 10 ns;
    clock <= NOT clock; -- subida

    coin <= '0';

    WAIT FOR 10 ns;
    clock <= NOT clock; -- decida

    -- ..................................
    -- FORNECER
    WAIT FOR 10 ns;
    clock <= NOT clock; -- subida

    WAIT FOR 10 ns;
    clock <= NOT clock; -- decida

    -- ..................................
    -- INICIO
    WAIT FOR 10 ns;
    clock <= NOT clock; -- subida
    WAIT FOR 10 ns;
    clock <= NOT clock; -- decida

    -- ..................................
    -- ESPERAR
    WAIT FOR 10 ns;
    clock <= NOT clock; -- subida
    WAIT FOR 10 ns;
    clock <= NOT clock; -- decida

    WAIT;

  END PROCESS;

END ARCHITECTURE machine_tb_arch;
