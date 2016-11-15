
clear all
close all

ve = 50;
mr0 = 0.5;
mProp = 0.3;
delta = 0.1;
g = 9.81;

% A = [
%     0 1;
%     0 0];
% B = [
%     0;
%     ve/mr];
% 
% C = [1 0];
% D = 0;

t_end = 9;
dt = 0.01;
nEpochs = t_end/dt + 1;
t = 0:dt:t_end;

mr = mr0;
a = 0;
v = 0;
x = 0;
mr_mem = zeros(1,nEpochs);
a_mem = zeros(1,nEpochs);
v_mem = zeros(1,nEpochs);
x_mem = zeros(1,nEpochs);
mr_mem(1) = mr;
a_mem(1)= a;
v_mem(1)= v;
x_mem(1)= x;

for k = 2:nEpochs
    
    if mr > mr0 - mProp
        mr = mr - delta*dt;
        aProp = ve/mr*delta;
    else
        aProp = 0;
    end
    a = aProp - g;
    v = v + a*dt;
    x = x + v*dt;
    
    mr_mem(k) = mr;
    a_mem(k) = a;
    v_mem(k) = v;
    x_mem(k) = x;
end

figure;
hold all
plot(t,mr_mem)
plot(t,a_mem)
plot(t,v_mem)
plot(t,x_mem)
hold off