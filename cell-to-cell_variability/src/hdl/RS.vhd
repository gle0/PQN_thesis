library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.ALL;
entity RSexci is
PORT(
    clk : IN STD_LOGIC;
    PORT_Iin : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    PORT_vin : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    PORT_nin : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    PORT_qin : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    PORT_sin : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
    PORT_vout : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
    PORT_nout : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
    PORT_qout : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
    PORT_sout : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
    PORT_spike_flag : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    address : in STD_LOGIC_VECTOR(6 DOWNTO 0)
);
end RSexci;
architecture Behavioral of RSexci is

COMPONENT shifter is
    Port ( clk : in STD_LOGIC;
           sign_extend : in  STD_LOGIC;
           shift_amt  : in  STD_LOGIC_VECTOR (4 downto 0);         
           data_in     : in  STD_LOGIC_VECTOR (17 downto 0);
           data_out    : out STD_LOGIC_VECTOR (37 downto 0));
END COMPONENT;

-- 00100001010011001000010010101101100 : 10A64256C
COMPONENT rom1 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta    : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 0010100111010010101101100 : 53A56C
COMPONENT rom2 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta    : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 000100011101001010100110101110 : 474A9AE
COMPONENT rom3 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta    : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 000100011101001010100110101110 : 474A9AE
COMPONENT rom_4 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta    : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 001000011101000 : 10E8
COMPONENT rom5 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 001000011101000 : 10E8
COMPONENT rom6 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 000010001100100001100101001100 : 232194C
COMPONENT rom7 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 00110 : 6
COMPONENT rom8 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 00011001010100001011 : 1950B
COMPONENT rom9 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 001110100001010 : 1D0A
COMPONENT rom10 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 0011000111010000100101011011000111001111 : 31D095B1CF
COMPONENT rom11 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 00110 : 6
COMPONENT rom12 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 01100011111000010001100101001110100 : 31F08CA74
COMPONENT rom13 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR(49 downto 0));
END COMPONENT;
-- 0011101001011100111110000100011001010011 : 3A5CF84653
COMPONENT rom14 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 010000110001101011100111110000 : 10C6B9F0
COMPONENT rom15 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 00010001010011101000010010101001011011010111010010 : 453A12A5B5D2
COMPONENT rom16 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;
-- 01010011100111110000 : 539F0
COMPONENT rom17 is
    Port ( clka : in STD_LOGIC;
           addra : in  STD_LOGIC_vector(6 downto 0);
           douta : out STD_LOGIC_VECTOR (49 downto 0));
