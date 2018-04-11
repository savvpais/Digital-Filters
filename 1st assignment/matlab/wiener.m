%Clear workspace and load sound data
clear;
close all;
load('sounds.mat');

%Wiener filet parameters
n_coeff = 500;
max_lag = n_coeff - 1;

r_uu = xcorr(u, max_lag, 'bias');
R = toeplitz(r_uu(n_coeff:-1:1));

r_du = xcorr(u, d, max_lag, 'bias');
p = r_du(n_coeff:2 * n_coeff - 1);

%Calculate coefficients
w = R \ p;

%Filter sound
y = conv(u, w);
e = d - y(1:length(d));

%Play and save result
sound(e, Fs);
audiowrite('result.wav', e, Fs);
fprintf('Press Enter to stop playing the song.\n')
pause;
clear sound;
