%for v_room=50:25:100 
v_room=50;
figure
i=1;
for cfm=0:20:100
%cfm=50;%v_room=60; % m^3
t=0:100:24*3600;
Ru=8.314;
%outside condition////////inlet condition
phi_0=0.9;      %humedity of outside air 
To=278;  %outside tempreture in kelven 
p=101.325 ;%preesur in kpas
psat_o=0.8725;%kpas
%Vin=0.0236; %inlet volume @cfm=50
ni=1.035;
ni_o2=0.21577;
ni_N2=0.81131;
ni_h2o=0.008021;
y_h2o_i=0.00775;
y_o2_i=0.2085;
y_co2_i=0;
y_n2_i=0.784;
%inside condition
Ti=298;  %inlet tempreture in kelven 
p=101.325;%preesur in kpas
phi_i=0.3;  %humedity of inside air 
psat_i=3.1698;%kpas
n_t_inside=p*v_room/(Ru*Ti)*1000;
y_h2o_inside=0.009385;
y_o2_inside=0.20802;
y_co2_inside=0;
y_n2_inside=0.7826;
%no_o2=n_t_inside*y_o2_inside;
%no_N2=n_t_inside*y_h2o_inside;
%no_h2o=n_t_inside*y_n2_inside;
%combustion 
no2_comb=0.009828;
nco2_comb=0.005962;
nh2o_comb=0.007722;
%outlet
no=0.9651667*t;%outlet van //%n_t_inside=2453.81;
format long
n_t_inlet=(p*cfm*(0.02831/60))/(Ru*To)*1000;
n_t_outlet=(p*cfm*(0.02831/60))/(Ru*Ti)*1000;
n_filltraion=n_t_inside-(p*v_room/(Ru*Ti)*1000);
no2=(n_t_inside*y_o2_inside)+(n_t_inlet*t*y_o2_i)-(n_t_outlet*t*y_o2_inside)-(t*no2_comb)-(n_filltraion*y_o2_inside);
nN2=n_t_inside*y_n2_inside+n_t_inlet*t*y_n2_i-n_t_outlet*t*y_n2_inside-n_filltraion*y_n2_inside;
nco2=n_t_inside*y_co2_inside-n_t_outlet*t*y_co2_inside+t*nco2_comb-n_filltraion*y_co2_inside;
nh2o=n_t_inside*y_h2o_inside+n_t_inlet*t*y_h2o_i-n_t_outlet*t*y_h2o_inside+t*nh2o_comb-n_filltraion*y_h2o_inside;
n_t_inside=no2+nN2+nco2+nh2o;
y_h2o_inside=nh2o./n_t_inside;
y_o2_inside=no2./n_t_inside;
y_co2_inside=nco2./n_t_inside;
y_n2_inside=nN2./n_t_inside;
linb={':r*','-.','-','--go',':','--g'};
grid on 
%xlabel('time,hr')
%ylabel('mole fraction of osygen yo2')
line_fewer_markers(t,y_o2_inside,10,linb{i}, 'Spacing', 'curve');
i=i+1;
legend('0cfm','20cfm','40cfm','60cfm','80cfm','100cfm');

hold on 
ylim([0 inf])
end
hline = refline([0 .115]);
hline.Color = 'r';
hline = refline([0 .195]);
hline.Color = 'b';
%end 



