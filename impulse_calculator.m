clear all;
close all; 
clc;
data = xlsread("Input");
c = 2;     %C = the index of column for which impulse is required.
X = 1e-6;  %time spacing
time = data(:,1);
pressure = data(:,c);
pressure = pressure * 13.9; % multiply 13.9 with the raw data
AbsolutePressure = pressure + 0.911925;

subplot(3,1,1)
plot(time,pressure)
grid on
title("Reflected Pressure")
xlabel("Time (s)")
ylabel("Reflected Pressure (bar)")

Impusle = trapz(X,pressure)
cImpulse = cumtrapz(X,pressure);
Pmax = max(pressure);
Pmax_MPa = Pmax * 0.1
Pmax_MPa_Absolute = max(AbsolutePressure)

subplot(3,1,2)
plot(time,cImpulse)
title("Cumulative Impulse Per Second")
xlabel("Time (s)")
ylabel("cImpulse")
grid on

subplot(3,1,3)
plot(time,AbsolutePressure)
grid on
title("Absolute Reflected Pressure")
xlabel("Time (s)")
ylabel("Absolute Reflected Pressure (bar)")
