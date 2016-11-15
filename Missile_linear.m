clear all

Cl = 0.5;
Cd = 1;
l = 1;
lr = -0.5;
rho = 1.225;
Aw = 0.1*2 + 1*0.1;
At = 0.1;
m = 0.7;
V = 10;
R = 0.05;
J = 1/4*m*R^2 + 1/12*m*l^2;

Fz_a = Cl*rho*V^2/2*Aw;
M_a = lr*Cd*rho*V^2/2*At;
M_d = M_a;

Drag = @(delta,alpha,A,Cdrag) Cdrag*rho*V^2/2*A*sin(delta+alpha);

A = [
    -Fz_a/m*V   1;
    M_a/J       0];

B = [
    0;
    M_d/J];

C = [
    0       1;
    Fz_a/m  0];

D = [
    0;
    0];

s = tf([1 0],1);
I = eye(size(A));
G = C*(s*I-A)^(-1)*B + D;
G1 = G(1);
G2 = G(2);