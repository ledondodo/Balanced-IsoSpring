function projet_tab

clear
clc

% == CONSTANTES ==
font_label=15;
font_field=18;
space_field=20;
space_down=40;
space_tab=200;

f = uifigure(Name='TAB',Position=[1000 500 500 800]);
tabgp = uitabgroup(f,Units='normalized',Position=[.05 .05 .9 .9]);

xaxis = @(pos) 10+pos;
yaxis = @(pos) f.Position(4)-20-pos;

% ============= TAB 1 : DIMENSIONS =============
tab1 = uitab(tabgp,'Title','Dimensions',Scrollable='on');
lbl_tab1 = uilabel(tab1,Text='Dimensions Projet CDM', ...
           Position=[xaxis(0) yaxis(0) 200 30],FontSize=font_label, ...
           WordWrap="on",Enable='off',FontWeight='bold');
btn_run = uibutton(tab1,'push',Position=[xaxis(370) yaxis(20) 40 40], ...
          Text='Run',FontSize=12,ButtonPushedFcn=@(btn_run,event) run);

% E - Young Modulus [Pa] % Acier Maraging W720: 193 GPa
E_=114e9;
lbl_E = uilabel(tab1,Position=[xaxis(0) yaxis(space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off');
E_i = '[Pa] E = ';
field_E = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(space_down) 100 30],FontSize=font_field, ...
          Value=E_,ValueChangedFcn=@(field_k,event) newField(field_k,lbl_E,E_i));
lbl_E.Position(1)=space_field+field_E.Position(3);
update_E;

% sigD - contrainte MX [Pa] % Acier Maraging W720: 735MPa
sigD_ = 500e6;
lbl_sigD = uilabel(tab1,Position=[xaxis(0) yaxis(2*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
sigD_i = '[Pa] $\sigma_{D} = ';
field_sigD = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(2*space_down) 100 30], ...
           FontSize=font_field,Value=sigD_, ...
           ValueChangedFcn=@(field_sigD,event) newField(field_sigD,lbl_sigD,sigD_i));
lbl_sigD.Position(1)=space_field+field_sigD.Position(3);
update_sigD;

% sigadm - contrainte admissible [Pa]
SF=1.65;
sigadm_ = sigD_/SF;
lbl_sigadm = uilabel(tab1,Position=[xaxis(0) yaxis(3*space_down+10) 400 50], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
sigadm_i = '[Pa] $\sigma_{adm} = \frac{\sigma_{D}}{SF} = ';
update_sigadm;

% l - longueur lame [m]
l_=0.0165;
lbl_l = uilabel(tab1,Position=[xaxis(0) yaxis(4*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off');
l_i = '[m] l = ';
field_l = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(4*space_down) 100 30], ...
           FontSize=font_field,Value=l_, ...
           ValueChangedFcn=@(field_l,event) newField(field_l,lbl_l,l_i));
lbl_l.Position(1)=space_field+field_l.Position(3);
update_l;

% h - epaisseur lame [m]
h_ = 60e-6;
lbl_h = uilabel(tab1,Position=[xaxis(0) yaxis(5*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off');
h_i = '[m] h = ';
field_h = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(5*space_down) 100 30], ...
           FontSize=font_field,Value=h_, ...
           ValueChangedFcn=@(field_h,event) newField(field_h,lbl_h,h_i));
lbl_h.Position(1)=space_field+field_h.Position(3);
update_h;

% b - largeur lame [m]
b_ = 0.002;
lbl_b = uilabel(tab1,Position=[xaxis(0) yaxis(6*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off');
b_i = '[m] b = ';
field_b = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(6*space_down) 100 30], ...
           FontSize=font_field,Value=b_, ...
           ValueChangedFcn=@(field_b,event) newField(field_b,lbl_b,b_i));
lbl_b.Position(1)=space_field+field_b.Position(3);
update_b;

% I - moment d'inertie [m^4]
I_ = b_*h_^3/12;
lbl_I = uilabel(tab1,Position=[xaxis(0) yaxis(7*space_down+10) 400 50], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
I_i = '[$m^4$] $I = \frac{bh^3}{12} = ';
update_I;

% p - distance coin [m]
p_ = 0.000275;
lbl_p = uilabel(tab1,Position=[xaxis(0) yaxis(8*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off');
p_i = '[m] p = ';
field_p = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(8*space_down) 100 30], ...
           FontSize=font_field,Value=p_, ...
           ValueChangedFcn=@(field_p,event) newField(field_p,lbl_p,p_i));
lbl_p.Position(1)=space_field+field_p.Position(3);
update_p;

% e - epaisseur du col [m]
e_ = 50e-6;
lbl_e = uilabel(tab1,Position=[xaxis(0) yaxis(9*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off');
e_i = '[m] e = ';
field_e = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(9*space_down) 100 30], ...
           FontSize=font_field,Value=e_, ...
           ValueChangedFcn=@(field_e,event) newField(field_e,lbl_e,e_i));
lbl_e.Position(1)=space_field+field_e.Position(3);
update_e;

% r - rayon du col [m]
r_ = 0.002;
lbl_r = uilabel(tab1,Position=[xaxis(0) yaxis(10*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off');
r_i = '[m] r = ';
field_r = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(10*space_down) 100 30], ...
           FontSize=font_field,Value=r_, ...
           ValueChangedFcn=@(field_r,event) newField(field_r,lbl_r,r_i));
lbl_r.Position(1)=space_field+field_r.Position(3);
update_r;

% rmax - r<5hmin [m]
rmax_ = 5*e_;
lbl_rmax = uilabel(tab1,Position=[xaxis(0) yaxis(11*space_down) 300 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
rmax_i = '[m] $r<5e=r_{max}$ = ';
update_rmax;

% Jr - inertie reduite [kg*m^2] % Jr = 0.5*rho*e*(rext^4-rin^4)*pi
Jr_ = 1.472e-6;
lbl_Jr = uilabel(tab1,Position=[xaxis(0) yaxis(12*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
Jr_i = '[$m^4$] $J_r$ = ';
field_Jr = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(12*space_down) 100 30], ...
           FontSize=font_field,Value=Jr_, ...
           ValueChangedFcn=@(field_Jr,event) newField(field_Jr,lbl_Jr,Jr_i));
lbl_Jr.Position(1)=space_field+field_Jr.Position(3);
update_Jr;

% m0 - masse mobile
m0_ = 1.1e-4;
lbl_m0 = uilabel(tab1,Position=[xaxis(0) yaxis(13*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
m0_i = '[kg] $m_0$ = ';
field_m0 = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(13*space_down) 100 30], ...
           FontSize=font_field,Value=m0_, ...
           ValueChangedFcn=@(field_m0,event) newField(field_m0,lbl_m0,m0_i));
lbl_m0.Position(1)=space_field+field_m0.Position(3);
update_m0;

% m1 - masse table a lame
m1_ = 1.46e-4;
lbl_m1 = uilabel(tab1,Position=[xaxis(0) yaxis(14*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
m1_i = '[kg] $m_1$ = ';
field_m1 = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(14*space_down) 100 30], ...
           FontSize=font_field,Value=m1_, ...
           ValueChangedFcn=@(field_m1,event) newField(field_m1,lbl_m1,m1_i));
lbl_m1.Position(1)=space_field+field_m1.Position(3);
update_m1;

% mb - masse barres de liaison
mb_ = 8.9e-5;
lbl_mb = uilabel(tab1,Position=[xaxis(0) yaxis(15*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
mb_i = '[kg] $m_b$ = ';
field_mb = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(15*space_down) 100 30], ...
           FontSize=font_field,Value=mb_, ...
           ValueChangedFcn=@(field_mb,event) newField(field_mb,lbl_mb,mb_i));
lbl_mb.Position(1)=space_field+field_mb.Position(3);
update_mb;

% rho - masse volumique MX
rho_ = 4510;
lbl_rho = uilabel(tab1,Position=[xaxis(0) yaxis(16*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
rho_i = '[$\frac{kg}{m^3}$] $\rho$ = ';
field_rho = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(16*space_down) 100 30], ...
           FontSize=font_field,Value=rho_, ...
           ValueChangedFcn=@(field_rho,event) newField(field_rho,lbl_rho,rho_i));
lbl_rho.Position(1)=space_field+field_rho.Position(3);
update_rho;

% keq - rigidite equivalente systeme
keq_ = 500;
lbl_keq = uilabel(tab1,Position=[xaxis(0) yaxis(17*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
keq_i = '[$\frac{N}{m}$] $k_{eq}$ = ';
field_keq = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(17*space_down) 100 30], ...
           FontSize=font_field,Value=keq_, ...
           ValueChangedFcn=@(field_keq,event) newField(field_keq,lbl_keq,keq_i));
lbl_keq.Position(1)=space_field+field_keq.Position(3);
update_keq;

% Rf - rayon ou la force est applpiquee sur les roues [m]
Rf_ = 0.015;
lbl_Rf = uilabel(tab1,Position=[xaxis(0) yaxis(18*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
Rf_i = '[m] $R_{f}$ = ';
field_Rf = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(18*space_down) 100 30], ...
           FontSize=font_field,Value=Rf_, ...
           ValueChangedFcn=@(field_Rf,event) newField(field_Rf,lbl_Rf,Rf_i));
lbl_Rf.Position(1)=space_field+field_Rf.Position(3);
update_Rf;


% ec - epaisseur couche ajoutee [m]
ec_ = 0.01076;
lbl_ec = uilabel(tab1,Position=[xaxis(0) yaxis(19*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
ec_i = '[m] $e_{c}$ = ';
field_ec = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(19*space_down) 100 30], ...
           FontSize=font_field,Value=ec_, ...
           ValueChangedFcn=@(field_ec,event) newField(field_ec,lbl_ec,ec_i));
lbl_ec.Position(1)=space_field+field_ec.Position(3);
update_ec;

% Rext - rayon roues [m]
Rext_ = 0.013;
lbl_Rext = uilabel(tab1,Position=[xaxis(0) yaxis(20*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
Rext_i = '[m] $R_{ext}$ = ';
field_Rext = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(20*space_down) 100 30], ...
           FontSize=font_field,Value=Rext_, ...
           ValueChangedFcn=@(field_Rext,event) newField(field_Rext,lbl_Rext,Rext_i));
lbl_Rext.Position(1)=space_field+field_Rext.Position(3);
update_Rext;

% rho2 - rho cuivre [kg/m^3]
rho2_ = 8910;
lbl_rho2 = uilabel(tab1,Position=[xaxis(0) yaxis(21*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
rho2_i = '$[kg/m^3] \rho_2 = $';
field_rho2 = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(21*space_down) 100 30], ...
           FontSize=font_field,Value=rho2_, ...
           ValueChangedFcn=@(field_rho2,event) newField(field_rho2,lbl_rho2,rho2_i));
lbl_rho2.Position(1)=space_field+field_rho2.Position(3);
update_rho2;

% mMX - masse rajoutee aux roues [kg]
mmx_ = 0.1;
lbl_mmx = uilabel(tab1,Position=[xaxis(0) yaxis(22*space_down) 300 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
mmx_i = '[kg] $m_{MX}$ = ';
update_mmx;

% Q - quality factor
Q_ = 900;
lbl_Q = uilabel(tab1,Position=[xaxis(0) yaxis(23*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
Q_i = 'Q = ';
field_Q = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(23*space_down) 100 30], ...
           FontSize=font_field,Value=Q_, ...
           ValueChangedFcn=@(field_Q,event) newField(field_Q,lbl_Q,Q_i));
lbl_Q.Position(1)=space_field+field_Q.Position(3);
update_Q;

% A - amplitude [m]
A_ = 0.004;
lbl_A = uilabel(tab1,Position=[xaxis(0) yaxis(24*space_down) 200 30], ...
                FontSize=font_label,WordWrap="on",Enable='off',Interpreter='latex');
A_i = '[m] A = ';
field_A = uieditfield(tab1,'numeric',Position=[xaxis(0) yaxis(24*space_down) 100 30], ...
           FontSize=font_field,Value=A_, ...
           ValueChangedFcn=@(field_A,event) newField(field_A,lbl_A,A_i));
lbl_A.Position(1)=space_field+field_A.Position(3);
update_A;



% ====================================================================================================
% ====================================================================================================


% ============= TAB 2 : RESULTATS =============
tab2 = uitab(tabgp,'Title','Resultats',Scrollable='on');
lbl_tab2 = uilabel(tab2,Text='Calculs et Résultats', ...
           Position=[xaxis(0) yaxis(0) 200 30],FontSize=font_label, ...
           WordWrap="on",Enable='off',FontWeight='bold');


% == DOUBLE LAMES ==
lbl_1 = uilabel(tab2,Text='Table à lames', ...
           Position=[xaxis(0) yaxis(space_down) 200 30],FontSize=font_label, ...
           WordWrap="on",Enable='off');

% f1 - course admissible [m]
f1_=1;
lbl_f1 = uilabel(tab2,Position=[xaxis(0) yaxis(2*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$f_{adm1}=\frac{\sigma_{adm}l^2}{3Eh}$');
lbl_f1_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(2*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(f1_));
update_f1;

% k1 - rigidite
k1_=1;
lbl_k1 = uilabel(tab2,Position=[xaxis(0) yaxis(3*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$k_{1}=\frac{24EI}{l^3}$');
lbl_k1_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(3*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(k1_));
update_k1;

% lambda1 - mouvement parasite [m]
lamb1_=1;
lbl_lamb1 = uilabel(tab2,Position=[xaxis(0) yaxis(4*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$\lambda_{1}=\frac{3f_{adm1}^2}{5l}$');
lbl_lamb1_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(4*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(lamb1_));
update_lamb1;


% == LAME SIMPLE ==
lbl_2 = uilabel(tab2,Text='Lame simple', ...
           Position=[xaxis(0) yaxis(5*space_down) 200 30],FontSize=font_label, ...
           WordWrap="on",Enable='off');

% f2 - course admissible [m]
f2_=1;
lbl_f2 = uilabel(tab2,Position=[xaxis(0) yaxis(6*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$f_{adm2}=\frac{\sigma_{adm}l^2}{3Eh}$');
lbl_f2_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(6*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(f2_));
update_f2;

% k2 - rigidite
k2_=1;
lbl_k2 = uilabel(tab2,Position=[xaxis(0) yaxis(7*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$k_{2}=\frac{12EI}{l^3}$');
lbl_k2_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(7*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(k2_));
update_k2;


% == LAME COIN - SIMPLE ==
lbl_3 = uilabel(tab2,Text='Lames coin - simple', ...
           Position=[xaxis(0) yaxis(8*space_down) 200 30],FontSize=font_label, ...
           WordWrap="on",Enable='off');

% theta3 - course angulaire [rad], [°]
th3_=1;
lbl_th3 = uilabel(tab2,Position=[xaxis(0) yaxis(9*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$\theta_{3}=\frac{\sigma_{adm}l^2}{E(2hl+3hp)}$');
lbl_th3_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(9*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(th3_));
lbl_th3_val_deg = uilabel(tab2,Position=[xaxis(space_tab+120) yaxis(9*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(th3_*180/2/pi));
update_th3;

% k3 - rigidite
k3_=1;
lbl_k3 = uilabel(tab2,Position=[xaxis(0) yaxis(10*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$k_{3}=\frac{8EI(l^2+3pl+3p^2)}{l^3}$');
lbl_k3_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(10*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(k3_));
update_k3;


% == PIVOTS - COLS ==
lbl_4 = uilabel(tab2,Text='Pivots - cols', ...
           Position=[xaxis(0) yaxis(11*space_down) 200 30],FontSize=font_label, ...
           WordWrap="on",Enable='off');

% theta4 - course angulaire [rad], [°]
th4_=1;
lbl_th4 = uilabel(tab2,Position=[xaxis(0) yaxis(12*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$\theta_{4}=\frac{3\pi\sigma_{adm}\sqrt{r}}{4E\sqrt{e}}$');
lbl_th4_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(12*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(th4_));
lbl_th4_val_deg = uilabel(tab2,Position=[xaxis(space_tab+120) yaxis(12*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(th4_*180/2/pi));
update_th4;

% k4 - rigidite
k4_=1;
lbl_k4 = uilabel(tab2,Position=[xaxis(0) yaxis(13*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$k_{4}=\frac{2bEe^{2.5}}{9\pi\sqrt{r}}$');
lbl_k4_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(13*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(k4_));
update_k4;


% == MASSE EQ ==
lbl_5 = uilabel(tab2,Text='Masse equivalente', ...
           Position=[xaxis(0) yaxis(14*space_down) 200 30],FontSize=font_label, ...
           WordWrap="on",Enable='off');

% meq - masse equivalente systeme
meq_=1;
lbl_meq = uilabel(tab2,Position=[xaxis(0) yaxis(15*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$m_{eq}=\frac{2J_r}{R_f^2}+2m_b+m_1+m_0+m_{MX}$');
lbl_meq_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(15*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(meq_));
update_meq;


% == FREQUENCE ==
lbl_6 = uilabel(tab2,Text='Fréquence du système', ...
           Position=[xaxis(0) yaxis(16*space_down) 200 30],FontSize=font_label, ...
           WordWrap="on",Enable='off');

% F - frequence systeme
F_=1;
lbl_F = uilabel(tab2,Position=[xaxis(0) yaxis(17*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$F=\frac{1}{2\pi}\sqrt{\frac{k_{eq}}{m_{eq}}}$');
lbl_F_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(17*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(F_));
update_F;

% == PUISSANCE ==
lbl_7 = uilabel(tab2,Text='Puissance', ...
           Position=[xaxis(0) yaxis(18*space_down) 200 30],FontSize=font_label, ...
           WordWrap="on",Enable='off');

% Pdis - Puissance dissipee
Pdis_=1;
lbl_Pdis = uilabel(tab2,Position=[xaxis(0) yaxis(19*space_down) 200 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text='$P_{dis}=\frac{8\pi^3F^3m_{eq}A^2}{Q}$');
lbl_Pdis_val = uilabel(tab2,Position=[xaxis(space_tab) yaxis(19*space_down) 500 50], ...
        FontSize=font_label,WordWrap="on",Enable="on",Interpreter='latex', ...
        Text=num2str(Pdis_));
update_Pdis;


% NESTED FUNCTIONS
    
    function update_f1
        f1_ = sigadm_*l_^2/3/E_/h_;
        write(lbl_f1_val,['= ',num2str(f1_)]);
    end

    function update_k1
        k1_ = 24*E_*I_/l_^3;
        write(lbl_k1_val,['= ',num2str(k1_)]);
    end

    function update_lamb1
        lamb1_ = 3*f1_^2/5/l_;
        write(lbl_lamb1_val,['= ',num2str(lamb1_)]);
    end

    function update_f2
        f2_ = sigadm_*l_^2/3/E_/h_;
        write(lbl_f2_val,['= ',num2str(f2_)])
    end

    function update_k2
        k2_ = 12*E_*I_/l_^3;
        write(lbl_k2_val,['= ',num2str(k2_)]);
    end

    function update_th3
        th3_ = sigadm_*l_^2/(E_*(2*h_*l_+3*h_*p_));
        write(lbl_th3_val,['= ',num2str(th3_),' [rad]']);
        write(lbl_th3_val_deg,['= ',num2str(th3_*360/2/pi),' [°]']);
    end

    function update_k3
        k3_ = 8*E_*I_*(l_^2+3*p_*l_+3*p_^2)/l_^3;
        write(lbl_k3_val,['= ',num2str(k3_)]);
    end

    function update_th4
        th4_ = 3*pi*sigadm_*sqrt(r_)/(4*E_*sqrt(e_));
        write(lbl_th4_val,['= ',num2str(th4_),' [rad]']);
        write(lbl_th4_val_deg,['= ',num2str(th4_*360/2/pi),' [°]']);
    end

    function update_k4
        k4_ = (2*b_*E_*e_^2.5)/(9*pi*sqrt(r_));
        write(lbl_k4_val,['= ',num2str(k4_)]);
    end

    function update_meq
        meq_ = 2*Jr_/Rf_^2+2*mb_+m1_+m0_+mmx_;
        write(lbl_meq_val,['= ',num2str(meq_)]);
    end

    function update_F
        F_ = 1/2/pi*sqrt(keq_/meq_);
        write(lbl_F_val,['= ',num2str(F_)]);
    end

    function update_Pdis
        Pdis_ = 4*pi^3*14^3*meq_*A_^2/Q_;
        write(lbl_Pdis_val,['= ',num2str(Pdis_)]);
    end

% =============================

    function update_E
        E_ = field_E.Value;
        write(lbl_E,[E_i,num2str(E_)]);
    end

    function update_sigD
        sigD_ = field_sigD.Value;
        lbl_sigD.Text=[sigD_i,num2str(sigD_)];
    end

    function update_sigadm
        sigadm_ = sigD_*1.2/2;
        lbl_sigadm.Text=[sigadm_i,num2str(sigadm_)];
    end

    function update_l
        l_ = field_l.Value;
        lbl_l.Text=[l_i,num2str(l_)];
    end

    function update_h
        h_ = field_h.Value;
        lbl_h.Text=[h_i,num2str(h_)];
    end

    function update_b
        b_ = field_b.Value;
        lbl_b.Text=[b_i,num2str(b_)];
    end

    function update_I
        I_ = b_*h_^3/12;
        lbl_I.Text=[I_i,num2str(I_)];
    end

    function update_p
        p_ = field_p.Value;
        lbl_p.Text=[p_i,num2str(p_)];
    end

    function update_e
        e_ = field_e.Value;
        lbl_e.Text=[e_i,num2str(e_)];
    end

    function update_r
        r_ = field_r.Value;
        lbl_r.Text=[r_i,num2str(r_)];
    end

    function update_rmax
        rmax_ = 5*e_;
        lbl_rmax.Text=[rmax_i,num2str(rmax_)];
    end

    function update_Jr
        Jr_ = field_Jr.Value;
        lbl_Jr.Text=[Jr_i,num2str(Jr_)];
    end

    function update_m0
        m0_ = field_m0.Value;
        lbl_m0.Text=[m0_i,num2str(m0_)];
    end

    function update_m1
        m1_ = field_m1.Value;
        lbl_m1.Text=[m1_i,num2str(m1_)];
    end

    function update_mb
        mb_ = field_mb.Value;
        lbl_mb.Text=[mb_i,num2str(mb_)];
    end

    function update_rho
        rho_ = field_rho.Value;
        lbl_rho.Text=[rho_i,num2str(rho_)];
    end

    function update_keq
        keq_ = field_keq.Value;
        lbl_keq.Text=[keq_i,num2str(keq_)];
    end

    function update_Rf
        Rf_ = field_Rf.Value;
        lbl_Rf.Text=[Rf_i,num2str(Rf_)];
    end

    function update_ec
        ec_ = field_ec.Value;
        lbl_ec.Text=[ec_i,num2str(ec_)];
    end

    function update_Rext
        Rext_ = field_Rext.Value;
        lbl_Rext.Text=[Rext_i,num2str(Rext_)];
    end

    function update_rho2
        rho2_ = field_rho2.Value;
        lbl_rho2.Text=[rho2_i,num2str(rho2_)];
    end

    function update_mmx
        mmx_ = rho2_*ec_*pi*Rext_^2;
        lbl_mmx.Text=[mmx_i,num2str(mmx_)];
    end

    function update_Q
        Q_ = field_Q.Value;
        lbl_Q.Text=[Q_i,num2str(Q_)];
    end

    function update_A
        A_ = field_A.Value;
        lbl_A.Text=[A_i,num2str(A_)];
    end


    % -
    
    function run
    update_E;
    update_sigD;
    update_sigadm;
    update_l;
    update_h;
    update_b;
    update_I;
    update_p;
    update_e;
    update_r;
    update_rmax;
    update_Jr;
    update_m0;
    update_m1;
    update_mb;
    update_rho;
    update_keq;
    update_Rf;
    update_ec;
    update_Rext;
    update_rho2;
    update_mmx;
    update_Q;
    update_A;


    update_f1;
    update_k1;
    update_lamb1;
    update_f2;
    update_k2;
    update_th3;
    update_k3;
    update_th4;
    update_k4;
    update_meq;
    update_F;
    update_Pdis;
    end
    
    function write(lbl,w)
    lbl.Text=w;
    end
    
    function newField(ef,lbl,lbl_i)
    write(lbl,[lbl_i,num2str(ef.Value)]);
    end

end



%{
% ============= TAB1 =============

% ID
lbl_ID = uilabel(tab1,Position=[10 100 200 30],FontSize=15,Text='ID :', ...
         Enable='off');
perso = uidropdown(tab1,'Position',[100 100 140 30],FontSize=15, ...
        Items={'Antonin','Arno','Arthur','Bastien','Benoit'});

%ef1 = uieditfield(tab1,Position=[500 60 100 30]);
%ef2 = uieditfield(tab1,Position=[10 400 100 30]);
member = uicheckbox(tab1,Position=[10 130 140 22],FontSize=15,Text='Member');

lbl_slider_out = uilabel(tab1,Position=[250 220 200 30],FontSize=15,Text='output', ...
                 Enable='off');
slider = uislider(tab1,Position=[10 220 120 3], ...
         ValueChangedFcn=@(slider,event) sliderChanged(slider,lbl_slider_out));

%}

% editfield1.Limits = [0 100];          set limits to data (by default are inclusive)
% ef1.ValueDisplayFormat='%.2f Volts';  displays 5.64 Volts for 6.6381 Volts

%{
    function sliderChanged(sl,lbl)
    lbl.Text = ['you choose ',num2str(sl.Value)];
    run;
    end
%}

%{
C=cell(2);
lbl_A = uitable(tab2,Position=[10 10 400 300],Data=C);
%}

