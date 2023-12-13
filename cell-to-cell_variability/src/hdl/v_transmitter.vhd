-- UART transmitter
-- transmit v (membrane potential of a neuron) and I (stimulus input)
-- both signals are represented by 18-bit and encoded into 3 byte data through UART communication
-- packets are sent every 0.1 ms depending on the TRIGER signal
-- a single packet is composed of following seven byte data
-- v(17 downto 11), v1(10 downto 4), v2(3 downto 0), I0(17 downto 11), I1(10 downto 4), I2(3 downto 0), 10(LF)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY v_transmitter IS
	GENERIC (PQN_BIT_WIDTH : NATURAL := 18);
	PORT (
		CLK : IN STD_LOGIC;
		TRIGER : IN STD_LOGIC;
		UART_TXD : OUT STD_LOGIC;
		UART_TXD_V0 : IN STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0);
		UART_TXD_V1 : IN STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0);
		UART_TXD_V2 : IN STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0);
		UART_TXD_V3 : IN STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0);
		UART_TXD_V4 : IN STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0);
		UART_TXD_V5 : IN STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0);
		UART_TXD_V6 : IN STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0);
		UART_TXD_V7 : IN STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0);
		UART_TXD_V8 : IN STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0);
		UART_TXD_V9 : IN STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0)
	);
