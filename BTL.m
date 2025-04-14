clc;
clear all;
close all;

% Tạo tín hiệu sóng sin gốc
t = 0:0.0001:2; % Tạo một vector thời gian từ 0 đến 2 với bước 0.0001
F = 1; % Tần số của sóng sin
x = 10*sin(2*pi*F*t); % Tạo tín hiệu sóng sin

% Hiển thị tín hiệu sóng sin gốc
figure; % Tạo cửa sổ đồ thị mới
plot(t,x) % Vẽ tín hiệu sóng sin
title('Tín hiệu cho trước');

Fs = 10; % Tần số lấy mẫu
n = 0:(2*Fs)-1; % Tạo một vector cho số mẫu
xs = 10*sin(2*pi*F*n/Fs); % Lấy mẫu tín hiệu sóng sin

% Kiểm tra tần số có nằm trong vùng Nyquist không
if F < -Fs/2 || F > Fs/2
    disp('Tần số tín hiệu không nằm trong vùng Nyquist.');
    F = mod(Fs, F); % Tính lại tần số khôi phục
    disp(['Tần số khôi phục mới: ', num2str(F)]);
else
    F = F;
end

% Hiển thị tín hiệu sau khi lấy mẫu
figure; % Tạo cửa sổ đồ thị mới
stem(n,xs); % Vẽ tín hiệu đã lấy mẫu bằng biểu đồ stem
title('Tín hiệu sau lấy mẫu');

nbits = 3; % Số bit cho lượng tử hóa
L = 2^nbits; % Số mức lượng tử hóa
signal_min = min(x); % Giá trị nhỏ nhất của tín hiệu đã lấy mẫu
signal_max = max(x); % Giá trị lớn nhất của tín hiệu đã lấy mẫu
Q = (signal_max - signal_min)/L; % Kích thước bước lượng tử hóa
quantized_signal = round((xs - signal_min)/Q)*Q + signal_min; % Lượng tử hóa tín hiệu

% Tạo các mức lượng tử hóa
q_levels = signal_min + (0:(L-1)) * Q;

% Hiển thị các mức lượng tử hóa
figure;
stem(0:L-1, q_levels, 'filled');
title('Các mức lượng tử hóa');
xlabel('n (0 -> 255)');
ylabel('Giá trị mức lượng tử (xmin -> xmax)');
hold on;
plot([0 L-1], [signal_min signal_min], 'r--', 'DisplayName', 'xmin');
plot([0 L-1], [signal_max signal_max], 'g--', 'DisplayName', 'xmax');
legend;
hold off;

% Hiển thị tín hiệu đã lượng tử hóa
figure;
stem(n,quantized_signal); % Vẽ tín hiệu đã lượng tử hóa
title('Tín hiệu sau lượng tử'); % Tiêu đề cho tín hiệu lượng tử hóa
xlabel('n');
ylabel('Biên độ');

quantized_error = xs - quantized_signal; % Tính sai số lượng tử

% Hiển thị đồ thị sai số lượng tử
figure;
stem(n,quantized_error); % Vẽ sai số lượng tử
title('Sai số lượng tử'); % Tiêu đề cho sai số lượng tử
xlabel('n');
ylabel('Sai số biên độ');

% Tái tạo tín hiệu liên tục theo t
reconstructed_t = linspace(min(t), max(t), length(n)); % Tạo lại thời gian với độ dài bằng tín hiệu đã lấy mẫu
figure;
stairs(reconstructed_t, quantized_signal, '-'); % Vẽ tín hiệu bằng cách nối các điểm biên độ theo t
title('Tín hiệu sau khôi phục'); % Tiêu đề
xlabel('t');
ylabel('Biên độ');
