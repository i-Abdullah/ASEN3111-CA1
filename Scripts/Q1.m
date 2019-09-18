%% question 1: estimate left and drage over a cylinder.



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

%% housekeeping

clear
clc
close all

tic

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
Cl = Cp * sin(th);
Cd = Cp * cos(th);


% integrate symbolically:
Analytical_int_Cl = (1/c)*(d/2)*(int(Cl,[0 2*pi])); % this 1/c in the beggining is important to make the resultant non-dimensional.
Analytical_int_Cd = (1/c)*(d/2)*(int(Cd,[0 2*pi]));


% this analytical sloution can be used to quantify the error.

Analytical_L =  Analytical_int_Cl * (1/2) * roh_inf * V_inf^2 * (c);
Analytical_D =  Analytical_int_Cd * (1/2) * roh_inf * V_inf^2 * (c);

%% solve: numerical

% the following is just for testing:

% using Simpson's rule.
Numerical_int_Cl = (1/c)*(d/2)*CompositeSimpsons(Cl,10,0,2*pi);
Numerical_int_Cd = (1/c)*(d/2)*CompositeSimpsons(Cd,10,0,2*pi);

% d/2 is raduis, pulled out of series because it's constant.

% estimate Lift and Drag
Numerical_D = Numerical_int_Cd * (1/2) * roh_inf * V_inf^2 * (c);
Numerical_L = Numerical_int_Cl * (1/2) * roh_inf * V_inf^2 * (c);


%% see how accurate is numerical integration:
j = 1;
for i = 1:1:10
   
Numerical_int_Cl_Different_N(j) = (1/c)*(d/2)*CompositeSimpsons(Cl,i,0,2*pi);
Numerical_int_Cd_Different_N(j) = (1/c)*(d/2)*CompositeSimpsons(Cd,i,0,2*pi);
Different_N(j) = i; % store number of panels
    j = j+1;
    
end

Numerical_D_Different_N =  Numerical_int_Cd_Different_N .* (1/2) * roh_inf * V_inf^2 * (d) ;
Numerical_L_Different_N = Numerical_int_Cl_Different_N .* (1/2) * roh_inf * V_inf^2 * (d) ;



figure(1)
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

%% relative error:

% relative error would be taken relative to analytical sloution.

Error_L = double(abs(Numerical_L_Different_N - Analytical_L )) ;
Error_D = double(abs(Numerical_D_Different_N - Analytical_D )) ;

%% determine number of panels needed:

Tolerance = 0.001; % tolerance we need to be within;

Condition_Error_D = find(diff(Error_D<Tolerance)==1);

if isempty(Condition_Error_D) == 1    
    % if it converges immeaditly then pick number of panels == 1;
    Condition_Error_D = 1;
else
    % if it doesn't, see where it does.
    Condition_Error_D = Condition_Error_D(end);
end


% check when lift converges


Condition_Error_L = find(diff(Error_L<Tolerance)==1);

if isempty(Condition_Error_L) == 1 
    Condition_Error_L = 1;
    
else
    Condition_Error_L = Condition_Error_L(end);
end



%% ptrinout results

fprintf('-=-=-=-=-=-=( Question 1 ) -=-=-=-=-=-=-=-=-=-=-=-');
fprintf('\n \n')

toc

% Printout results
fprintf(['Number of panels for Drag to be within ' num2str(Tolerance) 'N is: ' num2str(Different_N(Condition_Error_D))]);
fprintf('\n')

fprintf(['Number of panels for Lift to be within ' num2str(Tolerance) 'N is: ' num2str(Different_N(Condition_Error_L))]);
fprintf('\n \n')

fprintf('-=-=-=-=-=-=( END ) -=-=-=-=-=-=-=-=-=-=-=-');
fprintf('\n \n \n')