END COMPONENT;

    signal out_rom1   : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom2   : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom3   : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom4   : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom5   : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom6   : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom7   : STD_LOGIC_VECTOR (49 downto 0);    
    signal out_rom8   : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom9   : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom10  : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom11  : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom12  : STD_LOGIC_VECTOR (49 downto 0); 
    signal out_rom13  : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom14  : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom15  : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom16  : STD_LOGIC_VECTOR (49 downto 0);
    signal out_rom17  : STD_LOGIC_VECTOR (49 downto 0);
    
    signal shift_amt01_1 : std_logic_vector(4 downto 0);
    signal shift_amt01_2 : std_logic_vector(4 downto 0);
    signal shift_amt01_3 : std_logic_vector(4 downto 0);
    signal shift_amt01_4 : std_logic_vector(4 downto 0);
    signal shift_amt01_5 : std_logic_vector(4 downto 0);
    signal shift_amt01_6 : std_logic_vector(4 downto 0);
    signal shift_amt01_7 : std_logic_vector(4 downto 0);
    signal shift_amt01_8 : std_logic_vector(4 downto 0);
    signal shift_amt01_9 : std_logic_vector(4 downto 0);
    signal shift_amt01_10: std_logic_vector(4 downto 0);
    
    signal v_vv_vS0_1  : std_logic_vector(37 downto 0);
    signal v_vv_vS0_2  : std_logic_vector(37 downto 0);
    signal v_vv_vS0_3  : std_logic_vector(37 downto 0);
    signal v_vv_vS0_4  : std_logic_vector(37 downto 0);
    signal v_vv_vS0_5  : std_logic_vector(37 downto 0);
    signal v_vv_vS0_6  : std_logic_vector(37 downto 0);
    signal v_vv_vS0_7  : std_logic_vector(37 downto 0);
    signal v_vv_vS0_8  : std_logic_vector(37 downto 0);
    signal v_vv_vS0_9  : std_logic_vector(37 downto 0);
    signal v_vv_vS0_10  : std_logic_vector(37 downto 0);
    
    signal v_vv_vS_a : std_logic_vector(37 downto 0);
    signal v_vv_vS_b : std_logic_vector(37 downto 0);
    signal v_vv_vS_c : std_logic_vector(37 downto 0);
    signal v_vv_vS_d : std_logic_vector(37 downto 0);
    signal v_vv_vS_e : std_logic_vector(37 downto 0);
    signal v_vv_vS_ea : std_logic_vector(37 downto 0);
    signal v_vv_vS_f : std_logic_vector(37 downto 0);
    signal v_vv_vS_g : std_logic_vector(37 downto 0);
    signal v_vv_vS_h : std_logic_vector(37 downto 0);
    
    signal shift_amt02_1 : std_logic_vector(4 downto 0);
    signal shift_amt02_2 : std_logic_vector(4 downto 0);
    signal shift_amt02_3 : std_logic_vector(4 downto 0);
    signal shift_amt02_4 : std_logic_vector(4 downto 0);
    signal shift_amt02_5 : std_logic_vector(4 downto 0);
    signal shift_amt02_6 : std_logic_vector(4 downto 0);
    signal shift_amt02_7 : std_logic_vector(4 downto 0);
    signal shift_amt02_8 : std_logic_vector(4 downto 0);
    signal shift_amt02_9 : std_logic_vector(4 downto 0);
    signal shift_amt02_10: std_logic_vector(4 downto 0);
    
    signal v_vv_vL0_1  : std_logic_vector(37 downto 0);
    signal v_vv_vL0_2  : std_logic_vector(37 downto 0);
    signal v_vv_vL0_3  : std_logic_vector(37 downto 0);
    signal v_vv_vL0_4  : std_logic_vector(37 downto 0);
    signal v_vv_vL0_5  : std_logic_vector(37 downto 0);
    signal v_vv_vL0_6  : std_logic_vector(37 downto 0);
    signal v_vv_vL0_7  : std_logic_vector(37 downto 0);
    signal v_vv_vL0_8  : std_logic_vector(37 downto 0);
    signal v_vv_vL0_9  : std_logic_vector(37 downto 0);
    signal v_vv_vL0_10  : std_logic_vector(37 downto 0);
    
    signal v_vv_vL_a : std_logic_vector(37 downto 0);
    signal v_vv_vL_b : std_logic_vector(37 downto 0);
    signal v_vv_vL_c : std_logic_vector(37 downto 0);
    signal v_vv_vL_d : std_logic_vector(37 downto 0);
    signal v_vv_vL_e : std_logic_vector(37 downto 0);
    signal v_vv_vL_ea : std_logic_vector(37 downto 0);
    signal v_vv_vL_f: std_logic_vector(37 downto 0);
    signal v_vv_vL_g : std_logic_vector(37 downto 0);
    signal v_vv_vL_h : std_logic_vector(37 downto 0);
    
    signal shift_amt03_1 : std_logic_vector(4 downto 0);
    signal shift_amt03_2 : std_logic_vector(4 downto 0);
    signal shift_amt03_3 : std_logic_vector(4 downto 0);
    signal shift_amt03_4 : std_logic_vector(4 downto 0);
    signal shift_amt03_5 : std_logic_vector(4 downto 0);
    signal shift_amt03_6 : std_logic_vector(4 downto 0);
    signal shift_amt03_7 : std_logic_vector(4 downto 0);
    signal shift_amt03_8 : std_logic_vector(4 downto 0);
    signal shift_amt03_9 : std_logic_vector(4 downto 0);
    signal shift_amt03_10: std_logic_vector(4 downto 0);
    
    signal v_v_vS0_1  : std_logic_vector(37 downto 0);
    signal v_v_vS0_2  : std_logic_vector(37 downto 0);
    signal v_v_vS0_3  : std_logic_vector(37 downto 0);
    signal v_v_vS0_4  : std_logic_vector(37 downto 0);
    signal v_v_vS0_5  : std_logic_vector(37 downto 0);
    signal v_v_vS0_6  : std_logic_vector(37 downto 0);
    signal v_v_vS0_7  : std_logic_vector(37 downto 0);
    signal v_v_vS0_8  : std_logic_vector(37 downto 0);
    signal v_v_vS0_9  : std_logic_vector(37 downto 0);
    signal v_v_vS0_10  : std_logic_vector(37 downto 0);
    
    signal v_v_vS_a : std_logic_vector(37 downto 0);
    signal v_v_vS_b : std_logic_vector(37 downto 0);
    signal v_v_vS_c : std_logic_vector(37 downto 0);
    signal v_v_vS_d : std_logic_vector(37 downto 0);
    signal v_v_vS_e : std_logic_vector(37 downto 0);
    signal v_v_vS_ea : std_logic_vector(37 downto 0);
    signal v_v_vS_f : std_logic_vector(37 downto 0);
    signal v_v_vS_g : std_logic_vector(37 downto 0);
    signal v_v_vS_h : std_logic_vector(37 downto 0);
    
    signal shift_amt04_1 : std_logic_vector(4 downto 0);
    signal shift_amt04_2 : std_logic_vector(4 downto 0);
    signal shift_amt04_3 : std_logic_vector(4 downto 0);
    signal shift_amt04_4 : std_logic_vector(4 downto 0);
    signal shift_amt04_5 : std_logic_vector(4 downto 0);
    signal shift_amt04_6 : std_logic_vector(4 downto 0);
    signal shift_amt04_7 : std_logic_vector(4 downto 0);
    signal shift_amt04_8 : std_logic_vector(4 downto 0);
    signal shift_amt04_9 : std_logic_vector(4 downto 0);
    signal shift_amt04_10: std_logic_vector(4 downto 0);
    
    signal v_v_vL0_1  : std_logic_vector(37 downto 0);
    signal v_v_vL0_2  : std_logic_vector(37 downto 0);
    signal v_v_vL0_3  : std_logic_vector(37 downto 0);
    signal v_v_vL0_4  : std_logic_vector(37 downto 0);
    signal v_v_vL0_5  : std_logic_vector(37 downto 0);
    signal v_v_vL0_6  : std_logic_vector(37 downto 0);
    signal v_v_vL0_7  : std_logic_vector(37 downto 0);
    signal v_v_vL0_8  : std_logic_vector(37 downto 0);
    signal v_v_vL0_9  : std_logic_vector(37 downto 0);
    signal v_v_vL0_10  : std_logic_vector(37 downto 0);
    
    signal v_v_vL_a : std_logic_vector(37 downto 0);
    signal v_v_vL_b : std_logic_vector(37 downto 0);
    signal v_v_vL_c : std_logic_vector(37 downto 0);
    signal v_v_vL_d : std_logic_vector(37 downto 0);
    signal v_v_vL_e : std_logic_vector(37 downto 0);
    signal v_v_vL_ea : std_logic_vector(37 downto 0);
    signal v_v_vL_f : std_logic_vector(37 downto 0);
    signal v_v_vL_g : std_logic_vector(37 downto 0);
    signal v_v_vL_h : std_logic_vector(37 downto 0);
    
    signal shift_amt05_1 : std_logic_vector(4 downto 0);
    signal shift_amt05_2 : std_logic_vector(4 downto 0);
    signal shift_amt05_3 : std_logic_vector(4 downto 0);
    signal shift_amt05_4 : std_logic_vector(4 downto 0);
    signal shift_amt05_5 : std_logic_vector(4 downto 0);
    signal shift_amt05_6 : std_logic_vector(4 downto 0);
    signal shift_amt05_7 : std_logic_vector(4 downto 0);
    signal shift_amt05_8 : std_logic_vector(4 downto 0);
    signal shift_amt05_9 : std_logic_vector(4 downto 0);
    signal shift_amt05_10: std_logic_vector(4 downto 0);
    
    signal v_n0_1  : std_logic_vector(37 downto 0);
    signal v_n0_2  : std_logic_vector(37 downto 0);
    signal v_n0_3  : std_logic_vector(37 downto 0);
    signal v_n0_4  : std_logic_vector(37 downto 0);
    signal v_n0_5  : std_logic_vector(37 downto 0);
    signal v_n0_6  : std_logic_vector(37 downto 0);
    signal v_n0_7  : std_logic_vector(37 downto 0);
    signal v_n0_8  : std_logic_vector(37 downto 0);
    signal v_n0_9  : std_logic_vector(37 downto 0);
    signal v_n0_10  : std_logic_vector(37 downto 0);
    
    signal v_n_a  : std_logic_vector(37 downto 0);
    signal v_n_b  : std_logic_vector(37 downto 0);
    signal v_n_c  : std_logic_vector(37 downto 0);
    signal v_n_d  : std_logic_vector(37 downto 0);
    signal v_n_e  : std_logic_vector(37 downto 0);
    signal v_n_ea  : std_logic_vector(37 downto 0);
    signal v_n_f  : std_logic_vector(37 downto 0);
    signal v_n_g  : std_logic_vector(37 downto 0);
    signal v_n_h  : std_logic_vector(37 downto 0);
    
    signal shift_amt06_1 : std_logic_vector(4 downto 0);
    signal shift_amt06_2 : std_logic_vector(4 downto 0);
    signal shift_amt06_3 : std_logic_vector(4 downto 0);
    signal shift_amt06_4 : std_logic_vector(4 downto 0);
    signal shift_amt06_5 : std_logic_vector(4 downto 0);
    signal shift_amt06_6 : std_logic_vector(4 downto 0);
    signal shift_amt06_7 : std_logic_vector(4 downto 0);
    signal shift_amt06_8 : std_logic_vector(4 downto 0);
    signal shift_amt06_9 : std_logic_vector(4 downto 0);
    signal shift_amt06_10: std_logic_vector(4 downto 0);
    
    signal v_q0_1  : std_logic_vector(37 downto 0);
    signal v_q0_2  : std_logic_vector(37 downto 0);
    signal v_q0_3  : std_logic_vector(37 downto 0);
    signal v_q0_4  : std_logic_vector(37 downto 0);
    signal v_q0_5  : std_logic_vector(37 downto 0);
    signal v_q0_6  : std_logic_vector(37 downto 0);
    signal v_q0_7  : std_logic_vector(37 downto 0);
    signal v_q0_8  : std_logic_vector(37 downto 0);
    signal v_q0_9  : std_logic_vector(37 downto 0);
    signal v_q0_10  : std_logic_vector(37 downto 0);
    
    signal v_q_a  : std_logic_vector(37 downto 0);
    signal v_q_b  : std_logic_vector(37 downto 0);
    signal v_q_c  : std_logic_vector(37 downto 0);
    signal v_q_d  : std_logic_vector(37 downto 0);
    signal v_q_e  : std_logic_vector(37 downto 0);
    signal v_q_ea  : std_logic_vector(37 downto 0);
    signal v_q_f  : std_logic_vector(37 downto 0);
    signal v_q_g  : std_logic_vector(37 downto 0);
    signal v_q_h  : std_logic_vector(37 downto 0);
    
    signal shift_amt07_1 : std_logic_vector(4 downto 0);
    signal shift_amt07_2 : std_logic_vector(4 downto 0);
    signal shift_amt07_3 : std_logic_vector(4 downto 0);
    signal shift_amt07_4 : std_logic_vector(4 downto 0);
    signal shift_amt07_5 : std_logic_vector(4 downto 0);
    signal shift_amt07_6 : std_logic_vector(4 downto 0);
    signal shift_amt07_7 : std_logic_vector(4 downto 0);
    signal shift_amt07_8 : std_logic_vector(4 downto 0);
    signal shift_amt07_9 : std_logic_vector(4 downto 0);
    signal shift_amt07_10: std_logic_vector(4 downto 0);
    
    signal v_iin0_0a  : std_logic_vector(37 downto 0);
    signal v_iin0_0  : std_logic_vector(37 downto 0);
    signal v_iin0_1  : std_logic_vector(37 downto 0);
    signal v_iin0_2  : std_logic_vector(37 downto 0);
    signal v_iin0_3  : std_logic_vector(37 downto 0);
    signal v_iin0_4  : std_logic_vector(37 downto 0);
    signal v_iin0_5  : std_logic_vector(37 downto 0);
    signal v_iin0_6  : std_logic_vector(37 downto 0);
    signal v_iin0_7  : std_logic_vector(37 downto 0);
    signal v_iin0_8  : std_logic_vector(37 downto 0);
    signal v_iin0_9  : std_logic_vector(37 downto 0);
    signal v_iin0_10  : std_logic_vector(37 downto 0);
    
    signal v_iin_a : std_logic_vector(37 downto 0);
    signal v_iin_b : std_logic_vector(37 downto 0);
    signal v_iin_c : std_logic_vector(37 downto 0);
    signal v_iin_d : std_logic_vector(37 downto 0);
    signal v_iin_e : std_logic_vector(37 downto 0);
    signal v_iin_ea : std_logic_vector(37 downto 0);
    signal v_iin_f: std_logic_vector(37 downto 0);
    signal v_iin_g : std_logic_vector(37 downto 0);
    signal v_iin_h : std_logic_vector(37 downto 0);
    signal v_iin_i: std_logic_vector(37 downto 0);
    
    signal shift_amt08_1 : std_logic_vector(4 downto 0);
    signal shift_amt08_2 : std_logic_vector(4 downto 0);
    signal shift_amt08_3 : std_logic_vector(4 downto 0);
    signal shift_amt08_4 : std_logic_vector(4 downto 0);
    signal shift_amt08_5 : std_logic_vector(4 downto 0);
    signal shift_amt08_6 : std_logic_vector(4 downto 0);
    signal shift_amt08_7 : std_logic_vector(4 downto 0);
    signal shift_amt08_8 : std_logic_vector(4 downto 0);
    signal shift_amt08_9 : std_logic_vector(4 downto 0);
    signal shift_amt08_10: std_logic_vector(4 downto 0);
    
    signal n_vv_vS0_1  : std_logic_vector(37 downto 0);
    signal n_vv_vS0_2  : std_logic_vector(37 downto 0);
    signal n_vv_vS0_3  : std_logic_vector(37 downto 0);
    signal n_vv_vS0_4  : std_logic_vector(37 downto 0);
    signal n_vv_vS0_5  : std_logic_vector(37 downto 0);
    signal n_vv_vS0_6  : std_logic_vector(37 downto 0);
    signal n_vv_vS0_7  : std_logic_vector(37 downto 0);
    signal n_vv_vS0_8  : std_logic_vector(37 downto 0);
    signal n_vv_vS0_9  : std_logic_vector(37 downto 0);
    signal n_vv_vS0_10  : std_logic_vector(37 downto 0);
    
    signal n_vv_vS_a  : std_logic_vector(37 downto 0);
    signal n_vv_vS_b  : std_logic_vector(37 downto 0);
    signal n_vv_vS_c  : std_logic_vector(37 downto 0);
    signal n_vv_vS_d  : std_logic_vector(37 downto 0);
    signal n_vv_vS_e  : std_logic_vector(37 downto 0);
    signal n_vv_vS_ea  : std_logic_vector(37 downto 0);
    signal n_vv_vS_f  : std_logic_vector(37 downto 0);
    signal n_vv_vS_g  : std_logic_vector(37 downto 0);
    signal n_vv_vS_h  : std_logic_vector(37 downto 0);
    
    signal shift_amt09_1 : std_logic_vector(4 downto 0);
    signal shift_amt09_2 : std_logic_vector(4 downto 0);
    signal shift_amt09_3 : std_logic_vector(4 downto 0);
    signal shift_amt09_4 : std_logic_vector(4 downto 0);
    signal shift_amt09_5 : std_logic_vector(4 downto 0);
    signal shift_amt09_6 : std_logic_vector(4 downto 0);
    signal shift_amt09_7 : std_logic_vector(4 downto 0);
    signal shift_amt09_8 : std_logic_vector(4 downto 0);
    signal shift_amt09_9 : std_logic_vector(4 downto 0);
    signal shift_amt09_10: std_logic_vector(4 downto 0);
    
    signal n_vv_vL0_1  : std_logic_vector(37 downto 0);
    signal n_vv_vL0_2  : std_logic_vector(37 downto 0);
    signal n_vv_vL0_3  : std_logic_vector(37 downto 0);
    signal n_vv_vL0_4  : std_logic_vector(37 downto 0);
    signal n_vv_vL0_5  : std_logic_vector(37 downto 0);
    signal n_vv_vL0_6  : std_logic_vector(37 downto 0);
    signal n_vv_vL0_7  : std_logic_vector(37 downto 0);
    signal n_vv_vL0_8  : std_logic_vector(37 downto 0);
    signal n_vv_vL0_9  : std_logic_vector(37 downto 0);
    signal n_vv_vL0_10  : std_logic_vector(37 downto 0);
    
    signal n_vv_vL_a  : std_logic_vector(37 downto 0);
    signal n_vv_vL_b  : std_logic_vector(37 downto 0);
    signal n_vv_vL_c  : std_logic_vector(37 downto 0);
    signal n_vv_vL_d  : std_logic_vector(37 downto 0);
    signal n_vv_vL_e  : std_logic_vector(37 downto 0);
    signal n_vv_vL_ea  : std_logic_vector(37 downto 0);
    signal n_vv_vL_f  : std_logic_vector(37 downto 0);
    signal n_vv_vL_g  : std_logic_vector(37 downto 0);
    signal n_vv_vL_h  : std_logic_vector(37 downto 0);
    
    signal shift_amt10_1 : std_logic_vector(4 downto 0); 
    signal shift_amt10_2 : std_logic_vector(4 downto 0);
    signal shift_amt10_3 : std_logic_vector(4 downto 0); 
    signal shift_amt10_4 : std_logic_vector(4 downto 0); 
    signal shift_amt10_5 : std_logic_vector(4 downto 0); 
    signal shift_amt10_6 : std_logic_vector(4 downto 0); 
    signal shift_amt10_7 : std_logic_vector(4 downto 0); 
    signal shift_amt10_8 : std_logic_vector(4 downto 0);
    signal shift_amt10_9 : std_logic_vector(4 downto 0);
    signal shift_amt10_10: std_logic_vector(4 downto 0);
    
    signal n_v_vS0_1  : std_logic_vector(37 downto 0);
    signal n_v_vS0_2  : std_logic_vector(37 downto 0);
    signal n_v_vS0_3  : std_logic_vector(37 downto 0);
    signal n_v_vS0_4  : std_logic_vector(37 downto 0);
    signal n_v_vS0_5  : std_logic_vector(37 downto 0);
    signal n_v_vS0_6  : std_logic_vector(37 downto 0);
    signal n_v_vS0_7  : std_logic_vector(37 downto 0);
    signal n_v_vS0_8  : std_logic_vector(37 downto 0);
    signal n_v_vS0_9  : std_logic_vector(37 downto 0);
    signal n_v_vS0_10  : std_logic_vector(37 downto 0);
    
    signal n_v_vS_a : std_logic_vector(37 downto 0);
    signal n_v_vS_b : std_logic_vector(37 downto 0);
    signal n_v_vS_c : std_logic_vector(37 downto 0);
    signal n_v_vS_d : std_logic_vector(37 downto 0);
    signal n_v_vS_e : std_logic_vector(37 downto 0);
    signal n_v_vS_ea : std_logic_vector(37 downto 0);
    signal n_v_vS_f : std_logic_vector(37 downto 0);
    signal n_v_vS_g : std_logic_vector(37 downto 0);
    signal n_v_vS_h : std_logic_vector(37 downto 0);
    
    signal shift_amt11_1 : std_logic_vector(4 downto 0); 
    signal shift_amt11_2 : std_logic_vector(4 downto 0); 
    signal shift_amt11_3 : std_logic_vector(4 downto 0); 
    signal shift_amt11_4 : std_logic_vector(4 downto 0); 
    signal shift_amt11_5 : std_logic_vector(4 downto 0); 
    signal shift_amt11_6 : std_logic_vector(4 downto 0); 
    signal shift_amt11_7 : std_logic_vector(4 downto 0); 
    signal shift_amt11_8 : std_logic_vector(4 downto 0);
    signal shift_amt11_9 : std_logic_vector(4 downto 0); 
    signal shift_amt11_10: std_logic_vector(4 downto 0);
    
    signal n_v_vL0_1  : std_logic_vector(37 downto 0);
    signal n_v_vL0_2  : std_logic_vector(37 downto 0);
    signal n_v_vL0_3  : std_logic_vector(37 downto 0);
    signal n_v_vL0_4  : std_logic_vector(37 downto 0);
    signal n_v_vL0_5  : std_logic_vector(37 downto 0);
    signal n_v_vL0_6  : std_logic_vector(37 downto 0);
    signal n_v_vL0_7  : std_logic_vector(37 downto 0);
    signal n_v_vL0_8 : std_logic_vector(37 downto 0);
    signal n_v_vL0_9  : std_logic_vector(37 downto 0);
    signal n_v_vL0_10 : std_logic_vector(37 downto 0);
    
    signal n_v_vL_a : std_logic_vector(37 downto 0);
    signal n_v_vL_b : std_logic_vector(37 downto 0);
    signal n_v_vL_c : std_logic_vector(37 downto 0);
    signal n_v_vL_d : std_logic_vector(37 downto 0);
    signal n_v_vL_e : std_logic_vector(37 downto 0);
    signal n_v_vL_ea : std_logic_vector(37 downto 0);
    signal n_v_vL_f : std_logic_vector(37 downto 0);
    signal n_v_vL_g : std_logic_vector(37 downto 0);
    signal n_v_vL_h : std_logic_vector(37 downto 0);
    
    signal shift_amt12_1 : std_logic_vector(4 downto 0); 
    signal shift_amt12_2 : std_logic_vector(4 downto 0); 
    signal shift_amt12_3 : std_logic_vector(4 downto 0); 
    signal shift_amt12_4 : std_logic_vector(4 downto 0); 
    signal shift_amt12_5 : std_logic_vector(4 downto 0); 
    signal shift_amt12_6 : std_logic_vector(4 downto 0); 
    signal shift_amt12_7 : std_logic_vector(4 downto 0); 
    signal shift_amt12_8 : std_logic_vector(4 downto 0);
    signal shift_amt12_9 : std_logic_vector(4 downto 0);
    signal shift_amt12_10: std_logic_vector(4 downto 0);
    
    signal n_n0_1  : std_logic_vector(37 downto 0);
    signal n_n0_2  : std_logic_vector(37 downto 0);
    signal n_n0_3  : std_logic_vector(37 downto 0);
    signal n_n0_4  : std_logic_vector(37 downto 0);
    signal n_n0_5  : std_logic_vector(37 downto 0);
    signal n_n0_6  : std_logic_vector(37 downto 0);
    signal n_n0_7  : std_logic_vector(37 downto 0);
    signal n_n0_8  : std_logic_vector(37 downto 0);
    signal n_n0_9  : std_logic_vector(37 downto 0);
    signal n_n0_10  : std_logic_vector(37 downto 0);
   
    signal n_n_a  : std_logic_vector(37 downto 0);
    signal n_n_b  : std_logic_vector(37 downto 0);
    signal n_n_c  : std_logic_vector(37 downto 0);
    signal n_n_d  : std_logic_vector(37 downto 0);
    signal n_n_e  : std_logic_vector(37 downto 0);
    signal n_n_ea  : std_logic_vector(37 downto 0);
    signal n_n_f  : std_logic_vector(37 downto 0);
    signal n_n_g  : std_logic_vector(37 downto 0);
    signal n_n_h  : std_logic_vector(37 downto 0);
    
    signal shift_amt13_1 : std_logic_vector(4 downto 0); 
    signal shift_amt13_2 : std_logic_vector(4 downto 0); 
    signal shift_amt13_3 : std_logic_vector(4 downto 0); 
    signal shift_amt13_4 : std_logic_vector(4 downto 0); 
    signal shift_amt13_5 : std_logic_vector(4 downto 0); 
    signal shift_amt13_6 : std_logic_vector(4 downto 0); 
    signal shift_amt13_7 : std_logic_vector(4 downto 0); 
    signal shift_amt13_8 : std_logic_vector(4 downto 0); 
    signal shift_amt13_9 : std_logic_vector(4 downto 0); 
    signal shift_amt13_10: std_logic_vector(4 downto 0); 
    
    signal q_vv_vS0_1  : std_logic_vector(37 downto 0);
    signal q_vv_vS0_2  : std_logic_vector(37 downto 0);
    signal q_vv_vS0_3  : std_logic_vector(37 downto 0);
    signal q_vv_vS0_4  : std_logic_vector(37 downto 0);
    signal q_vv_vS0_5  : std_logic_vector(37 downto 0);
    signal q_vv_vS0_6  : std_logic_vector(37 downto 0);
    signal q_vv_vS0_7  : std_logic_vector(37 downto 0);
    signal q_vv_vS0_8  : std_logic_vector(37 downto 0);
    signal q_vv_vS0_9  : std_logic_vector(37 downto 0);
    signal q_vv_vS0_10  : std_logic_vector(37 downto 0);
    
    signal q_vv_vS_a : std_logic_vector(37 downto 0);
    signal q_vv_vS_b : std_logic_vector(37 downto 0);
    signal q_vv_vS_c : std_logic_vector(37 downto 0);
    signal q_vv_vS_d : std_logic_vector(37 downto 0);
    signal q_vv_vS_e : std_logic_vector(37 downto 0);
    signal q_vv_vS_ea : std_logic_vector(37 downto 0);
    signal q_vv_vS_f : std_logic_vector(37 downto 0);
    signal q_vv_vS_g : std_logic_vector(37 downto 0);
    signal q_vv_vS_h : std_logic_vector(37 downto 0);
    
    signal shift_amt14_1 : std_logic_vector(4 downto 0); 
    signal shift_amt14_2 : std_logic_vector(4 downto 0); 
    signal shift_amt14_3 : std_logic_vector(4 downto 0); 
    signal shift_amt14_4 : std_logic_vector(4 downto 0); 
    signal shift_amt14_5 : std_logic_vector(4 downto 0); 
    signal shift_amt14_6 : std_logic_vector(4 downto 0); 
    signal shift_amt14_7 : std_logic_vector(4 downto 0); 
    signal shift_amt14_8 : std_logic_vector(4 downto 0);
    signal shift_amt14_9 : std_logic_vector(4 downto 0); 
    signal shift_amt14_10: std_logic_vector(4 downto 0);
    
    signal q_vv_vL0_1  : std_logic_vector(37 downto 0);
    signal q_vv_vL0_2  : std_logic_vector(37 downto 0);
    signal q_vv_vL0_3  : std_logic_vector(37 downto 0);
    signal q_vv_vL0_4  : std_logic_vector(37 downto 0);
    signal q_vv_vL0_5  : std_logic_vector(37 downto 0);
    signal q_vv_vL0_6  : std_logic_vector(37 downto 0);
    signal q_vv_vL0_7  : std_logic_vector(37 downto 0);
    signal q_vv_vL0_8  : std_logic_vector(37 downto 0);
    signal q_vv_vL0_9  : std_logic_vector(37 downto 0);
    signal q_vv_vL0_10 : std_logic_vector(37 downto 0);
    
    signal q_vv_vL_a : std_logic_vector(37 downto 0);
    signal q_vv_vL_b : std_logic_vector(37 downto 0);
    signal q_vv_vL_c : std_logic_vector(37 downto 0);
    signal q_vv_vL_d : std_logic_vector(37 downto 0);
    signal q_vv_vL_e : std_logic_vector(37 downto 0);
    signal q_vv_vL_ea : std_logic_vector(37 downto 0);
    signal q_vv_vL_f : std_logic_vector(37 downto 0);
    signal q_vv_vL_g : std_logic_vector(37 downto 0);
    signal q_vv_vL_h : std_logic_vector(37 downto 0);
    
    signal shift_amt15_1 : std_logic_vector(4 downto 0); 
    signal shift_amt15_2 : std_logic_vector(4 downto 0); 
    signal shift_amt15_3 : std_logic_vector(4 downto 0); 
    signal shift_amt15_4 : std_logic_vector(4 downto 0); 
    signal shift_amt15_5 : std_logic_vector(4 downto 0); 
    signal shift_amt15_6 : std_logic_vector(4 downto 0); 
    signal shift_amt15_7 : std_logic_vector(4 downto 0); 
    signal shift_amt15_8 : std_logic_vector(4 downto 0);
    signal shift_amt15_9 : std_logic_vector(4 downto 0);
    signal shift_amt15_10: std_logic_vector(4 downto 0);
    
    signal q_v_vS0_1  : std_logic_vector(37 downto 0);
    signal q_v_vS0_2  : std_logic_vector(37 downto 0);
    signal q_v_vS0_3  : std_logic_vector(37 downto 0);
    signal q_v_vS0_4  : std_logic_vector(37 downto 0);
    signal q_v_vS0_5  : std_logic_vector(37 downto 0);
    signal q_v_vS0_6  : std_logic_vector(37 downto 0);
    signal q_v_vS0_7  : std_logic_vector(37 downto 0);
    signal q_v_vS0_8  : std_logic_vector(37 downto 0);
    signal q_v_vS0_9  : std_logic_vector(37 downto 0);
    signal q_v_vS0_10  : std_logic_vector(37 downto 0);
    
    signal q_v_vS_a : std_logic_vector(37 downto 0);
    signal q_v_vS_b : std_logic_vector(37 downto 0);
    signal q_v_vS_c : std_logic_vector(37 downto 0);
    signal q_v_vS_d : std_logic_vector(37 downto 0);
    signal q_v_vS_e : std_logic_vector(37 downto 0);
    signal q_v_vS_ea : std_logic_vector(37 downto 0);
    signal q_v_vS_f : std_logic_vector(37 downto 0);
    signal q_v_vS_g : std_logic_vector(37 downto 0);
    signal q_v_vS_h : std_logic_vector(37 downto 0);
    
    signal shift_amt16_1 : std_logic_vector(4 downto 0); 
    signal shift_amt16_2 : std_logic_vector(4 downto 0); 
    signal shift_amt16_3 : std_logic_vector(4 downto 0); 
    signal shift_amt16_4 : std_logic_vector(4 downto 0); 
    signal shift_amt16_5 : std_logic_vector(4 downto 0); 
    signal shift_amt16_6 : std_logic_vector(4 downto 0); 
    signal shift_amt16_7 : std_logic_vector(4 downto 0); 
    signal shift_amt16_8 : std_logic_vector(4 downto 0);
    signal shift_amt16_9 : std_logic_vector(4 downto 0);
    signal shift_amt16_10: std_logic_vector(4 downto 0);
    
    signal q_v_vL0_1  : std_logic_vector(37 downto 0);
    signal q_v_vL0_2  : std_logic_vector(37 downto 0);
    signal q_v_vL0_3  : std_logic_vector(37 downto 0);
    signal q_v_vL0_4  : std_logic_vector(37 downto 0);
    signal q_v_vL0_5  : std_logic_vector(37 downto 0);
    signal q_v_vL0_6  : std_logic_vector(37 downto 0);
    signal q_v_vL0_7  : std_logic_vector(37 downto 0);
    signal q_v_vL0_8  : std_logic_vector(37 downto 0);
    signal q_v_vL0_9  : std_logic_vector(37 downto 0);
    signal q_v_vL0_10 : std_logic_vector(37 downto 0);
    
    signal q_v_vL_a : std_logic_vector(37 downto 0);
    signal q_v_vL_b : std_logic_vector(37 downto 0);
    signal q_v_vL_c : std_logic_vector(37 downto 0);
    signal q_v_vL_d : std_logic_vector(37 downto 0);
    signal q_v_vL_e : std_logic_vector(37 downto 0);
    signal q_v_vL_ea: std_logic_vector(37 downto 0);
    signal q_v_vL_f : std_logic_vector(37 downto 0);
    signal q_v_vL_g : std_logic_vector(37 downto 0);
    signal q_v_vL_h : std_logic_vector(37 downto 0);
    
    signal shift_amt17_1 : std_logic_vector(4 downto 0); 
    signal shift_amt17_2 : std_logic_vector(4 downto 0); 
    signal shift_amt17_3 : std_logic_vector(4 downto 0); 
    signal shift_amt17_4 : std_logic_vector(4 downto 0); 
    signal shift_amt17_5 : std_logic_vector(4 downto 0); 
    signal shift_amt17_6 : std_logic_vector(4 downto 0); 
    signal shift_amt17_7 : std_logic_vector(4 downto 0); 
    signal shift_amt17_8 : std_logic_vector(4 downto 0);
    signal shift_amt17_9 : std_logic_vector(4 downto 0);
    signal shift_amt17_10: std_logic_vector(4 downto 0);
    
    signal q_q0_1  : std_logic_vector(37 downto 0);
    signal q_q0_2  : std_logic_vector(37 downto 0);
    signal q_q0_3  : std_logic_vector(37 downto 0);
    signal q_q0_4  : std_logic_vector(37 downto 0);
    signal q_q0_5  : std_logic_vector(37 downto 0);
    signal q_q0_6  : std_logic_vector(37 downto 0);
    signal q_q0_7  : std_logic_vector(37 downto 0);
    signal q_q0_8  : std_logic_vector(37 downto 0);
    signal q_q0_9  : std_logic_vector(37 downto 0);
    signal q_q0_10  : std_logic_vector(37 downto 0);
    
    signal q_q_a  : std_logic_vector(37 downto 0);
    signal q_q_b  : std_logic_vector(37 downto 0);
    signal q_q_c  : std_logic_vector(37 downto 0);
    signal q_q_d  : std_logic_vector(37 downto 0);
    signal q_q_e  : std_logic_vector(37 downto 0);
    signal q_q_ea  : std_logic_vector(37 downto 0);
    signal q_q_f  : std_logic_vector(37 downto 0);
    signal q_q_g  : std_logic_vector(37 downto 0);
    signal q_q_h  : std_logic_vector(37 downto 0);
    
    signal q_q_6th_29 : std_logic_vector(37 downto 0);
    signal q_q_6th : std_logic_vector(17 downto 0);
    
    signal q_vv_vL_6th_29 : std_logic_vector(37 downto 0);
    signal q_vv_vL_6th : std_logic_vector(17 downto 0);
    signal q_vv_vS_6th_29 : std_logic_vector(37 downto 0);
    signal q_vv_vS_6th : std_logic_vector(17 downto 0);
    signal q_v_vS_6th_29 : std_logic_vector(37 downto 0);
    signal q_v_vS_6th : std_logic_vector(17 downto 0);
    signal n_vv_vL_6th_29 : std_logic_vector(37 downto 0);
    signal n_vv_vL_6th : std_logic_vector(17 downto 0);
    signal n_v_vS_6th_29 : std_logic_vector(37 downto 0);
    signal n_v_vS_6th : std_logic_vector(17 downto 0);
    signal n_n_6th_29 : std_logic_vector(37 downto 0);
    signal n_n_6th : std_logic_vector(17 downto 0);
    signal n_vv_vS_6th_29 : std_logic_vector(37 downto 0);
    signal n_vv_vS_6th : std_logic_vector(17 downto 0);
    signal v_vv_vS_6th_29 : std_logic_vector(37 downto 0);
    signal v_vv_vS_6th : std_logic_vector(17 downto 0);
    signal v_v_vS_6th_29 : std_logic_vector(37 downto 0);
    signal v_v_vL_6th_29 : std_logic_vector(37 downto 0);
    signal v_v_vS_6th : std_logic_vector(17 downto 0);
    signal v_v_vL_6th : std_logic_vector(17 downto 0);
    signal v_n_6th_29 : std_logic_vector(37 downto 0);
    signal v_n_6th : std_logic_vector(17 downto 0);
    signal v_q_6th_29 : std_logic_vector(37 downto 0);
    signal v_q_6th : std_logic_vector(17 downto 0);
    signal v_iin_6th_29 : std_logic_vector(37 downto 0);
    signal v_iin_6th : std_logic_vector(17 downto 0);
    signal n_v_vL_6th_29 : std_logic_vector(37 downto 0);
    signal v_vv_vL_6th_29 : std_logic_vector(37 downto 0);
    signal v_vv_vL_6th : std_logic_vector(17 downto 0);
    signal q_v_vL_6th_29 : std_logic_vector(37 downto 0);
    signal n_v_vL_6th : std_logic_vector(17 downto 0);
    SIGNAL q_v_vL_6th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    
    signal v_v_x_6th : std_logic_vector(17 downto 0);
    signal n_vv_x_6th : std_logic_vector(17 downto 0);
    signal n_v_x_6th : std_logic_vector(17 downto 0);
    signal q_vv_x_6th : std_logic_vector(17 downto 0);
    signal q_v_x_6th : std_logic_vector(17 downto 0);
    signal v_vv_x_6th : std_logic_vector(17 downto 0);
    
    TYPE STATE_TYPE IS (READY);
    SIGNAL STATE : STATE_TYPE := READY;
    SIGNAL Iin : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vin : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nin : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qin : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sin : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vv36 : STD_LOGIC_VECTOR(35 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vv   : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vv_1 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vv_0 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vv_2 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    
    SIGNAL iin_01 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vin_01 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nin_01 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qin_01 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sin_01 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_S_01 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_L_01 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    
    SIGNAL iin_02 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vin_02 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nin_02 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qin_02 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sin_02 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_S_02 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_L_02 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    
    SIGNAL vin_03 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nin_03 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qin_03 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sin_03 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_S_03 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_L_03 : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    
    SIGNAL vin_2nd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nin_2nd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qin_2nd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sin_2nd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_S_2nd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_L_2nd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL v_x_2nd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL n_x_2nd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL q_x_2nd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    
    SIGNAL s_S_3rd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_L_3rd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vin_3rd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nin_3rd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qin_3rd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sin_3rd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vout_3rd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nout_3rd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qout_3rd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sout_3rd : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');

    SIGNAL vin_4th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nin_4th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qin_4th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sin_4th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vout_4th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nout_4th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qout_4th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sout_4th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');

    SIGNAL vin_5th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nin_5th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qin_5th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sin_5th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vout_5th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nout_5th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qout_5th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sout_5th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    
    SIGNAL vin_6th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nin_6th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qin_6th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sin_6th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vout_6th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nout_6th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qout_6th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sout_6th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');

    SIGNAL vin_7th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nin_7th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qin_7th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sin_7th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL vout_7th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL nout_7th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL qout_7th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sout_7th : STD_LOGIC_VECTOR(17 DOWNTO 0) := (OTHERS => '0');
    
    SIGNAL s_S : std_logic_vector(17 downto 0);
    SIGNAL s_S_0 : std_logic_vector(37 downto 0);
    SIGNAL s_S_1 : std_logic_vector(37 downto 0);
    SIGNAL s_L : std_logic_vector(17 downto 0);
    SIGNAL s_L_0 : std_logic_vector(37 downto 0);
    SIGNAL s_L_1 : std_logic_vector(37 downto 0);
    SIGNAL v_c_vS : std_logic_vector(17 downto 0):="000000000101001010";-- 0.322265625
    SIGNAL v_c_vL : std_logic_vector(17 downto 0):="000000000101001010";-- 0.322265625
    SIGNAL n_c_vS : std_logic_vector(17 downto 0):="000000000000000010";-- 0.001953125
    SIGNAL n_c_vL : std_logic_vector(17 downto 0):="000000000000000010";-- 0.001953125
    SIGNAL q_c_vS : std_logic_vector(17 downto 0):="000000000000001100";-- 0.01171875
    SIGNAL q_c_vL : std_logic_vector(17 downto 0):="000000100110000001";-- 2.3759765625
    SIGNAL s_c_L : std_logic_vector(17 downto 0):="000000000000010000";-- 0.015625
    SIGNAL crf : std_logic_vector(17 downto 0):="000000000000000000";-- 0
    SIGNAL crg : std_logic_vector(17 downto 0):="000000000001000000";-- 0.0625
    SIGNAL crh : std_logic_vector(17 downto 0):="000011111011100000";-- 15.71875
    SIGNAL vini : std_logic_vector(17 downto 0):="111110110011010110";-- -4.791015625
    SIGNAL nini : std_logic_vector(17 downto 0):="000110101111000000";-- 26.9375
    SIGNAL qini : std_logic_vector(17 downto 0):="111111000110010100";-- -3.60546875
    SIGNAL vth : std_logic_vector(17 downto 0):="000000000000000000";-- 0

BEGIN
    updater : PROCESS (CLK)
    BEGIN
        IF (rising_edge(CLK)) THEN
        
            -- 1st stage --
            Iin <= PORT_Iin;
            vv36<= PORT_vin * PORT_vin;
            vin <= PORT_vin;
            nin <= PORT_nin;
            qin <= PORT_qin;
            sin <= PORT_sin;
             
            -- 2nd stage --
            s_S_2nd <= s_S;
            s_L_2nd <= s_L;
            vin_2nd <= vin;
            nin_2nd <= nin;
            qin_2nd <= qin;
            sin_2nd <= sin;
            v_iin0_0 <= iin(16 downto 0) & "000000000000000000000";
            
            -- 3rd stage --
            v_vv_vS_a   <= v_vv_vS0_1 + v_vv_vS0_2;
            v_vv_vS_b   <= v_vv_vS0_3 + v_vv_vS0_4;
            v_vv_vS_c   <= v_vv_vS0_5 + v_vv_vS0_6;
            v_vv_vS_d   <= v_vv_vS0_7 + v_vv_vS0_8;
            v_vv_vS_e   <= v_vv_vS0_9 + v_vv_vS0_10;
            
            v_vv_vL_a   <= v_vv_vL0_1 + v_vv_vL0_2;
            v_vv_vL_b   <= v_vv_vL0_3 + v_vv_vL0_4;
            v_vv_vL_c   <= v_vv_vL0_5 + v_vv_vL0_6;
            v_vv_vL_d   <= v_vv_vL0_7 + v_vv_vL0_8;
            v_vv_vL_e   <= v_vv_vL0_9 + v_vv_vL0_10;
            
            v_v_vS_a    <= v_v_vS0_1 + v_v_vS0_2;
            v_v_vS_b    <= v_v_vS0_3 + v_v_vS0_4;
            v_v_vS_c    <= v_v_vS0_5 + v_v_vS0_6;
            v_v_vS_d    <= v_v_vS0_7 + v_v_vS0_8;
            v_v_vS_e    <= v_v_vS0_9 + v_v_vS0_10;
            
            v_v_vL_a    <= v_v_vL0_1 + v_v_vL0_2;
            v_v_vL_b    <= v_v_vL0_3 + v_v_vL0_4;
            v_v_vL_c    <= v_v_vL0_5 + v_v_vL0_6;
            v_v_vL_d    <= v_v_vL0_7 + v_v_vL0_8;
            v_v_vL_e    <= v_v_vL0_9 + v_v_vL0_10;
            
            v_n_a       <= v_n0_1 + v_n0_2;
            v_n_b       <= v_n0_3 + v_n0_4;
            v_n_c       <= v_n0_5 + v_n0_6;
            v_n_d       <= v_n0_7 + v_n0_8;
            v_n_e       <= v_n0_9 + v_n0_10;
            
            v_q_a       <= v_q0_1 + v_q0_2;
            v_q_b       <= v_q0_3 + v_q0_4;
            v_q_c       <= v_q0_5 + v_q0_6;
            v_q_d       <= v_q0_7 + v_q0_8;
            v_q_e       <= v_q0_9 + v_q0_10;
            
            v_iin_a     <= v_iin0_1 + v_iin0_2;
            v_iin_b     <= v_iin0_3 + v_iin0_4;
            v_iin_c     <= v_iin0_5 + v_iin0_6;
            v_iin_d     <= v_iin0_7 + v_iin0_8;
            v_iin_e     <= v_iin0_9 + v_iin0_10;
            v_iin0_0a   <= v_iin0_0;
     ---------------------------------------------------------------------       
            n_vv_vS_a   <= n_vv_vS0_1 + n_vv_vS0_2;
            n_vv_vS_b   <= n_vv_vS0_3 + n_vv_vS0_4;
            n_vv_vS_c   <= n_vv_vS0_5 + n_vv_vS0_6;
            n_vv_vS_d   <= n_vv_vS0_7 + n_vv_vS0_8;
            n_vv_vS_e   <= n_vv_vS0_9 + n_vv_vS0_10;
            
            n_vv_vL_a   <= n_vv_vL0_1 + n_vv_vL0_2;
            n_vv_vL_b   <= n_vv_vL0_3 + n_vv_vL0_4;
            n_vv_vL_c   <= n_vv_vL0_5 + n_vv_vL0_6;
            n_vv_vL_d   <= n_vv_vL0_7 + n_vv_vL0_8;
            n_vv_vL_e   <= n_vv_vL0_9 + n_vv_vL0_10;
            
            n_v_vS_a    <= n_v_vS0_1 + n_v_vS0_2;
            n_v_vS_b    <= n_v_vS0_3 + n_v_vS0_4;
            n_v_vS_c    <= n_v_vS0_5 + n_v_vS0_6;
            n_v_vS_d    <= n_v_vS0_7 + n_v_vS0_8;
            n_v_vS_e    <= n_v_vS0_9 + n_v_vS0_10;
            
            n_v_vL_a    <= n_v_vL0_1 + n_v_vL0_2;
            n_v_vL_b    <= n_v_vL0_3 + n_v_vL0_4;
            n_v_vL_c    <= n_v_vL0_5 + n_v_vL0_6;
            n_v_vL_d    <= n_v_vL0_7 + n_v_vL0_8;
            n_v_vL_e    <= n_v_vL0_9 + n_v_vL0_10;
            
            n_n_a       <= n_n0_1 + n_n0_2;
            n_n_b       <= n_n0_3 + n_n0_4;
            n_n_c       <= n_n0_5 + n_n0_6;
            n_n_d       <= n_n0_7 + n_n0_8;
            n_n_e       <= n_n0_9 + n_n0_10;
      ------------------------------------------------------
            q_vv_vS_a   <= q_vv_vS0_1 + q_vv_vS0_2;
            q_vv_vS_b   <= q_vv_vS0_3 + q_vv_vS0_4;
            q_vv_vS_c   <= q_vv_vS0_5 + q_vv_vS0_6;
            q_vv_vS_d   <= q_vv_vS0_7 + q_vv_vS0_8;
            q_vv_vS_e   <= q_vv_vS0_9 + q_vv_vS0_10;
            
            q_vv_vL_a   <= q_vv_vL0_1 + q_vv_vL0_2;
            q_vv_vL_b   <= q_vv_vL0_3 + q_vv_vL0_4;
            q_vv_vL_c   <= q_vv_vL0_5 + q_vv_vL0_6;
            q_vv_vL_d   <= q_vv_vL0_7 + q_vv_vL0_8;
            q_vv_vL_e   <= q_vv_vL0_9 + q_vv_vL0_10;
            
            q_v_vS_a    <= q_v_vS0_1 + q_v_vS0_2;
            q_v_vS_b    <= q_v_vS0_3 + q_v_vS0_4;
            q_v_vS_c    <= q_v_vS0_5 + q_v_vS0_6;
            q_v_vS_d    <= q_v_vS0_7 + q_v_vS0_8;
            q_v_vS_e    <= q_v_vS0_9 + q_v_vS0_10;
            
            q_v_vL_a    <= q_v_vL0_1 + q_v_vL0_2;
            q_v_vL_b    <= q_v_vL0_3 + q_v_vL0_4;
            q_v_vL_c    <= q_v_vL0_5 + q_v_vL0_6;
            q_v_vL_d    <= q_v_vL0_7 + q_v_vL0_8;
            q_v_vL_e    <= q_v_vL0_9 + q_v_vL0_10;
            
            q_q_a       <= q_q0_1 + q_q0_2;
            q_q_b       <= q_q0_3 + q_q0_4;
            q_q_c       <= q_q0_5 + q_q0_6;
            q_q_d       <= q_q0_7 + q_q0_8;
            q_q_e       <= q_q0_9 + q_q0_10;

            vout_3rd <= vin_2nd + v_x_2nd;
            nout_3rd <= nin_2nd + n_x_2nd;
            qout_3rd <= qin_2nd + q_x_2nd;
            vin_3rd <= vin_2nd;
            nin_3rd <= nin_2nd;
            qin_3rd <= qin_2nd;
            sin_3rd <= sin_2nd;
            
            -- 4th stage --
            v_vv_vS_f   <= v_vv_vS_a + v_vv_vS_b;
            v_vv_vS_g   <= v_vv_vS_c + v_vv_vS_d;
            v_vv_vS_ea  <= v_vv_vS_e;
            
            v_vv_vL_f   <= v_vv_vL_a + v_vv_vL_b;
            v_vv_vL_g   <= v_vv_vL_c + v_vv_vL_d;
            v_vv_vL_ea  <= v_vv_vL_e;
            
            v_v_vS_f    <= v_v_vS_a + v_v_vS_b;
            v_v_vS_g    <= v_v_vS_c + v_v_vS_d;
            v_v_vS_ea   <= v_v_vS_e;
            
            v_v_vL_f    <= v_v_vL_a + v_v_vL_b;
            v_v_vL_g    <= v_v_vL_c + v_v_vL_d;
            v_v_vL_ea   <= v_v_vL_e;
            
            v_n_f       <= v_n_a + v_n_b;
            v_n_g       <= v_n_c + v_n_d;
            v_n_ea      <= v_n_e;
            
            v_q_f       <= v_q_a + v_q_b;
            v_q_g       <= v_q_c + v_q_d;
            v_q_ea      <= v_q_e;
            
            v_iin_f     <= v_iin_a + v_iin_b;
            v_iin_g     <= v_iin_c + v_iin_d;
            v_iin_h     <= v_iin_e + v_iin0_0a;
    ----------------------------------------------------------------        
            n_vv_vS_f   <= n_vv_vS_a + n_vv_vS_b;
            n_vv_vS_g   <= n_vv_vS_c + n_vv_vS_d;
            n_vv_vS_ea  <= n_vv_vS_e;
            
            n_vv_vL_f   <= n_vv_vL_a + n_vv_vL_b;
            n_vv_vL_g   <= n_vv_vL_c + n_vv_vL_d;
            n_vv_vL_ea  <= n_vv_vL_e;
            
            n_v_vS_f    <= n_v_vS_a + n_v_vS_b;
            n_v_vS_g    <= n_v_vS_c + n_v_vS_d;
            n_v_vS_ea   <= n_v_vS_e;
            
            n_v_vL_f    <= n_v_vL_a + n_v_vL_b;
            n_v_vL_g    <= n_v_vL_c + n_v_vL_d;
            n_v_vL_ea   <= n_v_vL_e;
            
            n_n_f       <= n_n_a + n_n_b;
            n_n_g       <= n_n_c + n_n_d;
            n_n_ea      <= n_n_e;
    --------------------------------------------------------------------        
            q_vv_vS_f   <= q_vv_vS_a + q_vv_vS_b;
            q_vv_vS_g   <= q_vv_vS_c + q_vv_vS_d;
            q_vv_vS_ea  <= q_vv_vS_e;
            
            q_vv_vL_f   <= q_vv_vL_a + q_vv_vL_b;
            q_vv_vL_g   <= q_vv_vL_c + q_vv_vL_d;
            q_vv_vL_ea  <= q_vv_vL_e;
            
            q_v_vS_f    <= q_v_vS_a + q_v_vS_b;
            q_v_vS_g    <= q_v_vS_c + q_v_vS_d;
            q_v_vS_ea   <= q_v_vS_e;
            
            q_v_vL_f    <= q_v_vL_a + q_v_vL_b;
            q_v_vL_g    <= q_v_vL_c + q_v_vL_d;
            q_v_vL_ea   <= q_v_vL_e;
            
            q_q_f       <= q_q_a + q_q_b;
            q_q_g       <= q_q_c + q_q_d;
            q_q_ea      <= q_q_e;
            
            vout_4th <= vout_3rd;
            nout_4th <= nout_3rd;
            qout_4th <= qout_3rd;
            vin_4th <= vin_3rd;
            nin_4th <= nin_3rd;
            qin_4th <= qin_3rd;
            sin_4th <= sin_3rd;
            
            -- 5th stage --
            v_vv_vS_h       <= v_vv_vS_f + v_vv_vS_g + v_vv_vS_ea;
            v_vv_vL_h       <= v_vv_vL_f + v_vv_vL_g + v_vv_vL_ea;
            v_v_vS_h        <= v_v_vS_f + v_v_vS_g + v_v_vS_ea;
            v_v_vL_h        <= v_v_vL_f + v_v_vL_g + v_v_vL_ea;
            v_n_h           <= v_n_f + v_n_g + v_n_ea;
            v_q_h           <= v_q_f + v_q_g + v_q_ea;
            v_iin_i         <= v_iin_f + v_iin_g + v_iin_h;
            
            n_vv_vS_h       <= n_vv_vS_f + n_vv_vS_g + n_vv_vS_ea;
            n_vv_vL_h       <= n_vv_vL_f + n_vv_vL_g + n_vv_vL_ea;
            n_v_vS_h        <= n_v_vS_f + n_v_vS_g + n_v_vS_ea;
            n_v_vL_h        <= n_v_vL_f + n_v_vL_g + n_v_vL_ea;
            n_n_h           <= n_n_f + n_n_g + n_n_ea;
            
            q_vv_vS_h       <= q_vv_vS_f + q_vv_vS_g + q_vv_vS_ea;
            q_vv_vL_h       <= q_vv_vL_f + q_vv_vL_g + q_vv_vL_ea; 
            q_v_vS_h        <= q_v_vS_f + q_v_vS_g + q_v_vS_ea;
            q_v_vL_h        <= q_v_vL_f + q_v_vL_g + q_v_vL_ea;
            q_q_h           <= q_q_f + q_q_g + q_q_ea;

            vout_5th <= vout_4th;
            nout_5th <= nout_4th;
            qout_5th <= qout_4th;
            vin_5th <= vin_4th;
            nin_5th <= nin_4th;
            qin_5th <= qin_4th;
            sin_5th <= sin_4th;
            
            -- 6th stage --
            v_vv_vS_6th_29      <= v_vv_vS_h;
            v_vv_vL_6th_29      <= not (v_vv_vL_h) + 1;
            v_v_vS_6th_29       <= v_v_vS_h;
            v_v_vL_6th_29       <= v_v_vL_h;
            v_n_6th_29          <= not (v_n_h) + 1;
            v_q_6th_29          <= not (v_q_h) + 1;
            v_iin_6th_29        <= v_iin_i;
            
            n_vv_vS_6th_29      <= n_vv_vS_h;
            n_vv_vL_6th_29      <= n_vv_vL_h;
            n_v_vS_6th_29       <= not (n_v_vS_h) + 1;
            n_v_vL_6th_29       <= not (n_v_vL_h) + 1;
            n_n_6th_29          <= not (n_n_h) + 1;

            q_vv_vS_6th_29      <= q_vv_vS_h;
            q_vv_vL_6th_29      <= q_vv_vL_h;
            q_v_vS_6th_29       <= q_v_vS_h;
            q_v_vL_6th_29       <= not (q_v_vL_h) + 1;
            q_q_6th_29          <= not (q_q_h) + 1;
            
            vout_6th <= vout_5th;
            nout_6th <= nout_5th;
            qout_6th <= qout_5th;
            vin_6th <= vin_5th;
            nin_6th <= nin_5th;
            qin_6th <= qin_5th;
            sin_6th <= sin_5th;
            
            --7th stage --
            vout_7th <= vout_6th + v_vv_x_6th + v_v_x_6th + v_n_6th + v_q_6th + v_iin_6th;
            nout_7th <= nout_6th + n_vv_x_6th + n_v_x_6th + n_n_6th;
            qout_7th <= qout_6th + q_vv_x_6th + q_v_x_6th + q_q_6th;
            vin_7th <= vin_6th;
            nin_7th <= nin_6th;
            qin_7th <= qin_6th;
            sin_7th <= sin_6th;
            
            --8th stage --
            PORT_vout <= vout_7th;
            PORT_nout <= nout_7th;
            PORT_qout <= qout_7th;
            IF vout_7th<0 THEN
                PORT_sout <= sin_3rd + s_S_3rd;
            ELSE
                PORT_sout <= sin_3rd + s_L_3rd + s_c_L;
            END IF;
            IF vin_7th<vth and vout_7th>=vth THEN
                PORT_spike_flag <= "1";
            ELSE
                PORT_spike_flag <= "0";
            END IF;
        END IF;
    END PROCESS;
    
    vv <= vv36(27 downto 10);
    
            shift_amt01_1 <= out_rom1(49 downto 45);
            shift_amt01_2 <= out_rom1(44 downto 40);
            shift_amt01_3 <= out_rom1(39 downto 35);
            shift_amt01_4 <= out_rom1(34 downto 30);
            shift_amt01_5 <= out_rom1(29 downto 25);
            shift_amt01_6 <= out_rom1(24 downto 20);
            shift_amt01_7 <= out_rom1(19 downto 15);
            shift_amt01_8 <= out_rom1(14 downto 10);
            shift_amt01_9 <= out_rom1( 9 downto  5);
            shift_amt01_10<= out_rom1( 4 downto  0);
            
            shift_amt02_1 <= out_rom2(49 downto 45);
            shift_amt02_2 <= out_rom2(44 downto 40);
            shift_amt02_3 <= out_rom2(39 downto 35);
            shift_amt02_4 <= out_rom2(34 downto 30);
            shift_amt02_5 <= out_rom2(29 downto 25);
            shift_amt02_6 <= out_rom2(24 downto 20);
            shift_amt02_7 <= out_rom2(19 downto 15);
            shift_amt02_8 <= out_rom2(14 downto 10);
            shift_amt02_9 <= out_rom2( 9 downto  5);
            shift_amt02_10<= out_rom2( 4 downto  0);
            
            shift_amt03_1 <= out_rom3(49 downto 45);
            shift_amt03_2 <= out_rom3(44 downto 40);
            shift_amt03_3 <= out_rom3(39 downto 35);
            shift_amt03_4 <= out_rom3(34 downto 30);
            shift_amt03_5 <= out_rom3(29 downto 25);
            shift_amt03_6 <= out_rom3(24 downto 20);
            shift_amt03_7 <= out_rom3(19 downto 15);
            shift_amt03_8 <= out_rom3(14 downto 10);
            shift_amt03_9 <= out_rom3( 9 downto  5);
            shift_amt03_10<= out_rom3( 4 downto  0);
            
            shift_amt04_1 <= out_rom4(49 downto 45);
            shift_amt04_2 <= out_rom4(44 downto 40);
            shift_amt04_3 <= out_rom4(39 downto 35);
            shift_amt04_4 <= out_rom4(34 downto 30);
            shift_amt04_5 <= out_rom4(29 downto 25);
            shift_amt04_6 <= out_rom4(24 downto 20);
            shift_amt04_7 <= out_rom4(19 downto 15);
            shift_amt04_8 <= out_rom4(14 downto 10);
            shift_amt04_9 <= out_rom4( 9 downto  5);
            shift_amt04_10<= out_rom4( 4 downto  0);
            
            shift_amt05_1 <= out_rom5(49 downto 45);
            shift_amt05_2 <= out_rom5(44 downto 40);
            shift_amt05_3 <= out_rom5(39 downto 35);
            shift_amt05_4 <= out_rom5(34 downto 30);
            shift_amt05_5 <= out_rom5(29 downto 25);
            shift_amt05_6 <= out_rom5(24 downto 20);
            shift_amt05_7 <= out_rom5(19 downto 15);
            shift_amt05_8 <= out_rom5(14 downto 10);
            shift_amt05_9 <= out_rom5( 9 downto  5);
            shift_amt05_10<= out_rom5( 4 downto  0);
            
            shift_amt06_1 <= out_rom6(49 downto 45);
            shift_amt06_2 <= out_rom6(44 downto 40);
            shift_amt06_3 <= out_rom6(39 downto 35);
            shift_amt06_4 <= out_rom6(34 downto 30);
            shift_amt06_5 <= out_rom6(29 downto 25);
            shift_amt06_6 <= out_rom6(24 downto 20);
            shift_amt06_7 <= out_rom6(19 downto 15);
            shift_amt06_8 <= out_rom6(14 downto 10);
            shift_amt06_9 <= out_rom6( 9 downto  5);
            shift_amt06_10<= out_rom6( 4 downto  0);
            
            shift_amt07_1 <= out_rom7(49 downto 45);
            shift_amt07_2 <= out_rom7(44 downto 40);
            shift_amt07_3 <= out_rom7(39 downto 35);
            shift_amt07_4 <= out_rom7(34 downto 30);
            shift_amt07_5 <= out_rom7(29 downto 25);
            shift_amt07_6 <= out_rom7(24 downto 20);
            shift_amt07_7 <= out_rom7(19 downto 15);
            shift_amt07_8 <= out_rom7(14 downto 10);
            shift_amt07_9 <= out_rom7( 9 downto  5);
            shift_amt07_10<= out_rom7( 4 downto  0);
            
            shift_amt08_1 <= out_rom8(49 downto 45);
            shift_amt08_2 <= out_rom8(44 downto 40);
            shift_amt08_3 <= out_rom8(39 downto 35);
            shift_amt08_4 <= out_rom8(34 downto 30);
            shift_amt08_5 <= out_rom8(29 downto 25);
            shift_amt08_6 <= out_rom8(24 downto 20);
            shift_amt08_7 <= out_rom8(19 downto 15);
            shift_amt08_8 <= out_rom8(14 downto 10);
            shift_amt08_9 <= out_rom8( 9 downto  5);
            shift_amt08_10<= out_rom8( 4 downto  0);
            
            shift_amt09_1 <= out_rom9(49 downto 45);
            shift_amt09_2 <= out_rom9(44 downto 40);
            shift_amt09_3 <= out_rom9(39 downto 35);
            shift_amt09_4 <= out_rom9(34 downto 30);
            shift_amt09_5 <= out_rom9(29 downto 25);
            shift_amt09_6 <= out_rom9(24 downto 20);
            shift_amt09_7 <= out_rom9(19 downto 15);
            shift_amt09_8 <= out_rom9(14 downto 10);
            shift_amt09_9 <= out_rom9( 9 downto  5);
            shift_amt09_10<= out_rom9( 4 downto  0);
            
            shift_amt10_1 <= out_rom10(49 downto 45);
            shift_amt10_2 <= out_rom10(44 downto 40);
            shift_amt10_3 <= out_rom10(39 downto 35);
            shift_amt10_4 <= out_rom10(34 downto 30);
            shift_amt10_5 <= out_rom10(29 downto 25);
            shift_amt10_6 <= out_rom10(24 downto 20);
            shift_amt10_7 <= out_rom10(19 downto 15);
            shift_amt10_8 <= out_rom10(14 downto 10);
            shift_amt10_9 <= out_rom10( 9 downto  5);
            shift_amt10_10<= out_rom10( 4 downto  0);
            
            shift_amt11_1 <= out_rom11(49 downto 45);
            shift_amt11_2 <= out_rom11(44 downto 40);
            shift_amt11_3 <= out_rom11(39 downto 35);
            shift_amt11_4 <= out_rom11(34 downto 30);
            shift_amt11_5 <= out_rom11(29 downto 25);
            shift_amt11_6 <= out_rom11(24 downto 20);
            shift_amt11_7 <= out_rom11(19 downto 15);
            shift_amt11_8 <= out_rom11(14 downto 10);
            shift_amt11_9 <= out_rom11( 9 downto  5);
            shift_amt11_10<= out_rom11( 4 downto  0);
            
            shift_amt12_1 <= out_rom12(49 downto 45);
            shift_amt12_2 <= out_rom12(44 downto 40);
            shift_amt12_3 <= out_rom12(39 downto 35);
            shift_amt12_4 <= out_rom12(34 downto 30);
            shift_amt12_5 <= out_rom12(29 downto 25);
            shift_amt12_6 <= out_rom12(24 downto 20);
            shift_amt12_7 <= out_rom12(19 downto 15);
            shift_amt12_8 <= out_rom12(14 downto 10);
            shift_amt12_9 <= out_rom12( 9 downto  5);
            shift_amt12_10<= out_rom12( 4 downto  0);
            
            shift_amt13_1 <= out_rom13(49 downto 45);
            shift_amt13_2 <= out_rom13(44 downto 40);
            shift_amt13_3 <= out_rom13(39 downto 35);
            shift_amt13_4 <= out_rom13(34 downto 30);
            shift_amt13_5 <= out_rom13(29 downto 25);
            shift_amt13_6 <= out_rom13(24 downto 20);
            shift_amt13_7 <= out_rom13(19 downto 15);
            shift_amt13_8 <= out_rom13(14 downto 10);
            shift_amt13_9 <= out_rom13( 9 downto  5);
            shift_amt13_10<= out_rom13( 4 downto  0);
            
            shift_amt14_1 <= out_rom14(49 downto 45);
            shift_amt14_2 <= out_rom14(44 downto 40);
            shift_amt14_3 <= out_rom14(39 downto 35);
            shift_amt14_4 <= out_rom14(34 downto 30);
            shift_amt14_5 <= out_rom14(29 downto 25);
            shift_amt14_6 <= out_rom14(24 downto 20);
            shift_amt14_7 <= out_rom14(19 downto 15);
            shift_amt14_8 <= out_rom14(14 downto 10);
            shift_amt14_9 <= out_rom14( 9 downto  5);
            shift_amt14_10<= out_rom14( 4 downto  0);
            
            shift_amt15_1 <= out_rom15(49 downto 45);
            shift_amt15_2 <= out_rom15(44 downto 40);
            shift_amt15_3 <= out_rom15(39 downto 35);
            shift_amt15_4 <= out_rom15(34 downto 30);
            shift_amt15_5 <= out_rom15(29 downto 25);
            shift_amt15_6 <= out_rom15(24 downto 20);
            shift_amt15_7 <= out_rom15(19 downto 15);
            shift_amt15_8 <= out_rom15(14 downto 10);
            shift_amt15_9 <= out_rom15( 9 downto  5);
            shift_amt15_10<= out_rom15( 4 downto  0);
            
            shift_amt16_1 <= out_rom16(49 downto 45);
            shift_amt16_2 <= out_rom16(44 downto 40);
            shift_amt16_3 <= out_rom16(39 downto 35);
            shift_amt16_4 <= out_rom16(34 downto 30);
            shift_amt16_5 <= out_rom16(29 downto 25);
            shift_amt16_6 <= out_rom16(24 downto 20);
            shift_amt16_7 <= out_rom16(19 downto 15);
            shift_amt16_8 <= out_rom16(14 downto 10);
            shift_amt16_9 <= out_rom16( 9 downto  5);
            shift_amt16_10<= out_rom16( 4 downto  0);
            
            shift_amt17_1 <= out_rom17(49 downto 45);
            shift_amt17_2 <= out_rom17(44 downto 40);
            shift_amt17_3 <= out_rom17(39 downto 35);
            shift_amt17_4 <= out_rom17(34 downto 30);
            shift_amt17_5 <= out_rom17(29 downto 25);
            shift_amt17_6 <= out_rom17(24 downto 20);
            shift_amt17_7 <= out_rom17(19 downto 15);
            shift_amt17_8 <= out_rom17(14 downto 10);
            shift_amt17_9 <= out_rom17( 9 downto  5);
            shift_amt17_10<= out_rom17( 4 downto  0);
    
    v_vv_vS_6th <= v_vv_vS_6th_29(37 downto 20);
    v_vv_vL_6th <= v_vv_vL_6th_29(37 downto 20);
    v_v_vS_6th <= v_v_vS_6th_29(37 downto 20);
    v_v_vL_6th <= v_v_vL_6th_29(37 downto 20);
    v_n_6th <= v_n_6th_29(37 downto 20);
    v_q_6th <= v_q_6th_29(37 downto 20);
    v_iin_6th <= v_iin_6th_29(37 downto 20);
    
    n_vv_vS_6th <= n_vv_vS_6th_29(37 downto 20);
    n_vv_vL_6th <= n_vv_vL_6th_29(37 downto 20);
    n_v_vS_6th <= n_v_vS_6th_29(37 downto 20);
    n_v_vL_6th <= n_v_vL_6th_29(37 downto 20);
    n_n_6th <= n_n_6th_29(37 downto 20);
    
    q_vv_vL_6th <= q_vv_vL_6th_29(37 downto 20);
    q_vv_vS_6th <= q_vv_vS_6th_29(37 downto 20);
    q_v_vS_6th  <= q_v_vS_6th_29(37 downto 20);
    q_v_vL_6th <= q_v_vL_6th_29(37 downto 20);
    q_q_6th <= q_q_6th_29(37 downto 20);

    -- sin * -0.00390625 : 00000000.00000001000000000000    38bit
    s_S_0 <= "00000000" & sin(17 downto 0) & "000000000000" when sin(17)='0' else "11111111" & sin(17 downto 0) & "000000000000";
    s_S_1 <= not (s_S_0) + 1;
    s_S <= s_S_1(37 downto 20);

    -- sin * -0.015625 : 00000000.00000100000000000000    38bit
    s_L_0 <= "000000" & sin(17 downto 0) & "00000000000000" when sin(17)='0' else "111111" & sin(17 downto 0) & "00000000000000";
    s_L_1 <= not (s_L_0) + 1;
    s_L <= s_L_1(37 downto 20);

    v_vv_x_6th <= v_vv_vL_6th when vin_6th >= crf else v_vv_vS_6th;
    v_v_x_6th <= v_v_vL_6th when vin_6th>=crf else v_v_vS_6th;
    v_x_2nd <= v_c_vL when vin_2nd>=crf else v_c_vS;
    
    n_vv_x_6th <= n_vv_vL_6th when vin_6th>=crg else n_vv_vS_6th;
    n_v_x_6th <= n_v_vL_6th when vin_6th>=crg else n_v_vS_6th;
    n_x_2nd <= n_c_vL when vin_2nd>=crg else n_c_vS;
    
    q_vv_x_6th <= q_vv_vL_6th when vin_6th>=crh else q_vv_vS_6th;
    q_v_x_6th <= q_v_vL_6th when vin_6th>=crh else q_v_vS_6th;
    q_x_2nd <= q_c_vL when vin_2nd>=crh else q_c_vS;
    
    bshifter01_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt01_1,
    data_in => vv,
    data_out => v_vv_vS0_1
    );
    
    bshifter01_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt01_2,
    data_in => vv,
    data_out => v_vv_vS0_2
    );
    
    bshifter01_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt01_3,
    data_in => vv,
    data_out => v_vv_vS0_3
    );
    
    bshifter01_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt01_4,
    data_in => vv,
    data_out => v_vv_vS0_4
    );
    
    bshifter01_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt01_5,
    data_in => vv,
    data_out => v_vv_vS0_5
    );
    
    bshifter01_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt01_6,
    data_in => vv,
    data_out => v_vv_vS0_6
    );
    
    bshifter01_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt01_7,
    data_in => vv,
    data_out => v_vv_vS0_7
    );
    
    bshifter01_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt01_8,
    data_in => vv,
    data_out => v_vv_vS0_8
    );
    
    bshifter01_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt01_9,
    data_in => vv,
    data_out => v_vv_vS0_9
    );
    
    bshifter01_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt01_10,
    data_in => vv,
    data_out => v_vv_vS0_10
    );
    
    bshifter02_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt02_1,
    data_in => vv,
    data_out => v_vv_vL0_1
    );
    
    bshifter02_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt02_2,
    data_in => vv,
    data_out => v_vv_vL0_2
    );
    
    bshifter02_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt02_3,
    data_in => vv,
    data_out => v_vv_vL0_3
    );
    
    bshifter02_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt02_4,
    data_in => vv,
    data_out => v_vv_vL0_4
    );
    
    bshifter02_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt02_5,
    data_in => vv,
    data_out => v_vv_vL0_5
    );
    
    bshifter02_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt02_6,
    data_in => vv,
    data_out => v_vv_vL0_6
    );
    
    bshifter02_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt02_7,
    data_in => vv,
    data_out => v_vv_vL0_7
    );
    
    bshifter02_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt02_8,
    data_in => vv,
    data_out => v_vv_vL0_8
    );
    
    bshifter02_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt02_9,
    data_in => vv,
    data_out => v_vv_vL0_9
    );
    
    bshifter02_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt02_10,
    data_in => vv,
    data_out => v_vv_vL0_10
    );
    
    bshifter03_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt03_1,
    data_in => vin,
    data_out => v_v_vS0_1
    );
    
    bshifter03_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt03_2,
    data_in => vin,
    data_out => v_v_vS0_2
    );
    
    bshifter03_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt03_3,
    data_in => vin,
    data_out => v_v_vS0_3
    );
    
    bshifter03_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt03_4,
    data_in => vin,
    data_out => v_v_vS0_4
    );
    
    bshifter03_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt03_5,
    data_in => vin,
    data_out => v_v_vS0_5
    );
    
    bshifter03_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt03_6,
    data_in => vin,
    data_out => v_v_vS0_6
    );
    
    bshifter03_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt03_7,
    data_in => vin,
    data_out => v_v_vS0_7
    );
    
    bshifter03_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt03_8,
    data_in => vin,
    data_out => v_v_vS0_8
    );
    
    bshifter03_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt03_9,
    data_in => vin,
    data_out => v_v_vS0_9
    );
    
    bshifter03_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt03_10,
    data_in => vin,
    data_out => v_v_vS0_10
    );
    
    bshifter04_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt04_1,
    data_in => vin,
    data_out => v_v_vL0_1
    );
    
    bshifter04_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt04_2,
    data_in => vin,
    data_out => v_v_vL0_2
    );
    
    bshifter04_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt04_3,
    data_in => vin,
    data_out => v_v_vL0_3
    );
    
    bshifter04_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt04_4,
    data_in => vin,
    data_out => v_v_vL0_4
    );
    
    bshifter04_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt04_5,
    data_in => vin,
    data_out => v_v_vL0_5
    );
    
    bshifter04_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt04_6,
    data_in => vin,
    data_out => v_v_vL0_6
    );
    
    bshifter04_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt04_7,
    data_in => vin,
    data_out => v_v_vL0_7
    );
    
    bshifter04_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt04_8,
    data_in => vin,
    data_out => v_v_vL0_8
    );
    
    bshifter04_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt04_9,
    data_in => vin,
    data_out => v_v_vL0_9
    );
    
    bshifter04_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt04_10,
    data_in => vin,
    data_out => v_v_vL0_10
    );
    
    bshifter05_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt05_1,
    data_in => nin,
    data_out => v_n0_1
    );
    
    bshifter05_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt05_2,
    data_in => nin,
    data_out => v_n0_2
    );
    
    bshifter05_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt05_3,
    data_in => nin,
    data_out => v_n0_3
    );
    
    bshifter05_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt05_4,
    data_in => nin,
    data_out => v_n0_4
    );
    
    bshifter05_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt05_5,
    data_in => nin,
    data_out => v_n0_5
    );
    
    bshifter05_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt05_6,
    data_in => nin,
    data_out => v_n0_6
    );
    
    bshifter05_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt05_7,
    data_in => nin,
    data_out => v_n0_7
    );
    
    bshifter05_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt05_8,
    data_in => nin,
    data_out => v_n0_8
    );
    
    bshifter05_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt05_9,
    data_in => nin,
    data_out => v_n0_9
    );
    
    bshifter05_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt05_10,
    data_in => nin,
    data_out => v_n0_10
    );
    
    bshifter06_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt06_1,
    data_in => qin,
    data_out => v_q0_1
    );
    
    bshifter06_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt06_2,
    data_in => qin,
    data_out => v_q0_2
    );
    
    bshifter06_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt06_3,
    data_in => qin,
    data_out => v_q0_3
    );
    
    bshifter06_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt06_4,
    data_in => qin,
    data_out => v_q0_4
    );
    
    bshifter06_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt06_5,
    data_in => qin,
    data_out => v_q0_5
    );
    
    bshifter06_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt06_6,
    data_in => qin,
    data_out => v_q0_6
    );
    
    bshifter06_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt06_7,
    data_in => qin,
    data_out => v_q0_7
    );
    
    bshifter06_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt06_8,
    data_in => qin,
    data_out => v_q0_8
    );
    
    bshifter06_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt06_9,
    data_in => qin,
    data_out => v_q0_9
    );
    
    bshifter06_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt06_10,
    data_in => qin,
    data_out => v_q0_10
    );
    
    bshifter07_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt07_1,
    data_in => iin,
    data_out => v_iin0_1
    );
    
    bshifter07_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt07_2,
    data_in => iin,
    data_out => v_iin0_2
    );
    
    bshifter07_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt07_3,
    data_in => iin,
    data_out => v_iin0_3
    );
    
    bshifter07_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt07_4,
    data_in => iin,
    data_out => v_iin0_4
    );
    
    bshifter07_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt07_5,
    data_in => iin,
    data_out => v_iin0_5
    );
    
    bshifter07_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt07_6,
    data_in => iin,
    data_out => v_iin0_6
    );
    
    bshifter07_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt07_7,
    data_in => iin,
    data_out => v_iin0_7
    );
    
    bshifter07_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt07_8,
    data_in => iin,
    data_out => v_iin0_8
    );
    
    bshifter07_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt07_9,
    data_in => iin,
    data_out => v_iin0_9
    );
    
    bshifter07_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt07_10,
    data_in => iin,
    data_out => v_iin0_10
    );
    
    bshifter08_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt08_1,
    data_in => vv,
    data_out => n_vv_vS0_1
    );
    
    bshifter08_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt08_2,
    data_in => vv,
    data_out => n_vv_vS0_2
    );
    
    bshifter08_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt08_3,
    data_in => vv,
    data_out => n_vv_vS0_3
    );
    
    bshifter08_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt08_4,
    data_in => vv,
    data_out => n_vv_vS0_4
    );
    
    bshifter08_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt08_5,
    data_in => vv,
    data_out => n_vv_vS0_5
    );
    
    bshifter08_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt08_6,
    data_in => vv,
    data_out => n_vv_vS0_6
    );
    
    bshifter08_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt08_7,
    data_in => vv,
    data_out => n_vv_vS0_7
    );
    
    bshifter08_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt08_8,
    data_in => vv,
    data_out => n_vv_vS0_8
    );
    
    bshifter08_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt08_9,
    data_in => vv,
    data_out => n_vv_vS0_9
    );
    
    bshifter08_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt08_10,
    data_in => vv,
    data_out => n_vv_vS0_10
    );
    
    bshifter09_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt09_1,
    data_in => vv,
    data_out => n_vv_vL0_1
    );
    
    bshifter09_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt09_2,
    data_in => vv,
    data_out => n_vv_vL0_2
    );
    
    bshifter09_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt09_3,
    data_in => vv,
    data_out => n_vv_vL0_3
    );
    
    bshifter09_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt09_4,
    data_in => vv,
    data_out => n_vv_vL0_4
    );
    
    bshifter09_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt09_5,
    data_in => vv,
    data_out => n_vv_vL0_5
    );
    
    bshifter09_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt09_6,
    data_in => vv,
    data_out => n_vv_vL0_6
    );
    
    bshifter09_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt09_7,
    data_in => vv,
    data_out => n_vv_vL0_7
    );
    
    bshifter09_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt09_8,
    data_in => vv,
    data_out => n_vv_vL0_8
    );
    
    bshifter09_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt09_9,
    data_in => vv,
    data_out => n_vv_vL0_9
    );
    
    bshifter09_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt09_10,
    data_in => vv,
    data_out => n_vv_vL0_10
    );
    
    bshifter10_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt10_1,
    data_in => vin,
    data_out => n_v_vS0_1
    );
    
    bshifter10_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt10_2,
    data_in => vin,
    data_out => n_v_vS0_2
    );
    
    bshifter10_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt10_3,
    data_in => vin,
    data_out => n_v_vS0_3
    );
    
    bshifter10_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt10_4,
    data_in => vin,
    data_out => n_v_vS0_4
    );
    
    bshifter10_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt10_5,
    data_in => vin,
    data_out => n_v_vS0_5
    );
    
    bshifter10_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt10_6,
    data_in => vin,
    data_out => n_v_vS0_6
    );
    
    bshifter10_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt10_7,
    data_in => vin,
    data_out => n_v_vS0_7
    );
    
    bshifter10_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt10_8,
    data_in => vin,
    data_out => n_v_vS0_8
    );
    
    bshifter10_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt10_9,
    data_in => vin,
    data_out => n_v_vS0_9
    );
    
    bshifter10_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt10_10,
    data_in => vin,
    data_out => n_v_vS0_10
    );
    
    bshifter11_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt11_1,
    data_in => vin,
    data_out => n_v_vL0_1
    );
    
    bshifter11_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt11_2,
    data_in => vin,
    data_out => n_v_vL0_2
    );
    
    bshifter11_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt11_3,
    data_in => vin,
    data_out => n_v_vL0_3
    );
    
    bshifter11_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt11_4,
    data_in => vin,
    data_out => n_v_vL0_4
    );
    
    bshifter11_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt11_5,
    data_in => vin,
    data_out => n_v_vL0_5
    );
    
    bshifter11_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt11_6,
    data_in => vin,
    data_out => n_v_vL0_6
    );
    
    bshifter11_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt11_7,
    data_in => vin,
    data_out => n_v_vL0_7
    );
    
    bshifter11_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt11_8,
    data_in => vin,
    data_out => n_v_vL0_8
    );
    
    bshifter11_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt11_9,
    data_in => vin,
    data_out => n_v_vL0_9
    );
    
    bshifter11_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt11_10,
    data_in => vin,
    data_out => n_v_vL0_10
    );
    
    bshifter12_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt12_1,
    data_in => nin,
    data_out => n_n0_1
    );
    
    bshifter12_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt12_2,
    data_in => nin,
    data_out => n_n0_2
    );
    
    bshifter12_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt12_3,
    data_in => nin,
    data_out => n_n0_3
    );
    
    bshifter12_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt12_4,
    data_in => nin,
    data_out => n_n0_4
    );
    
    bshifter12_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt12_5,
    data_in => nin,
    data_out => n_n0_5
    );
    
    bshifter12_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt12_6,
    data_in => nin,
    data_out => n_n0_6
    );
    
    bshifter12_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt12_7,
    data_in => nin,
    data_out => n_n0_7
    );
    
    bshifter12_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt12_8,
    data_in => nin,
    data_out => n_n0_8
    );
    
    bshifter12_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt12_9,
    data_in => nin,
    data_out => n_n0_9
    );
    
    bshifter12_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt12_10,
    data_in => nin,
    data_out => n_n0_10
    );
    
    bshifter13_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt13_1,
    data_in => vv,
    data_out => q_vv_vS0_1
    );
    
    bshifter13_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt13_2,
    data_in => vv,
    data_out => q_vv_vS0_2
    );
    
    bshifter13_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt13_3,
    data_in => vv,
    data_out => q_vv_vS0_3
    );
    
    bshifter13_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt13_4,
    data_in => vv,
    data_out => q_vv_vS0_4
    );
    
    bshifter13_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt13_5,
    data_in => vv,
    data_out => q_vv_vS0_5
    );
    
    bshifter13_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt13_6,
    data_in => vv,
    data_out => q_vv_vS0_6
    );
    
    bshifter13_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt13_7,
    data_in => vv,
    data_out => q_vv_vS0_7
    );
    
    bshifter13_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt13_8,
    data_in => vv,
    data_out => q_vv_vS0_8
    );
    
    bshifter13_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt13_9,
    data_in => vv,
    data_out => q_vv_vS0_9
    );
    
    bshifter13_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt13_10,
    data_in => vv,
    data_out => q_vv_vS0_10
    );
    
    bshifter14_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt14_1,
    data_in => vv,
    data_out => q_vv_vL0_1
    );
    
    bshifter14_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt14_2,
    data_in => vv,
    data_out => q_vv_vL0_2
    );
    
    bshifter14_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt14_3,
    data_in => vv,
    data_out => q_vv_vL0_3
    );
    
    bshifter14_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt14_4,
    data_in => vv,
    data_out => q_vv_vL0_4
    );
    
    bshifter14_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt14_5,
    data_in => vv,
    data_out => q_vv_vL0_5
    );
    
    bshifter14_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt14_6,
    data_in => vv,
    data_out => q_vv_vL0_6
    );
    
    bshifter14_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt14_7,
    data_in => vv,
    data_out => q_vv_vL0_7
    );
    
    bshifter14_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt14_8,
    data_in => vv,
    data_out => q_vv_vL0_8
    );
    
    bshifter14_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt14_9,
    data_in => vv,
    data_out => q_vv_vL0_9
    );
    
    bshifter14_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt14_10,
    data_in => vv,
    data_out => q_vv_vL0_10
    );
    
    bshifter15_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt15_1,
    data_in => vin,
    data_out => q_v_vS0_1
    );
    
    bshifter15_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt15_2,
    data_in => vin,
    data_out => q_v_vS0_2
    );
    
    bshifter15_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt15_3,
    data_in => vin,
    data_out => q_v_vS0_3
    );
    
    bshifter15_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt15_4,
    data_in => vin,
    data_out => q_v_vS0_4
    );
    
    bshifter15_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt15_5,
    data_in => vin,
    data_out => q_v_vS0_5
    );
    
    bshifter15_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt15_6,
    data_in => vin,
    data_out => q_v_vS0_6
    );
    
    bshifter15_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt15_7,
    data_in => vin,
    data_out => q_v_vS0_7
    );
    
    bshifter15_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt15_8,
    data_in => vin,
    data_out => q_v_vS0_8
    );
    
    bshifter15_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt15_9,
    data_in => vin,
    data_out => q_v_vS0_9
    );
    
    bshifter15_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt15_10,
    data_in => vin,
    data_out => q_v_vS0_10
    );
    
    bshifter16_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt16_1,
    data_in => vin,
    data_out => q_v_vL0_1
    );
    
    bshifter16_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt16_2,
    data_in => vin,
    data_out => q_v_vL0_2
    );
    
    bshifter16_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt16_3,
    data_in => vin,
    data_out => q_v_vL0_3
    );
    
    bshifter16_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt16_4,
    data_in => vin,
    data_out => q_v_vL0_4
    );
    
    bshifter16_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt16_5,
    data_in => vin,
    data_out => q_v_vL0_5
    );
    
    bshifter16_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt16_6,
    data_in => vin,
    data_out => q_v_vL0_6
    );
    
    bshifter16_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt16_7,
    data_in => vin,
    data_out => q_v_vL0_7
    );
    
    bshifter16_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt16_8,
    data_in => vin,
    data_out => q_v_vL0_8
    );
    
    bshifter16_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt16_9,
    data_in => vin,
    data_out => q_v_vL0_9
    );
    
    bshifter16_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt16_10,
    data_in => vin,
    data_out => q_v_vL0_10
    );
    
    bshifter17_1 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt17_1,
    data_in => qin,
    data_out => q_q0_1
    );
    
    bshifter17_2 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt17_2,
    data_in => qin,
    data_out => q_q0_2
    );
    
    bshifter17_3 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt17_3,
    data_in => qin,
    data_out => q_q0_3
    );
    
    bshifter17_4 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt17_4,
    data_in => qin,
    data_out => q_q0_4
    );
    
    bshifter17_5 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt17_5,
    data_in => qin,
    data_out => q_q0_5
    );
    
    bshifter17_6 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt17_6,
    data_in => qin,
    data_out => q_q0_6
    );
    
    bshifter17_7 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt17_7,
    data_in => qin,
    data_out => q_q0_7
    );
    
    bshifter17_8 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt17_8,
    data_in => qin,
    data_out => q_q0_8
    );
    
    bshifter17_9 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt17_9,
    data_in => qin,
    data_out => q_q0_9
    );
    
    bshifter17_10 : shifter
    PORT MAP ( 
    clk => clk,
    sign_extend => '1',
    shift_amt => shift_amt17_10,
    data_in => qin,
    data_out => q_q0_10
    );
    
    rom1_0 : rom1
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom1 );
    
    rom2_0 : rom2
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom2 );
    
    rom3_0 : rom3
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom3 );
    
    rom4_0 : rom_4
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom4 );
    
    rom5_0 : rom5
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom5 );
    
    rom6_0 : rom6
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom6 );
    
    rom7_0 : rom7
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom7 );
    
    rom8_0 : rom8
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom8 );
    
    rom9_0 : rom9
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom9 );
    
    rom10_0 : rom10
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom10 );
    
    rom11_0 : rom11
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom11 );
    
    rom12_0 : rom12
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom12 );
    
    rom13_0 : rom13
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom13 );
    
    rom14_0 : rom14
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom14 );
    
    rom15_0 : rom15
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom15 );
    
    rom16_0 : rom16
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom16 );
    
    rom17_0 : rom17
    Port Map  (
    clka => clk,
    addra => address,
    douta => out_rom17 );