END v_transmitter;
ARCHITECTURE Behavioral OF v_transmitter IS

	COMPONENT uart_txd_ctrl
		PORT (
			clk : IN STD_LOGIC;
			send_start : IN STD_LOGIC;
			send_data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			uart_txd : OUT STD_LOGIC;
			send_ready : OUT STD_LOGIC
		);
	END COMPONENT;
	TYPE STATE_TYPE IS (STANDBY, SEND_MEASURINGva0, SEND_MEASURINGva1, SEND_MEASURINGva2, SEND_MEASURINGvb0, SEND_MEASURINGvb1, SEND_MEASURINGvb2, SEND_MEASURINGvc0, SEND_MEASURINGvc1, SEND_MEASURINGvc2, SEND_MEASURINGvd0, SEND_MEASURINGvd1, SEND_MEASURINGvd2, SEND_MEASURINGve0, SEND_MEASURINGve1, SEND_MEASURINGve2, SEND_MEASURINGvf0, SEND_MEASURINGvf1, SEND_MEASURINGvf2, SEND_MEASURINGvg0, SEND_MEASURINGvg1, SEND_MEASURINGvg2, SEND_MEASURINGvh0, SEND_MEASURINGvh1, SEND_MEASURINGvh2, SEND_MEASURINGvi0, SEND_MEASURINGvi1, SEND_MEASURINGvi2, SEND_MEASURINGvl0, SEND_MEASURINGvl1, SEND_MEASURINGvl2,END0, END1);
	SIGNAL STATE : STATE_TYPE := STANDBY;
	SIGNAL counter0 : NATURAL := 0;
	SIGNAL counter1 : NATURAL := 0;
	SIGNAL send_start : STD_LOGIC := '0';
	SIGNAL send_ready : STD_LOGIC := '0';
	SIGNAL send_data : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL v_copied : STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL I_copied : STD_LOGIC_VECTOR(PQN_BIT_WIDTH - 1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL send_counter_max : NATURAL := 1;
    SIGNAL data_num_max : NATURAL := 1;

BEGIN
	uart_txd_ctrl_0 : uart_txd_ctrl
	PORT MAP(
		CLK => CLK, 
		send_start => send_start, 
		send_data => send_data, 
		uart_txd => uart_txd, 
		send_ready => send_ready
	);

	processor : PROCESS (CLK)
	BEGIN
		IF (rising_edge(CLK)) THEN
			CASE STATE IS
				WHEN STANDBY => 
					SEND_START <= '0';
					IF (TRIGER = '1') THEN
						STATE <= SEND_MEASURINGva0;
						v_copied <= UART_TXD_V0;
						counter0 <= 0;
					END IF;
				WHEN SEND_MEASURINGva0 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(17 DOWNTO 11);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGva1;
						END IF;
					END IF;
				WHEN SEND_MEASURINGva1 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(10 DOWNTO 4);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGva2;
						END IF;
					END IF;
				WHEN SEND_MEASURINGva2 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(3 DOWNTO 0) & "000";
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvb0;
							v_copied <= UART_TXD_V1;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvb0 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(17 DOWNTO 11);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvb1;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvb1 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(10 DOWNTO 4);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvb2;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvb2 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(3 DOWNTO 0) & "000";
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvc0;
							v_copied <= UART_TXD_V2;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvc0 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(17 DOWNTO 11);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvc1;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvc1 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(10 DOWNTO 4);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvc2;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvc2 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(3 DOWNTO 0) & "000";
							send_start <= '1';
							counter0 <= 0;
							v_copied <= UART_TXD_V3;
							STATE <= SEND_MEASURINGvd0;
						END IF;
					END IF;
					WHEN SEND_MEASURINGvd0 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(17 DOWNTO 11);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvd1;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvd1 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(10 DOWNTO 4);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvd2;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvd2 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(3 DOWNTO 0) & "000";
							send_start <= '1';
							counter0 <= 0;
							v_copied <= UART_TXD_V4;
							STATE <= SEND_MEASURINGve0;
						END IF;
					END IF;
				WHEN SEND_MEASURINGve0 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(17 DOWNTO 11);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGve1;
						END IF;
					END IF;
				WHEN SEND_MEASURINGve1 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(10 DOWNTO 4);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGve2;
						END IF;
					END IF;
				WHEN SEND_MEASURINGve2 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(3 DOWNTO 0) & "000";
							send_start <= '1';
							counter0 <= 0;
							v_copied <= UART_TXD_V5;
							STATE <= SEND_MEASURINGvf0;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvf0 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(17 DOWNTO 11);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvf1;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvf1 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(10 DOWNTO 4);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvf2;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvf2 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(3 DOWNTO 0) & "000";
							send_start <= '1';
							counter0 <= 0;
							v_copied <= UART_TXD_V6;
							STATE <= SEND_MEASURINGvg0;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvg0 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(17 DOWNTO 11);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvg1;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvg1 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(10 DOWNTO 4);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvg2;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvg2 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(3 DOWNTO 0) & "000";
							send_start <= '1';
							counter0 <= 0;
							v_copied <= UART_TXD_V7;
							STATE <= SEND_MEASURINGvh0;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvh0 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(17 DOWNTO 11);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvh1;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvh1 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(10 DOWNTO 4);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvh2;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvh2 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(3 DOWNTO 0) & "000";
							send_start <= '1';
							counter0 <= 0;
							v_copied <= UART_TXD_V8;
							STATE <= SEND_MEASURINGvi0;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvi0 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(17 DOWNTO 11);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvi1;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvi1 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(10 DOWNTO 4);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvi2;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvi2 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(3 DOWNTO 0) & "000";
							send_start <= '1';
							counter0 <= 0;
							v_copied <= UART_TXD_V9;
							STATE <= SEND_MEASURINGvl0;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvl0 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(17 DOWNTO 11);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvl1;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvl1 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(10 DOWNTO 4);
							send_start <= '1';
							counter0 <= 0;
							STATE <= SEND_MEASURINGvl2;
						END IF;
					END IF;
				WHEN SEND_MEASURINGvl2 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "1" & v_copied(3 DOWNTO 0) & "000";
							send_start <= '1';
							counter0 <= 0;
							STATE <= END0;
						END IF;
					END IF;

				WHEN END0 => 
					IF (counter0 < send_counter_max) THEN
						send_start <= '0';
						counter0 <= counter0 + 1;
					ELSIF (counter0 = send_counter_max) THEN
						IF (send_ready = '1') THEN
							send_data <= "00001010";
							send_start <= '1';
							counter0 <= 0;
							STATE <= STANDBY;
						END IF;
					END IF;
				WHEN OTHERS => 
					STATE <= STANDBY;
			END CASE;
		END IF;
	END PROCESS;
END Behavioral;