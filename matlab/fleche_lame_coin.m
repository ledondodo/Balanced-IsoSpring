%equation de la flèche de la lame coin quand on est à la course f_adm = 4mm

syms P M
E=114e9
I=1.8e-16
l=11.725e-3
theta= 0.26993
fadm=0.004
A=[l*l/(2*E*I) -l/(E*I);(l*l*l)/(3*E*I) -(l*l)/(2*E*I)];
B=[theta;fadm];
X=linsolve(A,B);

%M et P sont les moment et force superposés qui permettent
%d'avoir la déflection voulue en fonction de la géométrie et
%du déplacement du système 
P=X(1) 
M=X(2)

%fleche en fonction de la position le long de la lame
x = [0:0.0001:11.725e-3];
for j=1:length(x)
    v(j)=((P*x(j)^2)/(6*E*I))*(3*l-x(j))-(M*x(j)^2)/(2*E*I);
%   delta_v est la différence entre la droite passant par l'origine
%   et l'extrémité déflectée et la flèche
    delta_v(j)= v(j)- (fadm/l)*x(j);

end
figure
plot(x,v)
hold on
plot(x,(fadm/l)*x)
hold on
hold off
% plot(delta_v)

d_max = max(abs(delta_v))

