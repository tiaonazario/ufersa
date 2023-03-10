LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control IS
  PORT (
    reset : IN STD_LOGIC;
    clock : IN STD_LOGIC;

    coin : IN STD_LOGIC;
    totLessThanPrice : IN STD_LOGIC;

    totLoad : OUT STD_LOGIC;
    totClear : OUT STD_LOGIC;
    detect : OUT STD_LOGIC
  );
END control;

ARCHITECTURE control_arch OF control IS

  TYPE state IS (INICIO, ESPERAR, SOMAR, FORNECER);

  SIGNAL sourceState : state;
  SIGNAL nextState : state;

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
        totLoad <= '0';
        totClear <= '1';
        detect <= '0';

      WHEN ESPERAR => nextState <= FORNECER;
        totLoad <= '0';
        totClear <= '0';
        detect <= '0';

        IF coin = '1' THEN
          nextState <= SOMAR;
        ELSIF totLessThanPrice = '0' THEN
          nextState <= FORNECER;
        ELSE
          nextState <= ESPERAR;
        END IF;

      WHEN SOMAR => nextState <= ESPERAR;
        totLoad <= '1';
        totClear <= '0';
        detect <= '0';

      WHEN FORNECER => nextState <= INICIO;
        totLoad <= '0';
        totClear <= '0';
        detect <= '1';

    END CASE;

  END PROCESS;

END ARCHITECTURE control_arch;
