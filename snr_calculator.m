clc;
clear all;
close all;
\textcolor{green!65!blue}{%% Read Signals}
Signal_data = xlsread(".csv");      
A = xlsread("Signal");              \textcolor{green!65!blue}{%Raw signal}
F = xlsread("Filtered_Signal");     \textcolor{green!65!blue}{%Filtered signal}
N = 50000;                          \textcolor{green!65!blue}{%input('number of data points : ')}

\textcolor{green!65!blue}{%% Calculation}
\textcolor{green!65!blue}{%Energy of the Signal}
E = sum(power(F,2))
\textcolor{green!65!blue}{% Calculation of SNR}
C = A - F;
D = sum(power(C,2)); 
B = E/D;
SNR = 10*log(B)
\textcolor{green!65!blue}{% Calculation of RMSE}
G = D/N;
RSME = power(G,0.5)
