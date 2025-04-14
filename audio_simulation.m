clc;
clear all;
close all;

% Đọc tín hiệu âm thanh
[y, defaultFs] = audioread('yes.mp3'); % Đọc tần số lấy mẫu mặc định từ file âm thanh
info = audioinfo('yes.mp3'); % Lấy thông tin về file âm thanh

% Cho phép người dùng chọn tần số lấy mẫu
Fs = input(['Nhập tần số lấy mẫu (mặc định: ', num2str(defaultFs), ' Hz): ']);
if isempty(Fs) % Nếu không nhập gì, sử dụng tần số lấy mẫu mặc định
    Fs = defaultFs;
end

% Tạo vector thời gian cho tín hiệu gốc
t = 0:1/defaultFs:(length(y)-1)/defaultFs;

% Hiển thị tín hiệu âm thanh đầu vào theo tần số lấy mẫu mặc định
figure(1);
subplot(4,1,1);
plot(t, y); % Vẽ tín hiệu âm thanh gốc
xlabel('Time');
ylabel('Amplitude');
title('Tín hiệu âm thanh gốc');

% Lấy mẫu lại tín hiệu âm thanh nếu tần số lấy mẫu thay đổi
if Fs ~= defaultFs
    y_resampled = resample(y, Fs, defaultFs);
else
    y_resampled = y;
end

% Tạo vector thời gian cho tín hiệu đã lấy mẫu lại
t_resampled = 0:1/Fs:(length(y_resampled)-1)/Fs;

% Biểu diễn rời rạc tín hiệu âm thanh theo tần số Fs đã nhập
figure(1);
subplot(4,1,2);
stem(t_resampled, y_resampled, 'Marker', 'none');
xlabel('Time');
ylabel('Amplitude');
title('Rời rạc tín hiệu âm thanh');

% Lượng tử hóa tín hiệu
nbits = 3;
L = 2^nbits; % Số mức lượng tử hóa
y_max = max(y_resampled);
y_min = min(y_resampled);
Q = (y_max - y_min) / L; % Kích thước bước lượng tử hóa
Q = Q(1); % Đảm bảo Q là một giá trị vô hướng
q = Q .* [0:L-1]; % Đảm bảo kích thước phù hợp
q = q - ((L-1)/2) * Q;
yquan = round((y_resampled - y_min) / Q) * Q + y_min; % Áp dụng lượng tử hóa với làm tròn về các mức lượng tử

% Hiển thị các mức lượng tử hóa
subplot(4,1,3);
stem(q, 'filled'); % Vẽ các mức lượng tử hóa
ylabel('Amplitude');
title('Các mức lượng tử');

% Hiển thị tín hiệu đã lượng tử hóa
subplot(4,1,4);
stem(t_resampled, yquan, 'Marker', 'none');
xlabel('Time');
ylabel('Amplitude');
title('Lượng tử tín hiệu âm thanh');

% Tính toán sai số lượng tử
quantization_error = y_resampled - yquan;

% Hiển thị đồ thị sai số lượng tử
figure(3);
stem(t_resampled, quantization_error,'marker','none');
xlabel('Time');
ylabel('biên độ sai số');
title('sai số lượng tử');

% Hiển thị tín hiệu sau khôi phục riêng
figure(2);
reconstructed_t = linspace(min(t_resampled), max(t_resampled), length(t_resampled));
stairs(reconstructed_t, yquan, ' '); % Sử dụng hàm stairs
title('Tín hiệu sau khôi phục');
xlabel('t');
ylabel('Biên độ');
