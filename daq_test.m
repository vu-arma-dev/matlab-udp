%%% SETTINGS
% Remote is the Teensy 4.1
% Local is this PC
ip_rmt = '192.168.1.46';
port_rmt = 28000;
port_lcl_enc = 28006;
port_lcl_pot = 28007;
port_lcl_tof = 28002;
port_lcl_he = 28005;

%%% CONSTANTS
num_string = 4;
num_pot = 2;
num_sdu = 5;
num_sensors = 40;
enc_pot_loops = 1;

%%% FORMATS
enc_val_format = strings(1, 4);
pot_val_format = strings(1, 2);
tof_val_format = strings(1, 40);
he_val_format = strings(1, 40);

enc_val_format(:) = 'single';
pot_val_format(:) = 'uint16';
tof_val_format(:) = 'uint8';
he_val_format(:) = 'single';

enc_val_format = cellstr(enc_val_format);
pot_val_format = cellstr(pot_val_format);
tof_val_format = cellstr(tof_val_format);
he_val_format = cellstr(he_val_format);

%%% UDP_msgr OBJECTS
udp_enc = UDP_msgr(ip_rmt, port_rmt, port_lcl_enc, enc_val_format);
udp_pot = UDP_msgr(ip_rmt, port_rmt, port_lcl_pot, pot_val_format);
udp_tof = UDP_msgr(ip_rmt, port_rmt, port_lcl_tof, tof_val_format);
udp_he = UDP_msgr(ip_rmt, port_rmt, port_lcl_he, he_val_format);

while 1
    for i = 1:(enc_pot_loops*num_sdu)
        [enc_data, enc_data_len] = udp_enc.receive();
        if enc_data_len
            fprintf("String Encoder: [%s]\n", join(string(enc_data), ','));
        end
        [pot_data, pot_data_len] = udp_pot.receive();
        if pot_data_len
            fprintf("MT10: [%s]\n", join(string(pot_data), ','));
        end
    end
    [tof_data, tof_data_len] = udp_tof.receive();
    if tof_data_len
        fprintf("VL6180X: [%s]\n", join(string(tof_data),','));
    end
    [he_data, he_data_len] = udp_he.receive();
    if he_data_len
        fprintf("MLX90393: [%s]\n", join(string(he_data),','));
    end
end
