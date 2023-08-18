%%% SETTINGS
% Remote is the Teensy 4.1
% Local is this PC
ip_rmt = '192.168.1.46';
port_rmt = 28000;
port_lcl_enc = 28002;
port_lcl_pot = 28004;
port_lcl_tof = 28006;
port_lcl_hfx = 28008;

%%% CONSTANTS
num_string = 4;
num_pot = 2;
num_sdu = 5;
num_sensors = 40;
enc_pot_loops = 1;

%%% PACKET SIZES
size_packet_enc = 20;
size_packet_pot = 4;
size_packet_tof = 80;
size_packet_hfx = 200;

%%% FORMATS
enc_val_format = strings(1, size_packet_enc);
pot_val_format = strings(1, size_packet_pot);
tof_val_format = strings(1, size_packet_tof);
hfx_val_format = strings(1, size_packet_hfx);

enc_val_format(:) = 'uint8';
pot_val_format(:) = 'uint8';
tof_val_format(:) = 'uint8';
hfx_val_format(:) = 'uint8';

enc_val_format = cellstr(enc_val_format);
pot_val_format = cellstr(pot_val_format);
tof_val_format = cellstr(tof_val_format);
hfx_val_format = cellstr(hfx_val_format);

%%% UDP_msgr OBJECTS
udp_enc = UDP_msgr(ip_rmt, port_rmt, port_lcl_enc, enc_val_format);
udp_pot = UDP_msgr(ip_rmt, port_rmt, port_lcl_pot, pot_val_format);
udp_tof = UDP_msgr(ip_rmt, port_rmt, port_lcl_tof, tof_val_format);
udp_hfx = UDP_msgr(ip_rmt, port_rmt, port_lcl_hfx, hfx_val_format);

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
    [hfx_data, hfx_data_len] = udp_hfx.receive();
    if hfx_data_len
        fprintf("MLX90393: [%s]\n", join(string(hfx_data),','));
    end
end
