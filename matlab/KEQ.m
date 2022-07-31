
clear
clc




% RESOLUTION
syms E l1 b1 h1 l2 b2 h2 l3 b3 h3 p rext lr e rpiv bpiv
syms Ka Kp
syms a b c d x y
syms A B C K11 K21 K22 K12
syms AX BX

Ka = 3*E*b3*h3^3*(l3^2+3*p*l3+3*p^2)/l3^3/4;
Kp = 2*E*bpiv*e^2.5/9/pi/sqrt(rpiv);

a = 2*E*b1*h1^3/l1^3;
b = -12/pi^2/l1;
c = 2*E*b2*h2^3/l2^3;
d = -12/pi^2/l2;

B=[a;c;a];
A=[1,0,-b*y ; 0,1,-d*y ; 0,-b*x,1];
C=A\B;

AX = asin(x/rext);
BX = asin(rext*(1-cos(AX))/lr);

K11=C(1);
K21=C(2);
K22=C(3);
K12=a+b*K21*x;

Keq = (2*Ka*AX^2 + 4*Kp*BX^2)/x^2 + (K11+K21);
DKeq = gradient(Keq);

Keq

%surf(X,Y,K11);
%surf(X,Y,K21);
%surf(X,Y,K22);
%surf(X,Y,K12);

%C = double(DKeq<-0.2)+double(DKeq<0.2);

%surf(X,Y,Keq);
%colormap([1,1,0 ; 1,0,0 ; 0,0,1 ; 1,0,1]);
%colorbar;
%shading interp;

