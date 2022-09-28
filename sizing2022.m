clear
clc

mtow = 4; %kg (to vary)
to_dist = 60/3.281; %meters
g = 9.81;%m/s^2
wcl = 14; %(to range between 10-14)
kg2oz = 35.274;
sqin2sqm = 1/1550;
rho = 1.225; %Standard air density
ar = 6; % to range from 6-10

%% Airfoil Stuff
clmax = [1.324; 1.442; 1.48; 1.49; 1.585; 1.757]; %ClarkV, NACA4412,SD7032, USA35b, SD7062, MH114
cl0 = [0.496; 0.482; 0.45; 0.622; 0.446; 0.864]; % For above airfoils
cd0 = [0.009; 0.008; 0.007; 0.009; 0.010; 0.011];% For above airfoils

%% Forces and wing sizing
lift=mtow*g; %At rotate and in cruise
S=144*(mtow*kg2oz/wcl)^(2/3)*sqin2sqm; %from https://www.sefsd.org/general-interest/wing-cube-loading-wcl/
b=sqrt(S*ar); %AR = b^2/S
c = b/ar; %For a rectangular wing
l_box = b/2;

%% Velocities and Thrust Derivation
vstall = sqrt(2*lift/(rho*S)./clmax); %lift equation
vto = 1.2*vstall; %20 percent F.O.S
groundaccel = vto.^2/(2*to_dist); %vf^2-v0^2 = 2a
vcruise = sqrt(2*lift/(rho*S)./cl0); %lift equation

F_drag = 0.5*rho*S*vto.^2.*cd0; %Neglects drag due to fuselage
F_thrust = F_drag + mtow*groundaccel; %N, minimum required, likely an underrepresentation
T_to_W = F_thrust./(mtow*g);

%% Tail Sizing

