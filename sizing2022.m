clear
clc


%% Constants and conversion factors
m2ft = 3.281;
m2in = 3.281*12;
mtow = 4; %kg (to vary)
to_dist = 50/m2ft; %meters
g = 9.81;%m/s^2
wcl = 14; %(to range between 10-14), a measure of how flyable the RC plane is
kg2oz = 35.274;
sqin2sqm = 1/1550;
rho = 1.225; %Standard air density
ar = 6; % to range from 6-10

%% Airfoil Stuff
clmax = [1.324; 1.442; 1.48; 1.49; 1.585; 1.757]; %ClarkV, NACA4412,SD7032, USA35b, SD7062, MH114
cl0 = [0.496; 0.482; 0.45; 0.622; 0.446; 0.864]; % For above airfoils
cd0 = [0.009; 0.008; 0.007; 0.009; 0.010; 0.011];% For above airfoils
max_thickness = [0.116; 0.12; 0.1; 0.116; 0.14; 0.13]; %Percentage, for above airfoils

%% Forces and wing sizing
lift=mtow*g; %At rotate and in cruise
S=144*(mtow*kg2oz/wcl)^(2/3)*sqin2sqm; %from https://www.sefsd.org/general-interest/wing-cube-loading-wcl/
b=sqrt(S*ar); %AR = b^2/S
b_in = b*m2ft*12;
c = b/ar; %For a rectangular wing

l_box = b/2; %m
l_box_in = l_box*m2ft*12;

%% Velocities and Thrust Derivation
vstall = sqrt(2*lift/(rho*S)./clmax); %lift equation
vto = 1.2*vstall; %20 percent F.O.S
groundaccel = vto.^2/(2*to_dist); %vf^2-v0^2 = 2a*delta_x
vcruise = sqrt(2*lift/(rho*S)./cl0); %lift equation

F_drag = 0.5*rho*S*vto.^2.*cd0; %N, Neglects drag due to fuselage
F_thrust = F_drag + mtow*groundaccel; %N, minimum required, likely an underrepresentation
T_to_W = F_thrust./(mtow*g);

%% Fuselage
max_fuselage_width = 0.2*b; %by comp rules
max_fuselage_width_in = 0.2*b*m2ft*12;
fuselage_width = 5/m2in; %5 inch (confirmed by mech)
fuselage_height = 5/m2in; %^
fuselage_length = 30/m2in; %Estimated from payloads required

%% Tail Sizing
Vv = 0.04; % Vertical tail volume ratio from Raymer Aircraft Design pg. 160
Vh = 0.7; % ^, but for hortizontal stab
tailarm = 1.0 ; %Played around with this to get a good number
Sv = Vv*b*S/tailarm; %From Raymer pg. 159
Sh = Vh*c*S/tailarm; %From Raymer pg. 159
ARh = 2.5; %Varied from 2-3
ARv = 1.5; % Given by Aero

b_h = sqrt(Sh*ARh); %Same as eqn for wingspan
b_h_in = b_h*m2in;
c_h = b_h/ARh; %Same as equation for wing chord

lambdav = 0.7; %From aero, empirical data from last year

b_v = sqrt(Sv*ARv);%Same as eqn for wingspan
b_v_in = b_v*m2in;
cv_root = 2*b_v/(ARv*(1+lambdav)); %Same eqn as wingspan, but with m.a.c instead
cv_tip = lambdav*cv_root; %lambda=ctip/croot
