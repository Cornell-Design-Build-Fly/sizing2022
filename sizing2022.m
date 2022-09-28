clear
clc

mtow = 4; %kg (to vary)
to_dist = 60/3.281; %meters
g = 9.81;%m/s^2
wcl = 14; %(to range between 10-14)
kg2oz = 35.274;
sqin2sqm = 1/1550;
rho = 1.225;
ar = 6; % to range from 6-10
clmax = [];
cl0 = [];
cd0 = [];

lift=mtow*g;
S=144*(mtow*kg2oz/wcl)^(2/3)*sqin2sqm;
b=sqrt(S*ar);
c = b/ar;
l_box = b/2;

vstall = sqrt(2*lift/(rho*S)./clmax);
vto = 1.2*vstall;
groundaccel = vto^2/(2*to_dist);
