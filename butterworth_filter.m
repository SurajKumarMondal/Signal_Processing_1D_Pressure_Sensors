clc;
clear all;
close all;
Input = xlsread("data");
\textcolor{green!65!blue}{%% Variable declaration}
t = Input(:,1);          \textcolor{green!65!blue}{% Time data}
p1 = Input(:,2);         \textcolor{green!65!blue}{% Reading of 1st pressure sensor}
p2 = Input(:,3);         \textcolor{green!65!blue}{% Reading of 2nd pressure sensor}
p3 = Input(:,4);         \textcolor{green!65!blue}{% Reading of 3rd pressure sensor}
p4 = Input(:,5);         \textcolor{green!65!blue}{% Reading of 4th pressure sensor}
p5 = Input(:,6);         \textcolor{green!65!blue}{% Reading of 5th pressure sensor}
p6 = Input(:,7);         \textcolor{green!65!blue}{% Reading of 6th pressure sensor}
input("Maximum run time :");
input("Horizontal Offset (s) : ");
input("Horizontal Resolution (s) : ");

\textcolor{green!65!blue}{%% FFT calculation}
nfft = length(t);        \textcolor{green!65!blue}{%length of time domain signal}
n = 2^nextpow2(nfft);    \textcolor{green!65!blue}{%length of signal in power of 2}
ff_1 = fft(p1, n);       \textcolor{green!65!blue}{%fft of 1st pressure signal}
f_1 = ff_1(1: n/2);      \textcolor{green!65!blue}{%fft of half domain}
ff_2 = fft(p2, n);       \textcolor{green!65!blue}{%fft of 2nd pressure signal}
f_2 = ff_2(1: n/2);
ff_3 = fft(p3, n);       \textcolor{green!65!blue}{%fft of 3rd pressure signal}
f_3 = ff_3(1: n/2);
ff_4 = fft(p4, n);       \textcolor{green!65!blue}{%fft of 4th pressure signal}
f_4 = ff_4(1: n/2);
ff_5 = fft(p5, n);       \textcolor{green!65!blue}{%fft of 5th pressure signal}
f_5 = ff_5(1: n/2);
ff_6 = fft(p6, n);       \textcolor{green!65!blue}{%fft of 6th pressure signal}
f_6 = ff_6(1: n/2);

\textcolor{green!65!blue}{%% Butterworth Filter}
[m,l] = size(t);
t1=t(m,1);
frq=m/t1;
nf=frq/2;                 \textcolor{green!65!blue}{%Nyquist Frequency}
input('Enter the cut off frequency in Hz :');
CTF = ['Cutoff frequency for sensors is: ',num2str(freq),' Hz.'];
disp(CTF)
[a,b] = butter(3,freq/nf);\textcolor{green!65!blue}{%This is to determine the coeffs of the filter where} 
                          \textcolor{green!65!blue}{% a and b are the coeffs of the numerator and the }
                          \textcolor{green!65!blue}{% denominator respectively.}

fd_1=filter(a,b,p1);      \textcolor{green!65!blue}{%filtered data of 1st sensor}
fd_2=filter(a,b,p2);      \textcolor{green!65!blue}{%filtered data of 2nd sensor}
fd_3=filter(a,b,p3);      \textcolor{green!65!blue}{%filtered data of 3rd sensor}
fd_4=filter(a,b,p4);      \textcolor{green!65!blue}{%filtered data of 4th sensor}
fd_5=filter(a,b,p5);      \textcolor{green!65!blue}{%filtered data of 5th sensor}
fd_6=filter(a,b,p6);      \textcolor{green!65!blue}{%filtered data of 6th sensor}

\textcolor{green!65!blue}{%% Plots for bode plot for the filter}
figure(1);
freqz(a,b)
sgtitle("Bode Plot for 3rd order Butterworth filter with cutoff = 65 kHz")

\textcolor{green!65!blue}{%% Conversion of filtered data into bar}
FD_1 = (fd_1 * 13.79) + 0.91;
FD_2 = (fd_2 * 13.79) + 0.91;
FD_3 = (fd_3 * 13.79) + 0.91;
FD_4 = (fd_4 * 13.79) + 0.91;
FD_5 = (fd_5 * 13.79) + 0.91;
FD_6 = (fd_6 * 13.79) + 0.91;

\textcolor{green!65!blue}{%% Plots of air}
figure(2)
plot(t,FD_1, 'LineWidth', 1.5, 'DisplayName', 'First Sensor')
xlabel('Time (s)', 'fontname','Times New Roman', 'fontsize',18); 
ylabel('Pressure (bar)', 'fontname','Times New Roman', 'fontsize',18)
hold on
plot(t,FD_2, 'LineWidth', 1.5, 'DisplayName', 'Second Sensor')
ylim([0 15])
xlim([-0.001 0.012])
legend({}, 'Location', 'northeast', 'fontname','Times New Roman', 'fontsize',16)

\textcolor{green!65!blue}{%% Plots in Sand}
figure(3)
plot(t,FD_3, 'LineWidth', 1.5, 'DisplayName', 'PD_1')
xlabel('Time (s)', 'fontname','Times New Roman', 'fontsize',18); 
ylabel('Pressure (bar)', 'fontname','Times New Roman', 'fontsize',18)
hold on
plot(t,FD_4, 'LineWidth', 1.5, 'DisplayName', 'PD_2')
plot(t,FD_5, 'LineWidth', 1.5, 'DisplayName', 'PD_3')
plot(t,FD_6, 'LineWidth', 1.5, 'DisplayName', 'PD_4')
ylim([0 15])
xlim([-0.001 0.012])
legend({}, 'Location', 'northeast', 'fontname','Times New Roman', 'fontsize',16)
