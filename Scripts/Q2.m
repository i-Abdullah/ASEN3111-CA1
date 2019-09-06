%% question 2: NACA 0012

% you're given information about Cp disturbution NACA 0012 lower and upper
% surface estimate lift and drag using numerical integraiton,
% mainly Trapazoidal rule


%% define ocnstants

c = 2; % chord length [m]
alpha = 9; % AOA [Degrees]
V_inf = 30; % Free-stream flow speed [m/s]
roh_inf = 1.225; % Free-stream flow density [kg/m];
P_inf = 101.3*10^3 ; % dynamic pressure [Pa];


%%

% open up the spline function
Spline = open('Cp.mat');

% get upper and lower spline data
Cp_upper = Spline.Cp_upper;
Cp_lower = Spline.Cp_lower;


% since it was given that the airfoil is at 9-degrees AOA, we know that
% integration over the surface will give us normal and axial forces, and
% those can be converted to lift and drag using AOA.


% using equation 1.15, 1.16 from Anderson's Fundemental of aerodynamics,
% page 26 in 6th edition:

% TrapezoidalRule will give out results from definite integral, there's no
% need to concern ourselves with skin friction pressure for now.

numSeg = 100; % how many panels used to integrate?

Cn = (1/c) * ( TrapezoidalRule(Cp_upper,0,c,numSeg) - TrapezoidalRule(Cp_lower,0,c,numSeg) ) ;


%% 


Up = fnval(Cp_upper, [0:0.001:1]);
Down = fnval(Cp_lower, [0:0.001:1]);

plot([0:0.001:1],-Up,'LineWidth',2)
hold on
plot([0:0.001:1],-Down,'LineWidth',2)
ylabel('-C_p');
xlabel('x/c');
grid minor