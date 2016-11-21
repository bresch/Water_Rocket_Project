%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author:       Mathieu Bresciani
% Date:         21.nov.2016
% Description:  
%               2D definition of a linearized rocket model with constant
%               velocity, small AOA and small tail-deflector angles
%               approximations. 
%               The rocket is a solid cylinder with flat wings (no lift 
%               when AOA is null) fixed at its center of mass and 
%               actuated tail-deflectors are used for control.
%               ==> Use Missile_Control_Loop for simulation.
%
% Angles definition:
%               alpha = Angle-Of-Attack (AOA)
%               delta = Tail-deflector angle
%               theta = Pitch angle
%               gamma = Flight-path angle (heading)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

Cl = 0.5;           % Wings drag coefficient
Cd = 1;             % Tail deflector drag coefficient 
l = 1;              % Length of the rocket
lr = -0.5;          % Length from tail to center of mass
rho = 1.225;        % Air density [kg/m^3]
Aw = 0.1*2 + 1*0.1; % Wings+Body projected surface (adapted for Cl)
At = 0.1;           % Tail deflector surface
m = 0.7;            % Total mass of the rocket
V = 10;             % Velocity (constant in this model)
R = 0.05;           % Body radius
J = 1/4*m*R^2 + 1/12*m*l^2; % Moment of inertia (cylinder)

Fz_a = Cl*rho*V^2/2*Aw;     % d(Fz)/d(alpha)
M_a = lr*Cd*rho*V^2/2*At;   % d(M)/d(alpha)
M_d = M_a;                  % d(M)/d(delta)

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