END Behavioral;
--dt= 0.0001
--tau= 0.0064
--afn= 1.5625
--afp= -0.5625
--bfn= -1.125
--bfp= 3.125
--cfn= 0.0
--cfp= 7.46875
--agn= 1.0
--agp= 10.28125
--bgn= 0.40625
--bgp= 0.09375
--cgn= 0.0
--cgp= 0.09375
--ahn= 0.28125
--ahp= 9.125
--bhn= -7.1875
--bhp= 15.0
--chn= -2.8125
--chp= 140.1875
--rg= 0.0625
--rh= 15.71875
--phi= 4.75
--epsq= 0.0693359375
--epsu= 0.0
--I0= 2.375
--Ix= 36.4375
--nx= 1.0
--uth= 5.3125
--alpu= 0.25
--v_vv_vS=0.115966796875
--v_vv_vL=-0.041748046875
--v_v_vS=0.26092529296875
--v_v_vL=0.26092529296875
--v_n=-0.07421875
--v_q=-0.07421875
--v_Iin=2.704345703125
--n_vv_vS=0.015625
--n_vv_vL=0.16064453125
--n_v_vS=-0.0126953125
--n_v_vL=-0.030120849609375
--n_n=-0.015625
--q_vv_vS=0.00030422210693359375
--q_vv_vL=0.009885787963867188
--q_v_vS=0.0043792724609375
--q_v_vL=-0.2965736389160156
--q_q=-0.0010833740234375
--s_S=-0.00390625
--s_L=-0.015625
--v_c_vS=0.322265625
--v_c_vL=0.322265625
--n_c_vS=0.001953125
--n_c_vL=0.001953125
--q_c_vS=0.01171875
--q_c_vL=2.3759765625
--s_c_L=0.015625
--crf=0
--crg=0.0625
--crh=15.71875
--vini=-4.791015625
--nini=26.9375
--qini=-3.60546875
--vth=0