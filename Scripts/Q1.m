%% question 1: estimate left and drage over a cylinder.

tic

%{

cylinder is at 0 angle of attack (AOA). Therfore, we can assume
that Lift = Normal force, Drag = Axial force, for the flow stream
velocity alligns with the chors.

A direct integration of the coefficients of pressure will hence
give us the coefficients of normal(lift) and axial(drag) forces.


It can be observed from figure in problem doc (go to /info) that
an integration over the circle from 0 to 2*pi will give us the
coefficients. Since Cp is given as function of theta, we can integrate
directly. Cp here can represent the vector field, the surface is the
circle.

%}

%% define constants

d = 1 ; % daiameter [m]
roh_inf = 1.255 ; % free-stream density [kg/m^3]
p_inf = 101.3*10^3 ; % static pressure [Pa]
V_inf = 30 ; % free-stream velocity [m/s]
q_inf = 1/2 * roh_inf * V_inf^2 ; % dynamic pressure [Pa]
c = d ; % chord length here = diameter [m].


%% solve: analytical
% the analytical sloution:

% we can see that since Cp will always be alligned radially with the center
% of the circle, that Cp*cos(theta) = drag, Cp*sin(theta) = lift.

syms th

%% QUESTIONS: 

% IS this below wrong trating Cp as Pressures? should we have instead done the
% method explained in 1.15, 1.16?

%%

Cp = 1 - 4*(sin(th)^2);
LiftCoeff = Cp * sin(th);
DragCoeff = Cp * cos(th);


% integrate symbolically:
Analytical_int_Cl = (1/c)*(d/2)*(int(LiftCoeff,[0 2*pi])); % this 1/c in the beggining is important to make the resultant non-dimensional.
Analytical_int_Cd = (1/c)*(d/2)*(int(Drag,[0 2*pi]));


% this analytical sloution can be used to quantify the error.


%% solve: numerical

% using Simpson's rule.
Numerical_int_Cl = (1/c)*(d/2)*SimpsonsLine(LiftCoeff,10,0,2*pi);
Numerical_int_Cd = (1/c)*(d/2)*SimpsonsLine(Drag,10,0,2*pi);

% d/2 is raduis, pulled out of series because it's constant.

%% estimate Lift and Drag

Numerical_D = Numerical_int_Cd * (1/2) * roh_inf * V_inf^2 * (pi*(d/2)^2) ;
Numerical_L = Numerical_int_Cl * (1/2) * roh_inf * V_inf^2 * (pi*(d/2)^2) ;


%% see how accurate is numerical integration:

for i = 1:30
    
Numerical_int_Cl_Different_N(i) = (d/2)*SimpsonsLine(LiftCoeff,i,0,2*pi);
Numerical_int_Cd_Different_N(i) = (d/2)*SimpsonsLine(Drag,i,0,2*pi);
Different_N(i) = i;
    
    
end

Numerical_D_Different_N =  Numerical_int_Cd_Different_N .* (1/2) * roh_inf * V_inf^2 * (d) ;
Numerical_L_Different_N = Numerical_int_Cl_Different_N .* (1/2) * roh_inf * V_inf^2 * (d) ;



subplot(2,1,1)
plot(Different_N,Numerical_D_Different_N,'r-*')
xlabel('Number of panels');
ylabel('Drag [N]')
grid minor
title('Numerical integration for pressure distributions to obtain drag and lift over a cylinder')

subplot(2,1,2)
plot(Different_N,Numerical_L_Different_N,'k->')
xlabel('Number of panels');
ylabel('Lift [N]')
grid minor

toc
%%
