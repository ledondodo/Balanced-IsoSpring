
clear
clc


E = 114e9;

l = 0.02;
b = 0.01;
h = 80e-6;
p = 0.02;

ka = 3*E*b*h^3*(l^2+3*p*l+3*p^2)/l^3;

r = 0.015;
Jr = 1;
k1 = ka;
k2 = ka;
kp = ka;



syms a b c d x y
B=[a;c;a];

A=[1,0,-b*y ; 0,1,-d*y ; 0,-b*x,1];
X=A\B;
X



% avec approx
keq0 = 2*ka/r^2 + k1 + k2;
meq0 = 4*Jr/r^2;

%[x,y] = meshgrid(1e-6:0.1:10,1e-6:0.1:10);

x = linspace(1e-6,0.5,10000);
ax = asin(x/r);
bx = asin(r*(1-cos(ax))/l);

%y = linspace(1e-6,0.5,10000);
%ay = asin(y/r);
%by = asin(r*(1-cos(ay))/l);

% sans approx
keq1 = (2*ka*ax.^2 + 4*kp*bx.^2)./x.^2 + (k1+k2);
plot(x,keq1);
%keq1 = (2*ka*ax.^2 + 4*kp*bx.^2)./x.^2 + (2*ka*ay.^2 + 4*kp*by.^2)./y.^2 + 2*(k1+k2);
%surf(real(x),real(y),real(keq1));
%colorbar;
