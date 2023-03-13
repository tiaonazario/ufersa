LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control IS
  PORT (
    reset : IN STD_LOGIC;
    clock : IN STD_LOGIC;

    coin : IN STD_LOGIC;
    totLessThanPrice : IN STD_LOGIC;
    speed : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

    fraud : OUT STD_LOGIC;
    totLoad : OUT STD_LOGIC;
    totClear : OUT STD_LOGIC;
    detect : OUT STD_LOGIC
  );
END control;

ARCHITECTURE control_arch OF control IS

  TYPE state IS (INICIO, ESPERAR, SOMAR, FORNECER);

  SIGNAL sourceState : state;
  SIGNAL nextState : state;
  -- SIGNAL hasCoin : STD_LOGIC := '0';

  -- definindo a constante de velocidade speed/10 = 0,5 m/s
  CONSTANT base_speed : STD_LOGIC_VECTOR(7 DOWNTO 0) := b"00000101";

BEGIN

  setSourceState : PROCESS (reset, clock)
  BEGIN
    IF reset = '1' THEN
      sourceState <= INICIO;
    ELSIF rising_edge(clock) THEN
      sourceState <= nextState;
    END IF;
  END PROCESS setSourceState;

  setNextState : PROCESS (sourceState, coin, totLessThanPrice)
  BEGIN
    CASE sourceState IS
      WHEN INICIO => nextState <= ESPERAR;
        totClear <= '1';
        fraud <= '0';
        totLoad <= '0';
        detect <= '0';

      WHEN ESPERAR => nextState <= FORNECER;
        totLoad <= '0';
        totClear <= '0';
        detect <= '0';

        IF speed = base_speed THEN
          fraud <= '0';
          IF coin = '1' AND totLessThanPrice = '1' THEN
            nextState <= SOMAR;
          ELSIF totLessThanPrice = '0' THEN
            nextState <= FORNECER;
          ELSE
            nextState <= ESPERAR;
          END IF;

        ELSIF speed = b"00000000" THEN
          fraud <= '0';
          nextState <= ESPERAR;
        ELSE
          nextState <= ESPERAR;
          fraud <= '1';
        END IF;

      WHEN SOMAR => nextState <= ESPERAR;
        totClear <= '0';
        totLoad <= '1';
        detect <= '0';

      WHEN FORNECER => nextState <= INICIO;
        totClear <= '0';
        totLoad <= '0';
        detect <= '1';

    END CASE;

  END PROCESS;

END ARCHITECTURE control_arch;
